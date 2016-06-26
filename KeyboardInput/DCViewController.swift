//
//  DCViewController.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/24/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import AppKit


func GetTerminalApp() -> NSRunningApplication! {
  return NSRunningApplication.app(withBundleIdentifier: "com.apple.Terminal")
}


struct Parser {
  let test: String -> Bool
  let onRecognize: [String] -> String
  let outputStream: Stream<String> = Stream<String>()

  init(test: String -> Bool, onRecognize: [String] -> String) {
    self.test = test
    self.onRecognize = onRecognize
  }
  init(matching: String, onRecognize: [String] -> String) {
    self.test = { $0 == matching }
    self.onRecognize = onRecognize
  }
}

struct Grammar {
  let parsers: [Parser]

  func testAll(string: String) -> Bool {
    var idx = 0
    for parser in parsers {
      print("checking parser #\(idx)...")
      if parser.test(string) {
        print("... yup!")
        let result = parser.onRecognize([string])
        parser.outputStream.emit(result)
        return true
      }
      else {
        print("... nope!")
      }
      idx += 1
    }
    return false
  }
}


public enum InputElement {
  case Word(String)
  case Break
}

public final class DCViewController : NSViewController {

  lazy var keyboard: Keyboard = { return Keyboard(destination: KeyDestination(app: GetTerminalApp())) }()

  var currentWord: String = ""
  public let inputWordStream: Stream<InputElement> = Stream<InputElement>()

  lazy var grammar: Grammar! = {
    let g = Grammar(parsers: [
      Parser(matching: "hello")   { _ in print("DING!!!"); return "whats up honkey" },
      Parser(matching: "goodbye") { _ in print("DING!!!"); return "seeya sucka" },
      ])
    // Tie all of our parsers' output streams into a single output stream.
    let parserOutputs: [Stream<String>] = g.parsers.map({ $0.outputStream })
    let masterOutput = flatten(parserOutputs)
    // Subscribe to that output stream.
    masterOutput.subscribe { string in self.emitWord(string) }
    return g
  }()



  class func scheduledBreakTimer(on on: DCViewController) -> NSTimer {
    return NSTimer.scheduledTimerWithTimeInterval(1.0, target: on, selector: #selector(DCViewController.insertBreak), userInfo: nil, repeats: false)
  }
  func rescheduleBreakTimer() {
    self.breakTimer.invalidate()
    self.breakTimer = DCViewController.scheduledBreakTimer(on: self)
  }
  var breakTimer: NSTimer!
  public func insertBreak() {
    // Flush the current word and insert a break.
    self.flushCurrentWord()
    self.inputWordStream.emit(InputElement.Break)
  }

  // Set to 'true' if you want the text run through our grammar rules first, or 'false' if you just
  // want straight "dictation mode".
  var useCommands: Bool = true

  public required init?(coder: NSCoder) {
    super.init(coder: coder)

    // Start up our break timer.
    self.breakTimer = DCViewController.scheduledBreakTimer(on: self)

    // Whenever our input stream emits a word, run it through our Grammar rules.
    self.inputWordStream.subscribe { input in
      switch input {
        case let .Word(string):
          if self.useCommands {
            self.grammar.testAll(string)
          }
          else {
            self.keyboard.handleKeyPresses(KeyPress.from(string: string))
          }

        default: break
      }
    }
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    // For some reason, we need specifically to request to receive these events.
    // FIXME: Maybe we should move all this code into the WindowController? --DRC
    NSEvent.addLocalMonitorForEventsMatchingMask(.KeyDownMask) { (event) in
      self.keyDown(event)
      return event
    }
    NSEvent.addLocalMonitorForEventsMatchingMask(.KeyUpMask) { (event) in
      self.keyUp(event)
      return event
    }
    NSEvent.addLocalMonitorForEventsMatchingMask(.FlagsChangedMask) { (event) in
      self.flagsChanged(event)
      return event
    }
  }



  // MARK: -
  func flushCurrentWord() {
    self.caughtWord(self.currentWord)
    self.currentWord = ""
  }
  func caughtWord(word: String) {
    let strippedWord = word.stringByReplacingOccurrencesOfString(" ", withString: "")
    print("caught '\(strippedWord)'")
    self.inputWordStream.emit(InputElement.Word(strippedWord))
  }
  public func emitWord(word: String) {
    let keyPresses = KeyPress.from(string: word)
    self.keyboard.handleKeyPresses(keyPresses)
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


  // MARK: - Raw events
  public override func keyDown(theEvent: NSEvent) {
    // The user just did something... reschedule the break timer!
    rescheduleBreakTimer()
  }

  public override func keyUp(theEvent: NSEvent) {
    self.appendCharacter((theEvent.characters ?? ""))

    // The user just did something... reschedule the break timer!
    rescheduleBreakTimer()
  }
}
