import Foundation

public final class Timer {
	var timer_source: DispatchSourceTimer
	
	public init(interval: TimeInterval, repeating: Bool, block: @escaping () -> ()) {
		self.timer_source = DispatchSource.makeTimerSource(flags: DispatchSource.TimerFlags(rawValue: UInt(0)), queue: DispatchQueue.main)
		// First fire should be `interval` seconds in the future.
		let interval_nsec = Int(Double(interval) * Double(NSEC_PER_SEC))
    let interval_time: DispatchTimeInterval = .nanoseconds(interval_nsec)
    let startTime: DispatchTime = DispatchTime.now() + interval_time
    if repeating {
      self.timer_source.scheduleRepeating(deadline: startTime, interval: interval_time)
    }
    else {
      self.timer_source.scheduleOneshot(deadline: startTime)
    }

		self.timer_source.setEventHandler {
			block()
			if !repeating {
				self.cancel()
			}
		}
	}
	public convenience init(repeatingEvery interval: TimeInterval, block: @escaping () -> ()) {
		self.init(interval: interval, repeating: true, block: block)
	}
	public convenience init(oneShotAfterInterval interval: TimeInterval, block: @escaping () -> ()) {
		self.init(interval: interval, repeating: false, block: block)
	}
	
	deinit {
		self.timer_source.cancel()
	}
	
	public func start() {
		self.timer_source.resume()
	}
	
	public var valid = true
	public func cancel() {
		self.timer_source.cancel()
		self.valid = false
	}
}
