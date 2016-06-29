//
//  TextTransformer.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/29/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

protocol TextHandler {
  func handle(text: String) -> String
}

public class PassthroughTextHandler: TextHandler {
  func handle(text: String) -> String {
    return text + " "
  }
}

public class TextTransformer: TextHandler {
  public let transform: String -> String
  public init(transform: String -> String) {
    self.transform = transform
  }

  func handle(text: String) -> String {
    return self.transform(text)
  }
}

public class CamelCaseTransformer: TextHandler {
  var isFirstWord: Bool = true
  public init() {}
  func handle(text: String) -> String {
    let transformed = (self.isFirstWord ? text.lowercaseString : text.capitalizedString)
    self.isFirstWord = false
    return transformed
  }
}

public class UnderscoredTransformer: TextHandler {
  var isFirstWord: Bool = true
  public init() {}
  func handle(text: String) -> String {
    let transformed = (self.isFirstWord ? text.lowercaseString : "_" + text.lowercaseString)
    self.isFirstWord = false
    return transformed
  }
}
public class AllCapsTransformer: TextHandler {
  var isFirstWord: Bool = true
  public init() {}
  func handle(text: String) -> String {
    let transformed = (self.isFirstWord ? text.uppercaseString : "_" + text.uppercaseString)
    self.isFirstWord = false
    return transformed
  }
}
