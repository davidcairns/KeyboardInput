//
//  ModifierKey.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/29/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

// This enum just wraps some of the Keys so we can specify when something should definitely only be a modifier.
public enum ModifierKey {
  case command
  case shift
  case capsLock
  case option
  case control
  case rightShift
  case rightOption
  case rightControl
  case function

  var key: Key {
    switch self {
    case .command: return Key.command
    case .shift: return Key.shift
    case .capsLock: return Key.capsLock
    case .option: return Key.option
    case .control: return Key.control
    case .rightShift: return Key.rightShift
    case .rightOption: return Key.rightOption
    case .rightControl: return Key.rightControl
    case .function: return Key.function
    }
  }
}


extension ModifierKey {
  var toFlagVal: UInt64 {
    switch self {
    case .command: return CGEventFlags.maskCommand.rawValue
    case .shift: return CGEventFlags.maskShift.rawValue
    case .capsLock: return CGEventFlags.maskAlphaShift.rawValue
    case .option: return CGEventFlags.maskAlternate.rawValue
    case .control: return CGEventFlags.maskControl.rawValue
    case .rightShift: return CGEventFlags.maskShift.rawValue
    case .rightOption: return CGEventFlags.maskAlternate.rawValue
    case .rightControl: return CGEventFlags.maskControl.rawValue
    case .function: return CGEventFlags.maskSecondaryFn.rawValue
    }
  }
  var toFlag: CGEventFlags {
    return CGEventFlags(rawValue: self.toFlagVal)
  }
  static func ToFlags(_ modifiers: [ModifierKey]) -> CGEventFlags {
    let flags: UInt64 = modifiers.reduce(0) { $0 | $1.toFlagVal }
    return CGEventFlags(rawValue: flags)
  }
}
