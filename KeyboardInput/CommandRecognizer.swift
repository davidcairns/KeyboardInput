//
//  CommandRecognizer.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/29/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

public class CommandRecognizer {
  let transformer: TextTransformer! = nil

  enum RecognitionResult {
    case NotRecognized
    case Recognizing(TextTransformer)
    case Recognized(TextTransformer)
  }

  /* Override point! */
  func handle(word: String) -> RecognitionResult { return .NotRecognized }
}

/*  Whenever an instance recognizes, it produces some result. This command
 *  recognizer is basically just a simple mapping
 */
class SingleMatchRecognizer : CommandRecognizer {
  let string: String
  let result: String
  init(string: String, thenProduce result: String) {
    self.string = string
    self.result = result
    super.init()
  }

  override func handle(word: String) -> CommandRecognizer.RecognitionResult {
    if self.string == word.lowercaseString {
      return .Recognized(TextTransformer(transform: { _ in self.result }))
    }
    return .NotRecognized
  }
}

/*  This recognizer will continue to recognize until it is manually reset (this ought to
 *  happen when the user makes a break in their speaking). It then applies some
 *  transformation operation to the whole string of text, the result of which is sent to
 *  the output.
 */
class ContinuousCommandRecognizer : CommandRecognizer {
  let command: String
  let transform: String -> String
  init(command: String, transform: String -> String) {
    self.command = command
    self.transform = transform
    super.init()
  }

  override func handle(word: String) -> CommandRecognizer.RecognitionResult {
    if self.command == word.lowercaseString {
      print("{COMMAND \(word)}", terminator:"")
      return .Recognizing(TextTransformer(transform: self.transform))
    }
    return .NotRecognized
  }
}
