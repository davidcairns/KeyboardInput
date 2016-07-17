//
//  Character+Helpers.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/29/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

extension Character {
  public var isUpper: Bool {
    let s = String(self)
    return s >= "A" && s <= "Z"
  }

  public var isNumber: Bool {
    let s = String(self)
    return s >= "0" && s <= "9"
  }
}
