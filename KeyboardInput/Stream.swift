import Foundation
import Dispatch

enum EmissionValue <T> {
	case just(T)
	case error(Error)
	case completed
}

internal struct Emission <T> {
	let timestamp: TimeInterval
	var _value: EmissionValue<T>
	var value: T? {
		switch _value {
			case .just(let x): return x
			default: return nil
		}
	}
	var isCompleted: Bool {
		switch _value {
			case .completed: return true
			default: return false
		}
	}
	
	init(timestamp: TimeInterval, emissionValue: EmissionValue<T>) {
		self.timestamp = timestamp
		self._value = emissionValue
	}
	init(timestamp: TimeInterval, value: T) {
		self.init(timestamp: timestamp, emissionValue: .just(value))
	}
}

open class Stream <T> {
	public typealias BlockType = (T) -> ()
	typealias EmissionBlockType = (Emission<T>) -> ()
	var blocks: [EmissionBlockType] = []
	
	public init() {}
	
	internal func emit(_ value: EmissionValue<T>) {
		let timestamp = Date.timeIntervalSinceReferenceDate
		let emission = Emission(timestamp: timestamp, emissionValue: value)
		for block in blocks {
			block(emission)
		}
		
		if case EmissionValue<T>.completed = value {
			blocks.removeAll()
		}
	}
	
	open func emit(_ value: T) {
		emit(EmissionValue.just(value))
	}
	
	open func error(_ error: Error) {
		emit(EmissionValue.error(error))
	}
	
	open func finish() {
		emit(EmissionValue.completed)
	}
	
	func subscribeTo(_ block: @escaping EmissionBlockType) {
		blocks.append(block)
	}
	open func subscribe(_ block: @escaping BlockType) {
		subscribeTo { emission in
			if let v = emission.value {
				block(v)
			}
		}
	}
	open func subscribe(_ stream: Stream<T>) {
		subscribe { stream.emit($0) }
	}
}

extension Stream {
	public func emit(_ array: [T]) {
		for x in array {
			self.emit(x)
		}
	}
}


// Holds onto the last value emitted.
open class Signal <T> : Stream <T> {
	var value: T?
	public init(_ value: T) {
		self.value = value
	}
	public override init() {
		self.value = nil
	}
	
	override open func emit(_ value: T) {
		self.value = value
		super.emit(value)
	}
	open func set(_ value: T) {
		self.emit(value)
	}
}

internal func setSignal<T>(_ signal: Signal<T>, value: T) {
	signal.set(value)
}
infix operator <~ { associativity left }
public func <~ <T> (lhs: Signal<T>, rhs: T) {
	setSignal(lhs, value: rhs)
}


public final class SequenceStream <T> : Stream <T> {
	var items: [T]
	public init(items: [T]) {
		self.items = items
	}
	
	override func subscribeTo(_ block: @escaping EmissionBlockType) {
		for item in items {
			block(Emission(timestamp: 0, value: item))
		}
		
		blocks.append(block)
	}
}


public extension Stream {
	/// Use f to map a Stream<T> to a Stream<U>
	public func map <U> (_ f: @escaping (T) -> U) -> Stream<U> {
		let stream = Stream<U>()
		self.subscribe { x in 
			stream.emit(f(x))
		}
		return stream
	}
	
	/// Produce a Stream<T> that only contains elements passing the predicate.
	public func filter(_ predicate: @escaping (T) -> Bool) -> Stream<T> {
		let stream = Stream<T>()
		self.subscribe { x in
			if predicate(x) {
				stream.emit(x)
			}
		}
		return stream
	}
	
	public func reduce <U> (_ initial: U, combiner: @escaping (U, T) -> U) -> Stream<U> {
		let stream = Signal<U>(initial)
		self.subscribe { x in
			stream.emit(combiner(stream.value!, x))
		}
		return stream
	}
}

// Allows two Streams to map together into a single Stream, using a combiner.
public func map2 <T, U, V> (_ lhs: Stream<T>, _ rhs: Stream<U>, combiner: @escaping (T, U) -> V) -> Stream<V> {
	let last_left = Signal<T>()
	lhs.subscribe(last_left)
	let last_right = Signal<U>()
	rhs.subscribe(last_right)
	
	let stream = Stream<V>()
	let do_combiner = {
		if let l = last_left.value, let r = last_right.value {
			stream.emit(combiner(l, r))
		}
	}
	last_left.subscribe { _ in do_combiner() }
	last_right.subscribe { _ in do_combiner() }
	
	return stream
}
// Convenience functions for doing Boolean operations with Bool-based streams.
public func and(_ lhs: Stream<Bool>, _ rhs: Stream<Bool>) -> Stream<Bool> {
	return map2(lhs, rhs) { $0 && $1 }
}
public func or(_ lhs: Stream<Bool>, _ rhs: Stream<Bool>) -> Stream<Bool> {
	return map2(lhs, rhs) { $0 || $1 }
}
public func xor(_ lhs: Stream<Bool>, _ rhs: Stream<Bool>) -> Stream<Bool> {
	return map2(lhs, rhs) { ($0 && !$1) || (!$0 && $1) }
}




public func stream_sum <T, U> (_ lhs: Stream <T>, rhs: Stream <U>) -> 
														Stream <Either<T, U>> {
	let s = Stream<Either<T, U>>()
	
	// Whenever either stream emits a value, post it to the combined stream.
	lhs.subscribe { (val: T) in
		s.emit(Either<T, U>.Left(val))
	}
	rhs.subscribe { (val: U) in
		s.emit(Either<T, U>.Right(val))
	}
	
	return s
}
public func + <T, U> (lhs: Stream <T>, rhs: Stream <U>) -> Stream <Either<T, U>> {
	return stream_sum(lhs, rhs: rhs)
}


public func stream_product <T, U> (_ lhs: Stream <T>, rhs: Stream <U>) -> Stream <(T, U)> {
	return map2(lhs, rhs) { ($0, $1) }
}
public func * <T, U> (lhs: Stream <T>, rhs: Stream <U>) -> Stream <(T, U)> {
	return stream_product(lhs, rhs: rhs)
}


public extension Stream {
	public func zipWith <U, V> (_ other: Stream<U>, f: @escaping (T, U) -> V) -> Stream<V> {
		let left_and_right = self * other
		let composite = Stream<V>()
		left_and_right.subscribe { (left: T, right: U) in
			let combined: V = f(left, right)
			composite.emit(combined)
		}
		return composite
	}
}


final class ThrottledSignal <T> : Signal <T> {
	let interval: TimeInterval
	var timer: Timer? = nil
	
	init(interval: TimeInterval) {
		self.interval = interval
		super.init()
		self.actuallyEmitAfterInterval()
	}
	
	override func emit(_ value: T) {
		self.value = value
		
		// If we do not have a timer, create one.
		if nil == self.timer {
			self.actuallyEmitAfterInterval()
		}
	}
	
	func actuallyEmitAfterInterval() {
		self.timer = Timer(oneShotAfterInterval: self.interval) {
			if let value = self.value {
				super.emit(value)
			}
			self.timer = nil
		}
		self.timer!.start()
	}
}

public extension Stream {
	// Ensures that downstream subscriber blocks aren't called more than once every 'interval' seconds.
	// Note that this will throw away intermediate states and only pass the last-emitted value!
	public func throttle(by interval: TimeInterval) -> Stream<T> {
		let throttled = ThrottledSignal<T>(interval: interval)
		self.subscribe(throttled)
		return throttled
	}
}


/// Inlines emissions from a stream-of-streams into a single stream.
public func flatten <T> (_ stream: Stream<Stream<T>>) -> Stream<T> {
	let flattened = Stream<T>()
	// Every time our stream-of-streams emits a value (a stream), ...
	stream.subscribe { s in
		// ... our flattened stream should emit that value.
		s.subscribe(flattened)
	}
	return flattened
}

/// Inlines emissions from a stream-of-arrays into a single stream.
public func flatten <T> (_ stream: Stream<[T]>) -> Stream<T> {
	let flattened = Stream<T>()
	stream.subscribe {
		for val in $0 {
			flattened.emit(val)
		}
	}
	return flattened
}

/// Inlines emissions from an array-of-streams into a single stream.
public func flatten <T> (_ array: [Stream<T>]) -> Stream<T> {
	let flattened = Stream<T>()
	for stream in array {
		stream.subscribe {
			flattened.emit($0)
		}
	}
	return flattened
}

extension Stream {
	/// Mapping each entry of a Stream<T> produces a Stream<U>, the emissions of which we collate as a single Stream<U>. 
	// e.g.: map Stream<T> -> Stream<Stream<U>>; flatten to Stream<U>.
	public func flatMap <U> (_ f: @escaping (T) -> Stream<U>) -> Stream<U> {
		return flatten(self.map(f))
	}
}
