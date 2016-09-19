//
//  CommandProcessor.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/29/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

public final class CommandProcessor {
  public let inputStream: Stream<InputElement> = Stream<InputElement>()
  public let outputStream: Stream<String> = Stream<String>()

  private var currentWord: String = ""

  private var currentTextHandler: TextHandler?
  let commandRecognizers: [CommandRecognizer]

  init(commandRecognizers: [CommandRecognizer]) {
    self.commandRecognizers = commandRecognizers

    // Hook up our input stream.
    self.inputStream.subscribe { input in
      switch input {
      case let .Word(word):
        self.handleWord(word)
      default:
        self.handleBreak()
      }
    }
  }

  private func handleWord(word: String) {
    // If this word is a shorthand, just emit it.
    // NOTE: This doesn't change the current text handler; so if you're in the middle of
    // a "say" operation, you will remain inside it.
    if let result = Shorthands[word] {
      self.outputStream.emit(result)
      return
    }

    // If this is a raw number (Dragon converts spoken numbers into their numeric
    // digits), just output it (sans any commas).
    // For example: 2,098.6 -> 2098.6
    if word.isNumber {
      let sansCommas = word.stringByReplacingOccurrencesOfString(",", withString: "")
      self.outputStream.emit(sansCommas)
      return
    }

    // If we already have a text handler, continue to use it!
    if let currentTextHandler = self.currentTextHandler {
      let transformed = currentTextHandler.handle(word)
      self.outputStream.emit(transformed)
      return
    }

    // Otherwise, we need to check all of our command recognizers to see if any of them
    // will handle this.
    for recognizer in self.commandRecognizers {
      let result = recognizer.handle(word)
      switch result {
        case .Recognizing(let textHandler):
          // Use the recognizer from here on out (but not for the instigating command word!)!
          self.currentTextHandler = textHandler
          return
        case .Recognized(let textHandler):
          // Just use this recognizer as a one-shot!
          let transformed = textHandler.handle(word)
          self.outputStream.emit(transformed)
        return
        default: break
      }
    }

    // If we've gotten here, we're not handling this word.
    print("<¿\(word)?>", terminator: "")
  }
  private func handleBreak() {
    // Breaks always terminates our current text handler.
    self.currentTextHandler = nil
  }


  // MARK: -
  public func flushCurrentWord() {
    self.caughtWord(self.currentWord)
    self.currentWord = ""
  }

  private static func cleanedUp(word word: String) -> String {
    // Make sure it's lower-case.
    var result = word.lowercaseString

    // Remove any spaces.
    result = result.stringByReplacingOccurrencesOfString(" ", withString: "")
    if result.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 0 { return "" }

    // Remove any interior hyphens / dashes.
    if String(result.characters.first!) != "-" {
      result = result.stringByReplacingOccurrencesOfString("-", withString: "")
    }

    return result
  }
  public func caughtWord(word: String) {
    let cleanedWord = CommandProcessor.cleanedUp(word: word)
    if cleanedWord.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
      print("<\(cleanedWord)>", terminator: "")
      self.inputStream.emit(InputElement.Word(cleanedWord))
    }
  }

  func appendCharacter(string: String) {
//    print("\(string).")
    // See if we've just finished a word!
    let currentLength = self.currentWord.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
    if currentLength != 0 && string == " " {
      self.flushCurrentWord()
    }
    else {
      self.currentWord.appendContentsOf(string)
    }
  }
}
