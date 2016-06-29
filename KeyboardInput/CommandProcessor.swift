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


  func handleWord(word: String) {
    // If we already have a transformer, continue to use it!
    if let currentTextHandler = self.currentTextHandler {
      let transformed = currentTextHandler.handle(word)
      self.outputStream.emit(transformed)
    }
      // Otherwise, we need to check all of our command recognizers to see if any of them
      // will handle this.
    else {
      for recognizer in self.commandRecognizers {
        let result = recognizer.handle(word)
        switch result {
        case .Recognizing(let textHandler):
          // Use the recognizer from here on out (but not for the instigating command word!)!
          self.currentTextHandler = textHandler
        case .Recognized(let textHandler):
          // Just use this recognizer as a one-shot!
          let transformed = textHandler.handle(word)
          self.outputStream.emit(transformed)
        default: break
        }
      }
    }
  }
  func handleBreak() {
    // Breaks always terminates our current text handler.
    self.currentTextHandler = nil
  }


  // MARK: -
  func flushCurrentWord() {
    self.caughtWord(self.currentWord)
    self.currentWord = ""
  }
  func caughtWord(word: String) {
    print("<\(word)>", terminator: "")
    let strippedWord = word.stringByReplacingOccurrencesOfString(" ", withString: "")
    self.inputStream.emit(InputElement.Word(strippedWord))
  }

  func appendCharacter(string: String) {
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
