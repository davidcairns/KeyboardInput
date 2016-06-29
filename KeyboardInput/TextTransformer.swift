//
//  TextTransformer.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/29/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

public class TextTransformer {
  public let transform: String -> String
  public init(transform: String -> String) {
    self.transform = transform
  }
}
