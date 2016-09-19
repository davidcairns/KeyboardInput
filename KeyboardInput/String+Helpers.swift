//
//  String+Helpers.swift
//  KeyboardInput
//
//  Created by David Cairns on 7/14/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

extension String {
  public var isSingleCharacter: Bool {
    return 1 == self.lengthOfBytes(using: String.Encoding.utf8)
  }

  public var isUpper: Bool {
    let characters: String.CharacterView = self.characters
    return characters.all { $0.isUpper }
  }

  public var isNumber: Bool {
    let characters: String.CharacterView = self.characters
    return characters.all { c in
      if c.isNumber { return true }

      let s = String(c)
      if s == "," || s == "." { return true }

      return false
    }
  }
}
