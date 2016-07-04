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

  static func from(character character: Character) -> KeyPress? {
    guard let key = Key.from(character: character) else {
      print("FAILED TO PRODUCE KEYPRESS FOR CHARACTER '\(character)'")
      return nil
    }
    var modifiers: [ModifierKey] = []

    let charString = String(character)
    if character.isUpper || "!@#$%^&*()_+{}:\"<>?|".containsString(charString) {
      modifiers.append(ModifierKey.Shift)
    }

    return KeyPress(key: key, modifiers: modifiers)
  }

  static func from(string string: String) -> [KeyPress] {
    // If this is a special key or a specific letter, convert directly to that Key.
    if let key = Key.from(string: string) {
      var modifiers: [ModifierKey] = []
      if key.needsShift { modifiers.append(ModifierKey.Shift) }
      return [KeyPress(key: key, modifiers: modifiers)]
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
