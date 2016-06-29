//
//  Array+Helpers.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/29/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

extension Array {
  public var tail: Array {
    if self.count <= 1 { return [] }
    return Array(self.suffixFrom(1))
  }
}
