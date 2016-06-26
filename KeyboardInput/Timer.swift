import Foundation

public class Timer {
	var timer_source: dispatch_source_t!
	
	public init(interval: NSTimeInterval, repeating: Bool, block: () -> ()) {
		self.timer_source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue())
		// First fire should be `interval` seconds in the future.
		let interval_nsec = UInt64(Double(interval) * Double(NSEC_PER_SEC))
		let startTime = dispatch_time(DISPATCH_TIME_NOW, Int64(interval_nsec))
		let leeway: UInt64 = 0
		dispatch_source_set_timer(self.timer_source, startTime, interval_nsec, leeway)
		dispatch_source_set_event_handler(self.timer_source) {
			block()
			if !repeating {
				self.cancel()
			}
		}
	}
	public convenience init(repeatingEvery interval: NSTimeInterval, block: () -> ()) {
		self.init(interval: interval, repeating: true, block: block)
	}
	public convenience init(oneShotAfterInterval interval: NSTimeInterval, block: () -> ()) {
		self.init(interval: interval, repeating: false, block: block)
	}
	
	deinit {
		dispatch_source_cancel(self.timer_source)
	}
	
	public func start() {
		dispatch_resume(self.timer_source)
	}
	
	public var valid = true
	public func cancel() {
		dispatch_source_cancel(self.timer_source)
		self.valid = false
	}
}
