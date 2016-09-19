//
//  CollectionType+Helpers.swift
//  KeyboardInput
//
//  Created by David Cairns on 7/14/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

extension Collection {
  public func all(_ predicate: (Iterator.Element) -> Bool) -> Bool {
    return self.reduce(true) { $0 && predicate($1) }
  }
  public func any(_ predicate: (Iterator.Element) -> Bool) -> Bool {
    return self.reduce(false) { $0 || predicate($1) }
  }
}
