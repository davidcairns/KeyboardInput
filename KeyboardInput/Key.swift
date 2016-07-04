//
//  Key.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/29/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

public enum Key {
  case A
  case S
  case D
  case F
  case H
  case G
  case Z
  case X
  case C
  case V
  case B
  case Q
  case W
  case E
  case R
  case Y
  case Tee // "T" conflicts with some kind of internal Swift thing >_<
  case One
  case Two
  case Three
  case Four
  case Five
  case Six
  case Equals
  case Nine
  case Seven
  case Dash
  case Eight
  case Zero
  case RightBracket
  case O
  case U
  case LeftBracket
  case I
  case P
  case L
  case J
  case Quote
  case K
  case Semicolon
  case Backslash
  case Comma
  case Slash
  case N
  case M
  case Period
  case Grave
  case KeypadDecimal
  case KeypadMultiply
  case KeypadPlus
  case KeypadClear
  case KeypadDivide
  case KeypadEnter
  case KeypadMinus
  case KeypadEquals
  case Keypad0
  case Keypad1
  case Keypad2
  case Keypad3
  case Keypad4
  case Keypad5
  case Keypad6
  case Keypad7
  case Keypad8
  case Keypad9

  /* keycodes for keys that are independent of keyboard layout*/
  case Return
  case Tab
  case Space
  case Delete
  case Escape
  case Command
  case Shift
  case CapsLock
  case Option
  case Control
  case RightShift
  case RightOption
  case RightControl
  case Function
  case F17
  case VolumeUp
  case VolumeDown
  case Mute
  case F18
  case F19
  case F20
  case F5
  case F6
  case F7
  case F3
  case F8
  case F9
  case F11
  case F13
  case F16
  case F14
  case F10
  case F12
  case F15
  case Help
  case Home
  case PageUp
  case ForwardDelete
  case F4
  case End
  case F2
  case PageDown
  case F1
  case LeftArrow
  case RightArrow
  case DownArrow
  case UpArrow

  // The following were discovered using the Key Codes app
  case Backspace
  case Enter
  case LessThan
  case GreaterThan
  case LeftBrace
  case RightBrace
  case RightParen
  case LeftParen
  case Bang
  case Pipe
  case Colon
  case Backtick
  case Apostrophe
  case Ampersand
  case Percent
  case QuestionMark
  case Splat
  case Tilde
  case At
  case Dollar
  case Caret
  case Plus
  case Hash


  var keyCode: CGKeyCode {
    switch self {
    case A : return 0x00
    case S : return 0x01
    case D : return 0x02
    case F : return 0x03
    case H : return 0x04
    case G : return 0x05
    case Z : return 0x06
    case X : return 0x07
    case C : return 0x08
    case V : return 0x09
    case B : return 0x0B
    case Q : return 0x0C
    case W : return 0x0D
    case E : return 0x0E
    case R : return 0x0F
    case Y : return 0x10
    case Tee : return 0x11  // (see comment above about using "T"!)
    case One : return 0x12
    case Two : return 0x13
    case Three : return 0x14
    case Four : return 0x15
    case Five : return 0x17
    case Six : return 0x16
    case Equals : return 0x18
    case Nine : return 0x19
    case Seven : return 0x1A
    case Dash : return 0x1B
    case Eight : return 0x1C
    case Zero : return 0x1D
    case RightBracket : return 0x1E
    case O : return 0x1F
    case U : return 0x20
    case LeftBracket : return 0x21
    case I : return 0x22
    case P : return 0x23
    case L : return 0x25
    case J : return 0x26
    case Quote : return 0x27
    case K : return 0x28
    case Semicolon : return 0x29
    case Backslash : return 0x2A
    case Comma : return 0x2B
    case Slash : return 0x2C
    case N : return 0x2D
    case M : return 0x2E
    case Period : return 0x2F
    case Grave : return 0x32
    case KeypadDecimal : return 0x41
    case KeypadMultiply : return 0x43
    case KeypadPlus : return 0x45
    case KeypadClear : return 0x47
    case KeypadDivide : return 0x4B
    case KeypadEnter : return 0x4C
    case KeypadMinus : return 0x4E
    case KeypadEquals : return 0x51
    case Keypad0 : return 0x52
    case Keypad1 : return 0x53
    case Keypad2 : return 0x54
    case Keypad3 : return 0x55
    case Keypad4 : return 0x56
    case Keypad5 : return 0x57
    case Keypad6 : return 0x58
    case Keypad7 : return 0x59
    case Keypad8 : return 0x5B
    case Keypad9 : return 0x5C

      /* keycodes for keys that are independent of keyboard layout*/
    case Return : return 0x24
    case Tab : return 0x30
    case Space : return 0x31
    case Delete : return 0x33
    case Escape : return 0x35
    case Command : return 0x37
    case Shift : return 0x38
    case CapsLock : return 0x39
    case Option : return 0x3A
    case Control : return 0x3B
    case RightShift : return 0x3C
    case RightOption : return 0x3D
    case RightControl : return 0x3E
    case Function : return 0x3F
    case F17 : return 0x40
    case VolumeUp : return 0x48
    case VolumeDown : return 0x49
    case Mute : return 0x4A
    case F18 : return 0x4F
    case F19 : return 0x50
    case F20 : return 0x5A
    case F5 : return 0x60
    case F6 : return 0x61
    case F7 : return 0x62
    case F3 : return 0x63
    case F8 : return 0x64
    case F9 : return 0x65
    case F11 : return 0x67
    case F13 : return 0x69
    case F16 : return 0x6A
    case F14 : return 0x6B
    case F10 : return 0x6D
    case F12 : return 0x6F
    case F15 : return 0x71
    case Help : return 0x72
    case Home : return 0x73
    case PageUp : return 0x74
    case ForwardDelete : return 0x75
    case F4 : return 0x76
    case End : return 0x77
    case F2 : return 0x78
    case PageDown : return 0x79
    case F1 : return 0x7A
    case LeftArrow : return 0x7B
    case RightArrow : return 0x7C
    case DownArrow : return 0x7D
    case UpArrow : return 0x7E

    // The following were discovered using the Key Codes app
    case Backspace : return 0x33
    case Enter : return 0x24
    case LessThan : return 0x2B
    case GreaterThan : return 0x2F
    case LeftBrace : return 0x21
    case .RightBrace : return 0x1E
    case RightParen : return 0x1D
    case LeftParen : return 0x19
    case Bang : return 0x12
    case Pipe : return 0x2A
    case Colon : return 0x29
    case Backtick : return 0x32
    case Apostrophe : return 0x27
    case Ampersand : return 0x1A
    case Percent : return 0x17
    case QuestionMark : return 0x2C
    case Splat : return 0x1C
    case Tilde : return 0x32
    case At : return 0x13
    case Dollar : return 0x15
    case Caret : return 0x16
    case Plus : return 0x18
    case Hash : return 0x14
    }
  }

  var needsShift: Bool {
    switch self {
      case .Quote:                    fallthrough
      case .LessThan:                 fallthrough
      case .GreaterThan:              fallthrough
      case .LeftBrace:                fallthrough
      case .RightBrace:               fallthrough
      case .RightParen:               fallthrough
      case .LeftParen:                fallthrough
      case .Bang:                     fallthrough
      case .Pipe:                     fallthrough
      case .Colon:                    fallthrough
      case .Ampersand:                fallthrough
      case .Percent:                  fallthrough
      case .QuestionMark:             fallthrough
      case .Splat:                    fallthrough
      case .Tilde:                    fallthrough
      case .At:                       fallthrough
      case .Dollar:                   fallthrough
      case .Caret:                    fallthrough
      case .Plus:                     fallthrough
      case .Hash:                                 return true

      default: return false
    }
  }

  static func from(character character: Character) -> Key? {
    return from(string: String(character))
  }

  static func from(string string: String) -> Key? {
    switch string.uppercaseString {
    case "A":            return .A
    case "S":            return .S
    case "D":            return .D
    case "F":            return .F
    case "H":            return .H
    case "G":            return .G
    case "Z":            return .Z
    case "X":            return .X
    case "C":            return .C
    case "V":            return .V
    case "B":            return .B
    case "Q":            return .Q
    case "W":            return .W
    case "E":            return .E
    case "R":            return .R
    case "Y":            return .Y
    case "T":            return .Tee
    case "1":            return .One
    case "2":            return .Two
    case "3":            return .Three
    case "4":            return .Four
    case "5":            return .Five
    case "6":            return .Six
    case "=":            return .Equals
    case "9":            return .Nine
    case "7":            return .Seven
    case "-":            return .Dash
    case "8":            return .Eight
    case "0":            return .Zero
    case "]":            return .RightBracket
    case "O":            return .O
    case "U":            return .U
    case "[":            return .LeftBracket
    case "I":            return .I
    case "P":            return .P
    case "L":            return .L
    case "J":            return .J
    case "\"":           return .Quote
    case "K":            return .K
    case ";":            return .Semicolon
    case "\\":           return .Backslash
    case ",":            return .Comma
    case "/":            return .Slash
    case "N":            return .N
    case "M":            return .M
    default: break
    }

    switch string {
    case ".":                   return .Period
    case "<Grave>":             return .Grave
    case "<KeypadDecimal>":     return .KeypadDecimal
    case "<KeypadMultiply>":    return .KeypadMultiply
    case "<KeypadPlus>":        return .KeypadPlus
    case "<KeypadClear>":       return .KeypadClear
    case "<KeypadDivide>":      return .KeypadDivide
    case "<KeypadEnter>":       return .KeypadEnter
    case "<KeypadMinus>":       return .KeypadMinus
    case "<KeypadEquals>":      return .KeypadEquals
    case "<Keypad0>":           return .Keypad0
    case "<Keypad1>":           return .Keypad1
    case "<Keypad2>":           return .Keypad2
    case "<Keypad3>":           return .Keypad3
    case "<Keypad4>":           return .Keypad4
    case "<Keypad5>":           return .Keypad5
    case "<Keypad6>":           return .Keypad6
    case "<Keypad7>":           return .Keypad7
    case "<Keypad8>":           return .Keypad8
    case "<Keypad9>":           return .Keypad9

    /* keycodes for keys that are independent of keyboard layout*/
    case "<Return>":            return .Return
    case "<Tab>":               return .Tab
    case " ":                  return .Space
    case "<Delete>":            return .Delete
    case "<Escape>":            return .Escape
    case "<Command>":           return .Command
    case "<Shift>":             return .Shift
    case "<CapsLock>":          return .CapsLock
    case "<Option>":            return .Option
    case "<Control>":           return .Control
    case "<RightShift>":        return .RightShift
    case "<RightOption>":       return .RightOption
    case "<RightControl>":      return .RightControl
    case "<Function>":          return .Function
    case "<F17>":               return .F17
    case "<VolumeUp>":          return .VolumeUp
    case "<VolumeDown>":        return .VolumeDown
    case "<Mute>":              return .Mute
    case "<F18>":               return .F18
    case "<F19>":               return .F19
    case "<F20>":               return .F20
    case "<F5>":                return .F5
    case "<F6>":                return .F6
    case "<F7>":                return .F7
    case "<F3>":                return .F3
    case "<F8>":                return .F8
    case "<F9>":                return .F9
    case "<F11>":               return .F11
    case "<F13>":               return .F13
    case "<F16>":               return .F16
    case "<F14>":               return .F14
    case "<F10>":               return .F10
    case "<F12>":               return .F12
    case "<F15>":               return .F15
    case "<Help>":              return .Help
    case "<Home>":              return .Home
    case "<PageUp>":            return .PageUp
    case "<ForwardDelete>":     return .ForwardDelete
    case "<F4>":                return .F4
    case "<End>":               return .End
    case "<F2>":                return .F2
    case "<PageDown>":          return .PageDown
    case "<F1>":                return .F1
    case "<LeftArrow>":         return .LeftArrow
    case "<RightArrow>":        return .RightArrow
    case "<DownArrow>":         return .DownArrow
    case "<UpArrow>":           return .UpArrow

    // The following were discovered using the Key Codes app
    case "<Backspace>":         return .Backspace
    case "<Enter>":             return .Enter
    case "<":                   return .LessThan
    case ">":                   return .GreaterThan
    case "{":                   return .LeftBrace
    case "}":                   return .RightBrace
    case ")":                   return .RightParen
    case "(":                   return .LeftParen
    case "!":                   return .Bang
    case "|":                   return .Pipe
    case ":":                   return .Colon
    case "`":                   return .Backtick
    case "'":                   return .Apostrophe
    case "&":                   return .Ampersand
    case "%":                   return .Percent
    case "?":                   return .QuestionMark
    case "*":                   return .Splat
    case "~":                   return .Tilde
    case "@":                   return .At
    case "$":                   return .Dollar
    case "^":                   return .Caret
    case "+":                   return .Plus
    case "#":                   return .Hash

    // Had to enter these manually; maybe there’s a better way? --DRC
    case "_":                   return .Dash  // requires SHIFT key.

    default:                    return nil
    }
  }
}
