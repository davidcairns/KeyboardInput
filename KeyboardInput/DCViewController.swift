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

      // Get the Terminal -- if we can't, bail!
      let terminalApp = GetTerminalApp()
      if nil == terminalApp { abort() }

      // Get a Keyboard interface to Terminal.
      let keyboard = Keyboard(destination: KeyDestination(app: terminalApp!))

      stream.subscribe {
        let keyPress = KeyPress.from(string: $0)
        keyboard.handleKeyPresses(keyPress)
      }
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
    NSEvent.addLocalMonitorForEvents(matching: .keyDown) { (event) in
      self.keyDown(with: event)
      return event
    }
    NSEvent.addLocalMonitorForEvents(matching: .keyUp) { (event) in
      self.keyUp(with: event)
      return event
    }
    NSEvent.addLocalMonitorForEvents(matching: .flagsChanged) { (event) in
      self.flagsChanged(with: event)
      return event
    }
  }


  // MARK: - "Break" timer
  class func scheduledBreakTimer(on: DCViewController) -> Foundation.Timer {
    return Foundation.Timer.scheduledTimer(timeInterval: AUTO_BREAK_TIME, target: on, selector: #selector(DCViewController.insertBreak), userInfo: nil, repeats: false)
  }
  func rescheduleBreakTimer() {
    if let t = self.breakTimer { t.invalidate() }
    self.breakTimer = DCViewController.scheduledBreakTimer(on: self)
  }
  var breakTimer: Foundation.Timer! = nil
  public func insertBreak() {
    // Flush the current word and insert a break.
    self.commandProcessor.flushCurrentWord()

    print("<!>", terminator: "")
    self.commandProcessor.inputStream.emit(InputElement.break)
  }
  

  // MARK: - Raw events
  public override func keyDown(with theEvent: NSEvent) {
    // The user just did something... reschedule the break timer!
    rescheduleBreakTimer()
  }

  public override func keyUp(with theEvent: NSEvent) {
    self.commandProcessor.appendCharacter((theEvent.characters ?? ""))

    // The user just did something... reschedule the break timer!
    rescheduleBreakTimer()
  }
}
