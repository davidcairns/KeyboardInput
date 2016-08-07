//
//  CommandRecognizer+Tests.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/29/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import XCTest
@testable import KeyboardInput

class CommandProcessor_Tests: XCTestCase {
  var commandProcessor: CommandProcessor = CommandProcessor(commandRecognizers: VimCompatibleCommands)

  internal func resultOf(input: String) -> String {
    var result: String = ""
    self.commandProcessor.outputStream.subscribe { result = result + $0 }

    let words = input.componentsSeparatedByString(" ")
    for word in words {
      self.commandProcessor.caughtWord(word)
    }
    return result
  }

  // Command
  func testIn() { XCTAssertEqual("i", resultOf("input")) }
  func testDelete() { XCTAssertEqual("d", resultOf("slurp")) }
  func testChange() { XCTAssertEqual("c", resultOf("change")) }
  func testUndo() { XCTAssertEqual("u", resultOf("undo")) }
  // Movement
  func testBack() { XCTAssertEqual("b", resultOf("back")) }
  func testEnd() { XCTAssertEqual("e", resultOf("send")) }
  func testWord() { XCTAssertEqual("w", resultOf("word")) }
  func testDollar() { XCTAssertEqual("$", resultOf("dollar")) }
  func testZero() { XCTAssertEqual("0", resultOf("zero")) }
  func testUp() { XCTAssertEqual("<UpArrow>", resultOf("up")) }
  func testDown() { XCTAssertEqual("<DownArrow>", resultOf("down")) }
  func testLeft() { XCTAssertEqual("<LeftArrow>", resultOf("left")) }
  func testRight() { XCTAssertEqual("<RightArrow>", resultOf("right")) }
  func testBeginning() { XCTAssertEqual("gg", resultOf("beginning")) }
  func testEnding() { XCTAssertEqual("G", resultOf("ending")) }

  // Miscellaneous keys
  func testHack() { XCTAssertEqual("<Escape>", resultOf("suck")) }
  func testSlap() { XCTAssertEqual("<Return>", resultOf("slap")) }
  func testSpace() { XCTAssertEqual(" ", resultOf("go")) }

  // Meta
  func testSay() { XCTAssertEqual("hello world", resultOf("say hello world")) }
  func testCamel() { XCTAssertEqual("helloWorld", resultOf("camel hello world")) }
  func testUnderscore() { XCTAssertEqual("hello_world", resultOf("under hello world")) }
  func testCaps() { XCTAssertEqual("HELLO_WORLD", resultOf("caps hello world")) }
}
