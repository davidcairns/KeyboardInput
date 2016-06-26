//
//  KeyDestination.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/24/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

final class KeyDestination {
  let app: NSRunningApplication

  init(app: NSRunningApplication) {
    self.app = app
  }

  func post(keyCode: UInt16, flags: CGEventFlags = CGEventFlags(rawValue: 0)!, isDown: Bool) {
    // Post a key-down, followed by a key-up.
    let keyEvent: CGEventRef = CGEventCreateKeyboardEvent(nil, CGKeyCode(keyCode), isDown)!
    CGEventSetFlags(keyEvent, flags)
    CGEventPostToPSN(self.app.processSerialNumber.ptr(), keyEvent)
  }
}
