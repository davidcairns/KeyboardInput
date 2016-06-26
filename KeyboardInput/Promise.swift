import Foundation
import Dispatch

public func doAsync<T>(block: () -> T, then: T -> ()) {
	let queue = dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0)
	dispatch_async(queue) {
		let result = block()
		dispatch_async(dispatch_get_main_queue()) {
			then(result)
		}
	}
}


/// A Promise is just a one-shot Stream.
public func Promise<T>(produce: () -> T) -> Stream<T> {
	let stream = Stream<T>()
	
	doAsync(produce) {
		stream.emit($0)
		stream.finish()
	}
	
	return stream
}
