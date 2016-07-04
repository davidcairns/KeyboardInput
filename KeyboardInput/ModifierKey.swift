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
  case Command
  case Shift
  case CapsLock
  case Option
  case Control
  case RightShift
  case RightOption
  case RightControl
  case Function

  var key: Key {
    switch self {
    case Command: return Key.Command
    case Shift: return Key.Shift
    case .CapsLock: return Key.CapsLock
    case Option: return Key.Option
    case Control: return Key.Control
    case RightShift: return Key.RightShift
    case RightOption: return Key.RightOption
    case RightControl: return Key.RightControl
    case Function: return Key.Function
    }
  }
}


extension ModifierKey {
  var toFlagVal: UInt64 {
    switch self {
    case Command: return CGEventFlags.MaskCommand.rawValue
    case Shift: return CGEventFlags.MaskShift.rawValue
    case CapsLock: return CGEventFlags.MaskAlphaShift.rawValue
    case Option: return CGEventFlags.MaskAlternate.rawValue
    case Control: return CGEventFlags.MaskControl.rawValue
    case RightShift: return CGEventFlags.MaskShift.rawValue
    case RightOption: return CGEventFlags.MaskAlternate.rawValue
    case RightControl: return CGEventFlags.MaskControl.rawValue
    case Function: return CGEventFlags.MaskSecondaryFn.rawValue
    }
  }
  var toFlag: CGEventFlags {
    return CGEventFlags(rawValue: self.toFlagVal)!
  }
  static func ToFlags(modifiers: [ModifierKey]) -> CGEventFlags {
    let flags: UInt64 = modifiers.reduce(0) { $0 | $1.toFlagVal }
    return CGEventFlags(rawValue: flags)!
  }
}
