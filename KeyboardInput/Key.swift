//
//  Key.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/29/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

public enum Key {
  case a
  case s
  case d
  case f
  case h
  case g
  case z
  case x
  case c
  case v
  case b
  case q
  case w
  case e
  case r
  case y
  case tee // "T" conflicts with some kind of internal Swift thing >_<
  case one
  case two
  case three
  case four
  case five
  case six
  case equals
  case nine
  case seven
  case dash
  case underscore
  case eight
  case zero
  case rightBracket
  case o
  case u
  case leftBracket
  case i
  case p
  case l
  case j
  case quote
  case k
  case semicolon
  case backslash
  case comma
  case slash
  case n
  case m
  case period
  case grave
  case keypadDecimal
  case keypadMultiply
  case keypadPlus
  case keypadClear
  case keypadDivide
  case keypadEnter
  case keypadMinus
  case keypadEquals
  case keypad0
  case keypad1
  case keypad2
  case keypad3
  case keypad4
  case keypad5
  case keypad6
  case keypad7
  case keypad8
  case keypad9

  /* keycodes for keys that are independent of keyboard layout*/
  case `return`
  case tab
  case space
  case delete
  case escape
  case command
  case shift
  case capsLock
  case option
  case control
  case rightShift
  case rightOption
  case rightControl
  case function
  case f17
  case volumeUp
  case volumeDown
  case mute
  case f18
  case f19
  case f20
  case f5
  case f6
  case f7
  case f3
  case f8
  case f9
  case f11
  case f13
  case f16
  case f14
  case f10
  case f12
  case f15
  case help
  case home
  case pageUp
  case forwardDelete
  case f4
  case end
  case f2
  case pageDown
  case f1
  case leftArrow
  case rightArrow
  case downArrow
  case upArrow

  // "The following were discovered using the Key Codes app"
  // ^^^ Above comment grandfathered in from another codebase. Not totally sure what it means! --DRC
  case backspace
  case enter
  case lessThan
  case greaterThan
  case leftBrace
  case rightBrace
  case rightParen
  case leftParen
  case bang
  case pipe
  case colon
  case backtick
  case apostrophe
  case ampersand
  case percent
  case questionMark
  case splat
  case tilde
  case at
  case dollar
  case caret
  case plus
  case hash


  var keyCode: CGKeyCode {
    switch self {
    case .a : return 0x00
    case .s : return 0x01
    case .d : return 0x02
    case .f : return 0x03
    case .h : return 0x04
    case .g : return 0x05
    case .z : return 0x06
    case .x : return 0x07
    case .c : return 0x08
    case .v : return 0x09
    case .b : return 0x0B
    case .q : return 0x0C
    case .w : return 0x0D
    case .e : return 0x0E
    case .r : return 0x0F
    case .y : return 0x10
    case .tee : return 0x11  // (see comment above about using "T"!)
    case .one : return 0x12
    case .two : return 0x13
    case .three : return 0x14
    case .four : return 0x15
    case .five : return 0x17
    case .six : return 0x16
    case .equals : return 0x18
    case .nine : return 0x19
    case .seven : return 0x1A
    case .dash : return 0x1B
    case .eight : return 0x1C
    case .zero : return 0x1D
    case .rightBracket : return 0x1E
    case .o : return 0x1F
    case .u : return 0x20
    case .leftBracket : return 0x21
    case .i : return 0x22
    case .p : return 0x23
    case .l : return 0x25
    case .j : return 0x26
    case .quote : return 0x27
    case .k : return 0x28
    case .semicolon : return 0x29
    case .backslash : return 0x2A
    case .comma : return 0x2B
    case .slash : return 0x2C
    case .n : return 0x2D
    case .m : return 0x2E
    case .period : return 0x2F
    case .grave : return 0x32
    case .keypadDecimal : return 0x41
    case .keypadMultiply : return 0x43
    case .keypadPlus : return 0x45
    case .keypadClear : return 0x47
    case .keypadDivide : return 0x4B
    case .keypadEnter : return 0x4C
    case .keypadMinus : return 0x4E
    case .keypadEquals : return 0x51
    case .keypad0 : return 0x52
    case .keypad1 : return 0x53
    case .keypad2 : return 0x54
    case .keypad3 : return 0x55
    case .keypad4 : return 0x56
    case .keypad5 : return 0x57
    case .keypad6 : return 0x58
    case .keypad7 : return 0x59
    case .keypad8 : return 0x5B
    case .keypad9 : return 0x5C

      /* keycodes for keys that are independent of keyboard layout*/
    case .`return` : return 0x24
    case .tab : return 0x30
    case .space : return 0x31
    case .delete : return 0x33
    case .escape : return 0x35
    case .command : return 0x37
    case .shift : return 0x38
    case .capsLock : return 0x39
    case .option : return 0x3A
    case .control : return 0x3B
    case .rightShift : return 0x3C
    case .rightOption : return 0x3D
    case .rightControl : return 0x3E
    case .function : return 0x3F
    case .f17 : return 0x40
    case .volumeUp : return 0x48
    case .volumeDown : return 0x49
    case .mute : return 0x4A
    case .f18 : return 0x4F
    case .f19 : return 0x50
    case .f20 : return 0x5A
    case .f5 : return 0x60
    case .f6 : return 0x61
    case .f7 : return 0x62
    case .f3 : return 0x63
    case .f8 : return 0x64
    case .f9 : return 0x65
    case .f11 : return 0x67
    case .f13 : return 0x69
    case .f16 : return 0x6A
    case .f14 : return 0x6B
    case .f10 : return 0x6D
    case .f12 : return 0x6F
    case .f15 : return 0x71
    case .help : return 0x72
    case .home : return 0x73
    case .pageUp : return 0x74
    case .forwardDelete : return 0x75
    case .f4 : return 0x76
    case .end : return 0x77
    case .f2 : return 0x78
    case .pageDown : return 0x79
    case .f1 : return 0x7A
    case .leftArrow : return 0x7B
    case .rightArrow : return 0x7C
    case .downArrow : return 0x7D
    case .upArrow : return 0x7E

    // The following were discovered using the Key Codes app
    case .backspace : return 0x33
    case .enter : return 0x24
    case .lessThan : return 0x2B
    case .greaterThan : return 0x2F
    case .leftBrace : return 0x21
    case .rightBrace : return 0x1E
    case .rightParen : return 0x1D
    case .leftParen : return 0x19
    case .bang : return 0x12
    case .pipe : return 0x2A
    case .colon : return 0x29
    case .backtick : return 0x32
    case .apostrophe : return 0x27
    case .ampersand : return 0x1A
    case .percent : return 0x17
    case .questionMark : return 0x2C
    case .splat : return 0x1C
    case .tilde : return 0x32
    case .at : return 0x13
    case .dollar : return 0x15
    case .caret : return 0x16
    case .plus : return 0x18
    case .hash : return 0x14
    case .underscore : return 0x1B
    }
  }

  var needsShift: Bool {
    switch self {
      case .quote:                    fallthrough
      case .lessThan:                 fallthrough
      case .greaterThan:              fallthrough
      case .leftBrace:                fallthrough
      case .rightBrace:               fallthrough
      case .rightParen:               fallthrough
      case .leftParen:                fallthrough
      case .bang:                     fallthrough
      case .pipe:                     fallthrough
      case .colon:                    fallthrough
      case .ampersand:                fallthrough
      case .percent:                  fallthrough
      case .questionMark:             fallthrough
      case .splat:                    fallthrough
      case .tilde:                    fallthrough
      case .at:                       fallthrough
      case .dollar:                   fallthrough
      case .caret:                    fallthrough
      case .plus:                     fallthrough
      case .underscore:               fallthrough
      case .hash:                                 return true

      default: return false
    }
  }

  static func from(character: Character) -> Key? {
    return from(string: String(character))
  }

  static func from(string: String) -> Key? {
    switch string.uppercased() {
    case "A":            return .a
    case "S":            return .s
    case "D":            return .d
    case "F":            return .f
    case "H":            return .h
    case "G":            return .g
    case "Z":            return .z
    case "X":            return .x
    case "C":            return .c
    case "V":            return .v
    case "B":            return .b
    case "Q":            return .q
    case "W":            return .w
    case "E":            return .e
    case "R":            return .r
    case "Y":            return .y
    case "T":            return .tee
    case "1":            return .one
    case "2":            return .two
    case "3":            return .three
    case "4":            return .four
    case "5":            return .five
    case "6":            return .six
    case "=":            return .equals
    case "9":            return .nine
    case "7":            return .seven
    case "-":            return .dash
    case "8":            return .eight
    case "0":            return .zero
    case "]":            return .rightBracket
    case "O":            return .o
    case "U":            return .u
    case "[":            return .leftBracket
    case "I":            return .i
    case "P":            return .p
    case "L":            return .l
    case "J":            return .j
    case "\"":           return .quote
    case "K":            return .k
    case ";":            return .semicolon
    case "\\":           return .backslash
    case ",":            return .comma
    case "/":            return .slash
    case "N":            return .n
    case "M":            return .m
    default: break
    }

    switch string {
    case ".":                   return .period
    case "<Grave>":             return .grave
    case "<KeypadDecimal>":     return .keypadDecimal
    case "<KeypadMultiply>":    return .keypadMultiply
    case "<KeypadPlus>":        return .keypadPlus
    case "<KeypadClear>":       return .keypadClear
    case "<KeypadDivide>":      return .keypadDivide
    case "<KeypadEnter>":       return .keypadEnter
    case "<KeypadMinus>":       return .keypadMinus
    case "<KeypadEquals>":      return .keypadEquals
    case "<Keypad0>":           return .keypad0
    case "<Keypad1>":           return .keypad1
    case "<Keypad2>":           return .keypad2
    case "<Keypad3>":           return .keypad3
    case "<Keypad4>":           return .keypad4
    case "<Keypad5>":           return .keypad5
    case "<Keypad6>":           return .keypad6
    case "<Keypad7>":           return .keypad7
    case "<Keypad8>":           return .keypad8
    case "<Keypad9>":           return .keypad9

    /* keycodes for keys that are independent of keyboard layout*/
    case "<Return>":            return .return
    case "<Tab>":               return .tab
    case " ":                  return .space
    case "<Delete>":            return .delete
    case "<Escape>":            return .escape
    case "<Command>":           return .command
    case "<Shift>":             return .shift
    case "<CapsLock>":          return .capsLock
    case "<Option>":            return .option
    case "<Control>":           return .control
    case "<RightShift>":        return .rightShift
    case "<RightOption>":       return .rightOption
    case "<RightControl>":      return .rightControl
    case "<Function>":          return .function
    case "<F17>":               return .f17
    case "<VolumeUp>":          return .volumeUp
    case "<VolumeDown>":        return .volumeDown
    case "<Mute>":              return .mute
    case "<F18>":               return .f18
    case "<F19>":               return .f19
    case "<F20>":               return .f20
    case "<F5>":                return .f5
    case "<F6>":                return .f6
    case "<F7>":                return .f7
    case "<F3>":                return .f3
    case "<F8>":                return .f8
    case "<F9>":                return .f9
    case "<F11>":               return .f11
    case "<F13>":               return .f13
    case "<F16>":               return .f16
    case "<F14>":               return .f14
    case "<F10>":               return .f10
    case "<F12>":               return .f12
    case "<F15>":               return .f15
    case "<Help>":              return .help
    case "<Home>":              return .home
    case "<PageUp>":            return .pageUp
    case "<ForwardDelete>":     return .forwardDelete
    case "<F4>":                return .f4
    case "<End>":               return .end
    case "<F2>":                return .f2
    case "<PageDown>":          return .pageDown
    case "<F1>":                return .f1
    case "<LeftArrow>":         return .leftArrow
    case "<RightArrow>":        return .rightArrow
    case "<DownArrow>":         return .downArrow
    case "<UpArrow>":           return .upArrow

    // The following were discovered using the Key Codes app
    case "<Backspace>":         return .backspace
    case "<Enter>":             return .enter
    case "<":                   return .lessThan
    case ">":                   return .greaterThan
    case "{":                   return .leftBrace
    case "}":                   return .rightBrace
    case ")":                   return .rightParen
    case "(":                   return .leftParen
    case "!":                   return .bang
    case "|":                   return .pipe
    case ":":                   return .colon
    case "`":                   return .backtick
    case "'":                   return .apostrophe
    case "&":                   return .ampersand
    case "%":                   return .percent
    case "?":                   return .questionMark
    case "*":                   return .splat
    case "~":                   return .tilde
    case "@":                   return .at
    case "$":                   return .dollar
    case "^":                   return .caret
    case "+":                   return .plus
    case "#":                   return .hash

    // Had to enter these manually; maybe there’s a better way? --DRC
    case "_":                   return .underscore  // requires SHIFT key.

    default:                    return nil
    }
  }
}
