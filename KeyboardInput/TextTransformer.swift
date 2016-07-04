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

// This class allows a custom transform, provided at init.
public class TextTransformer: TextHandler {
  public let transform: String -> String
  public init(transform: String -> String) {
    self.transform = transform
  }

  func handle(text: String) -> String {
    return self.transform(text)
  }
}

public class PassthroughTextHandler: TextHandler {    // hello darkness my old friend
  var isFirstWord: Bool = true
  func handle(text: String) -> String {
    let transformed = (self.isFirstWord ? text.lowercaseString : " " + text.lowercaseString)
    self.isFirstWord = false
    return transformed
  }
}

public class CamelCaseTransformer: TextHandler {      // helloDarknessMyOldFriend
  var isFirstWord: Bool = true
  func handle(text: String) -> String {
    let transformed = (self.isFirstWord ? text.lowercaseString : text.capitalizedString)
    self.isFirstWord = false
    return transformed
  }
}

public class PascalCaseTransformer: TextHandler {     // HelloDarknessMyOldFriend
  // “Pascal-case” is just camel-case with the first letter capitalized.
  let camel: CamelCaseTransformer = CamelCaseTransformer()
  func handle(text: String) -> String {
    return self.camel.handle(text).capitalizedString
  }
}

public class UnderscoredTransformer: TextHandler {    // hello_darkness_my_old_friend
  var isFirstWord: Bool = true
  func handle(text: String) -> String {
    let transformed = (self.isFirstWord ? text.lowercaseString : "_" + text.lowercaseString)
    self.isFirstWord = false
    return transformed
  }
}

public class AllCapsTransformer: TextHandler {        // HELLO_DARKNESS_MY_OLD_FRIEND
  // Same as underscores but CAPITALIZED!
  let under: UnderscoredTransformer = UnderscoredTransformer()
  func handle(text: String) -> String {
    return self.under.handle(text).uppercaseString
  }
}

public class DashedTransformer: TextHandler {         // hello-darkness-my-old-friend
  // Same as underscores, but with n-dashes.
  let under: UnderscoredTransformer = UnderscoredTransformer()
  func handle(text: String) -> String {
    return self.under.handle(text).stringByReplacingOccurrencesOfString("_", withString: "-")
  }
}
