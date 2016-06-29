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


extension Array {
  var tail: Array {
    if self.count <= 1 { return [] }
    return Array(self.suffixFrom(1))
  }
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


class TextTransformer {
  let transform: String -> String
  init(transform: String -> String) {
    self.transform = transform
  }
}

class CommandRecognizer {
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

public enum InputElement {
  case Word(String)
  case Break
}

public final class DCViewController : NSViewController {

  lazy var keyboardOutStream: Stream<String> = {
    let stream = Stream<String>()
    let keyboard = Keyboard(destination: KeyDestination(app: GetTerminalApp()))
    stream.subscribe { keyboard.handleKeyPresses(KeyPress.from(string: $0)) }
    return stream
  }()

  var currentWord: String = ""
  public let inputWordStream: Stream<InputElement> = Stream<InputElement>()
  public let outputStream: Stream<String> = Stream<String>()

  var currentTransformer: TextTransformer?
  let commandRecognizers: [CommandRecognizer] = [
    // Command
    SingleMatchRecognizer(string: "in", thenProduce: "i"),
    SingleMatchRecognizer(string: "delete", thenProduce: "d"),
    SingleMatchRecognizer(string: "change", thenProduce: "c"),
    SingleMatchRecognizer(string: "undo", thenProduce: "u"),
    SingleMatchRecognizer(string: "quit", thenProduce: "<Escape>"),
    // Movement
    SingleMatchRecognizer(string: "back", thenProduce: "b"),
    SingleMatchRecognizer(string: "end", thenProduce: "e"),
    SingleMatchRecognizer(string: "word", thenProduce: "w"),
    SingleMatchRecognizer(string: "doll", thenProduce: "$"),
    SingleMatchRecognizer(string: "zero", thenProduce: "0"),
    SingleMatchRecognizer(string: "up", thenProduce: "k"),
    SingleMatchRecognizer(string: "down", thenProduce: "j"),
    SingleMatchRecognizer(string: "left", thenProduce: "h"),
    SingleMatchRecognizer(string: "right", thenProduce: "l"),
    // Meta
    ContinuousCommandRecognizer(command: "say", transform: { string in string + " " }),
    ContinuousCommandRecognizer(command: "camel", transform: { string in string.capitalizedString }),
  ]



  class func scheduledBreakTimer(on on: DCViewController) -> NSTimer {
    return NSTimer.scheduledTimerWithTimeInterval(1.0, target: on, selector: #selector(DCViewController.insertBreak), userInfo: nil, repeats: false)
  }
  func rescheduleBreakTimer() {
    if let t = self.breakTimer { t.invalidate() }
    self.breakTimer = DCViewController.scheduledBreakTimer(on: self)
  }
  var breakTimer: NSTimer! = nil
  public func insertBreak() {
    // Flush the current word and insert a break.
    self.flushCurrentWord()

    print("<!>", terminator: "")
    self.inputWordStream.emit(InputElement.Break)
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)

    // Whenever our input stream emits a word, run it through our Grammar rules.
    self.inputWordStream.subscribe { input in
      switch input {
        case let .Word(word):
          // If we already have a transformer, continue to use it!
          if let currentTransformer = self.currentTransformer {
            let transformed = currentTransformer.transform(word)
            self.outputStream.emit(transformed)
          }
          // Otherwise, we need to check all of our command recognizers to see if any of them
          // will handle this.
          else {
            for recognizer in self.commandRecognizers {
              let result = recognizer.handle(word)
              switch result {
              case .Recognizing(let transformer):
                // Use the recognizer from here on out (but not for the instigating command word!)!
                self.currentTransformer = transformer
              case .Recognized(let transformer):
                // Just use this recognizer as a one-shot!
                let transformed = transformer.transform(word)
                self.outputStream.emit(transformed)
              default: break
              }
            }
          }

          break

        default:
          // Breaks always terminate our current transformer.
          self.currentTransformer = nil
          break
      }
    }

    // Connect our output stream.
    self.outputStream.subscribe(self.keyboardOutStream)             // ENABLE THIS LINE FOR WRITING TO TERMINAL
    self.outputStream.subscribe { print("\($0)", terminator: "") }
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
    print("<\(word)>", terminator: "")
    let strippedWord = word.stringByReplacingOccurrencesOfString(" ", withString: "")
    self.inputWordStream.emit(InputElement.Word(strippedWord))
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
