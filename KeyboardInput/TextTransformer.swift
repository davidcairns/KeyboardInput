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
public final class TextTransformer: TextHandler {
  public let transform: String -> String
  public init(transform: String -> String) {
    self.transform = transform
  }

  func handle(text: String) -> String {
    return self.transform(text)
  }
}

public final class PassthroughTextHandler: TextHandler {    // hello darkness my old friend
  var isFirstWord: Bool = true
  func handle(text: String) -> String {
    let transformed = (self.isFirstWord ? text.lowercaseString : " " + text.lowercaseString)
    self.isFirstWord = false
    return transformed
  }
}

public final class CamelCaseTransformer: TextHandler {      // helloDarknessMyOldFriend
  var isFirstWord: Bool = true
  func handle(text: String) -> String {
    let transformed = (self.isFirstWord ? text.lowercaseString : text.capitalizedString)
    self.isFirstWord = false
    return transformed
  }
}

public final class PascalCaseTransformer: TextHandler {     // HelloDarknessMyOldFriend
  // “Pascal-case” is just camel-case with the first letter capitalized.
  let camel: CamelCaseTransformer = CamelCaseTransformer()
  func handle(text: String) -> String {
    return self.camel.handle(text).capitalizedString
  }
}

public final class UnderscoredTransformer: TextHandler {    // hello_darkness_my_old_friend
  var isFirstWord: Bool = true
  func handle(text: String) -> String {
    let transformed = (self.isFirstWord ? text.lowercaseString : "_" + text.lowercaseString)
    self.isFirstWord = false
    return transformed
  }
}

public final class AllCapsTransformer: TextHandler {        // HELLO_DARKNESS_MY_OLD_FRIEND
  // Same as underscores but CAPITALIZED!
  let under: UnderscoredTransformer = UnderscoredTransformer()
  func handle(text: String) -> String {
    return self.under.handle(text).uppercaseString
  }
}

public final class NoSpacesTransformer: TextHandler {       // hellodarknessmyoldfriend
  // Same as passthrough but NO SPACES!
  let pass = PassthroughTextHandler()
  func handle(text: String) -> String {
    return pass.handle(text).stringByReplacingOccurrencesOfString(" ", withString: "")
  }
}

public final class DashedTransformer: TextHandler {         // hello-darkness-my-old-friend
  // Same as underscores, but with n-dashes.
  let under: UnderscoredTransformer = UnderscoredTransformer()
  func handle(text: String) -> String {
    return self.under.handle(text).stringByReplacingOccurrencesOfString("_", withString: "-")
  }
}
