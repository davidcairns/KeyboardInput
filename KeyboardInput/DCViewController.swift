//
//  DCViewController.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/24/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import AppKit


func GetTerminalApp() -> NSRunningApplication! {
  return NSRunningApplication.app(withBundleIdentifier: "com.apple.Terminal")
}

let AUTO_BREAK_TIME = 1.1

public final class DCViewController : NSViewController {
  let commandProcessor: CommandProcessor

  public required init?(coder: NSCoder) {
    self.commandProcessor = CommandProcessor(commandRecognizers: VimCompatibleCommands)

    // Connect our command processor’s output stream.
    // ENABLE THESE LINES FOR WRITING TO TERMINAL!!!
    let keyboardOutStream: Stream<String> = {
      let stream = Stream<String>()
      let keyboard = Keyboard(destination: KeyDestination(app: GetTerminalApp()))
      stream.subscribe { keyboard.handleKeyPresses(KeyPress.from(string: $0)) }
      return stream
    }()
    self.commandProcessor.outputStream.subscribe(keyboardOutStream)
//    self.commandProcessor.outputStream.subscribe { print("\($0)", terminator: "") }

    super.init(coder: coder)
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    // For some reason, we need specifically to request to receive these events.
    // FIXME: Maybe we should move all this code into the WindowController? --DRC
    NSEvent.addLocalMonitorForEventsMatchingMask(.KeyDownMask) { (event) in
      self.keyDown(event)
      return event
    }
    NSEvent.addLocalMonitorForEventsMatchingMask(.KeyUpMask) { (event) in
      self.keyUp(event)
      return event
    }
    NSEvent.addLocalMonitorForEventsMatchingMask(.FlagsChangedMask) { (event) in
      self.flagsChanged(event)
      return event
    }
  }


  // MARK: - "Break" timer
  class func scheduledBreakTimer(on on: DCViewController) -> NSTimer {
    return NSTimer.scheduledTimerWithTimeInterval(AUTO_BREAK_TIME, target: on, selector: #selector(DCViewController.insertBreak), userInfo: nil, repeats: false)
  }
  func rescheduleBreakTimer() {
    if let t = self.breakTimer { t.invalidate() }
    self.breakTimer = DCViewController.scheduledBreakTimer(on: self)
  }
  var breakTimer: NSTimer! = nil
  public func insertBreak() {
    // Flush the current word and insert a break.
    self.commandProcessor.flushCurrentWord()

    print("<!>", terminator: "")
    self.commandProcessor.inputStream.emit(InputElement.Break)
  }
  

  // MARK: - Raw events
  public override func keyDown(theEvent: NSEvent) {
    // The user just did something... reschedule the break timer!
    rescheduleBreakTimer()
  }

  public override func keyUp(theEvent: NSEvent) {
    self.commandProcessor.appendCharacter((theEvent.characters ?? ""))

    // The user just did something... reschedule the break timer!
    rescheduleBreakTimer()
  }
}
