//
//  KeyboardInterface.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/26/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

final class Keyboard {
  let destination: KeyDestination
  var currentlyHeldModifiers: [ModifierKey]

  init(destination: KeyDestination) {
    self.destination = destination
    self.currentlyHeldModifiers = []
  }

  func handleKeyPresses(_ keyPresses: [KeyPress]) {
    for keyPress in keyPresses {
      self.handleKeyPress(keyPress)
    }
  }
  func handleKeyPress(_ keyPress: KeyPress) {
//    print(" Handling a '\(keyPress.key)' with \(keyPress.modifiers.count) modifier(s)...")

    // First see if we should release any currently-held modifiers.
    for modifierKey in self.currentlyHeldModifiers {
      if !keyPress.modifiers.contains(modifierKey) {
        self.release(key: modifierKey.key)

        let idx = self.currentlyHeldModifiers.index(of: modifierKey)!
        self.currentlyHeldModifiers.remove(at: idx)
      }
    }

    // Now see if we should start holding any other modifiers.
    for modifierKey in keyPress.modifiers {
      if !self.currentlyHeldModifiers.contains(modifierKey) {
        self.press(key: modifierKey.key)
        self.currentlyHeldModifiers.append(modifierKey)
      }
    }

    // Now submit the actual key itself.
    self.tap(key: keyPress.key)
  }

  func tap(key: Key) {
    self.press(key: key)
    self.release(key: key)
  }

  func press(key: Key) {
    let flags = ModifierKey.ToFlags(self.currentlyHeldModifiers)
    self.destination.post(key.keyCode, flags: flags, isDown: true)
//    print("pressed \(key) (\(key.keyCode))")
  }

  func release(key: Key) {
    let flags = ModifierKey.ToFlags(self.currentlyHeldModifiers)
    self.destination.post(key.keyCode, flags: flags, isDown: false)
//    print("released \(key) (\(key.keyCode))")
  }
}
