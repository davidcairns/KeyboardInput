//
//  KeyPress.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/29/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

public struct KeyPress {
  public let key: Key
  public let modifiers: [ModifierKey]

  static func from(character: Character) -> KeyPress? {
    guard let key = Key.from(character: character) else {
      print("FAILED TO PRODUCE KEYPRESS FOR CHARACTER '\(character)'")
      return nil
    }
    var modifiers: [ModifierKey] = []

    let charString = String(character)
    if character.isUpper || "!@#$%^&*()_+{}:\"<>?|".contains(charString) {
      modifiers.append(ModifierKey.shift)
    }

//    print("returning key \(key)")
    return KeyPress(key: key, modifiers: modifiers)
  }

  static func from(string: String) -> [KeyPress] {
    // If this is a special key or a specific letter, convert directly to that Key.
    if let key = Key.from(string: string) {
      var modifiers: [ModifierKey] = []
      if key.needsShift || (string.isSingleCharacter && string.isUpper) {
        modifiers.append(ModifierKey.shift)
      }
      return [KeyPress(key: key, modifiers: modifiers)]
    }

    // Handle control sequences.
    if string.hasPrefix("C-") {
      let secondCharacterIndex = string.index(after: string.index(after: string.startIndex))
      let afterControl = string.substring(from: secondCharacterIndex)
      let baseKeyPress = KeyPress.from(string: afterControl)
      return baseKeyPress.map { KeyPress(key: $0.key, modifiers: $0.modifiers + [ModifierKey.control]) }
    }

    // Otherwise, this is just some word; handle it like a series of characters.
    let characters: String.CharacterView = string.characters
    let presses = characters.flatMap { character in
      KeyPress.from(character: character)
    }
//    print("KeyPress.from(string: \"\(string)\" --> \(presses)")
    return presses
  }
}
