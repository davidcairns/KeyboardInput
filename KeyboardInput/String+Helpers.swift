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
    return 1 == self.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
  }

  public var isUpper: Bool {
    let characters: String.CharacterView = self.characters
    return characters.all { $0.isUpper }
  }
}
