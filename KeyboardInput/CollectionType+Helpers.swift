//
//  CollectionType+Helpers.swift
//  KeyboardInput
//
//  Created by David Cairns on 7/14/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

extension CollectionType {
  public func all(predicate: Generator.Element -> Bool) -> Bool {
    return self.reduce(true) { $0 && predicate($1) }
  }
  public func any(predicate: Generator.Element -> Bool) -> Bool {
    return self.reduce(false) { $0 || predicate($1) }
  }
}
