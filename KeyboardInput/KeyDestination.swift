//
//  KeyDestination.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/24/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Cocoa

final class KeyDestination {
  let app: NSRunningApplication

  init(app: NSRunningApplication) {
    self.app = app
  }

  func post(_ keyCode: UInt16, flags: CGEventFlags = CGEventFlags(rawValue: 0), isDown: Bool) {
    // Create an key event with this code (& flags) and post it to our app’s process.
    // TODO: Create key events using CGSCreateKeyboardEventOfLength? (I have gotten warnings in the console about this…) --DRC
    guard let eventSource = CGEventSource(stateID: CGEventSourceStateID.combinedSessionState) else {
      print("ERROR: nil CGEventSource!")
      return
    }

    let keyEvent: CGEvent = CGEvent(keyboardEventSource: eventSource, virtualKey: CGKeyCode(keyCode), keyDown: isDown)!
    keyEvent.flags = flags
    keyEvent.postToPid(self.app.processIdentifier)

    // Maybe this is a dumb way to solve this, but let's sleep for just a moment so they events don’t arrive out of order.
    usleep(100)
  }
}
