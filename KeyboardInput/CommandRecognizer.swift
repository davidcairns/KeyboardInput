//
//  CommandRecognizer.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/29/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

open class CommandRecognizer {
  let textHandler: TextHandler! = nil

  enum RecognitionResult {
    case notRecognized
    case recognizing(TextHandler)
    case recognized(TextHandler)
  }

  /* Override point! */
  func handle(_ word: String) -> RecognitionResult { return .notRecognized }
}

/*  Whenever an instance recognizes, it produces some result. This command
 *  recognizer is basically just a simple mapping
 */
final class SingleMatchRecognizer : CommandRecognizer {
  let string: String
  let result: String
  init(string: String, thenProduce result: String) {
    self.string = string
    self.result = result
    super.init()
  }

  override func handle(_ word: String) -> CommandRecognizer.RecognitionResult {
    if self.string == word.lowercased() {
      return .recognized(TextTransformer(transform: { _ in self.result }))
    }
    return .notRecognized
  }
}

/*  This recognizer will continue to recognize until it is manually reset (this ought to
 *  happen when the user makes a break in their speaking). It then applies some
 *  transformation operation to the whole string of text, the result of which is sent to
 *  the output.
 */
final class ContinuousCommandRecognizer : CommandRecognizer {
  let command: String
  let makeHandlerBlock: () -> TextHandler

  init(command: String, makeHandlerBlock: @escaping () -> TextHandler) {
    self.command = command
    self.makeHandlerBlock = makeHandlerBlock
    super.init()
  }

  override func handle(_ word: String) -> CommandRecognizer.RecognitionResult {
    if self.command == word.lowercased() {
      return .recognizing(self.makeHandlerBlock())
    }
    return .notRecognized
  }
}
