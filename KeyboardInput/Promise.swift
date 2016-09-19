import Foundation
import Dispatch

public func doAsync<T>(_ block: @escaping () -> T, then: @escaping (T) -> ()) {
	let queue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
	queue.async {
		let result = block()
		DispatchQueue.main.async {
			then(result)
		}
	}
}


/// A Promise is just a one-shot Stream.
public func Promise<T>(_ produce: @escaping () -> T) -> Stream<T> {
	let stream = Stream<T>()
	
	doAsync(produce) {
		stream.emit($0)
		stream.finish()
	}
	
	return stream
}
