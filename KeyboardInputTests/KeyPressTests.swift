//
//  KeyPressTests.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/29/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import XCTest
@testable import KeyboardInput

func ==(lhs: KeyPress, rhs: KeyPress) -> Bool {
  return lhs.key == rhs.key && lhs.modifiers.count == rhs.modifiers.count && lhs.modifiers.reduce(true) { $0 && rhs.modifiers.contains($1) }
}

class KeyPress_Tests: XCTestCase {
  func testEscape() { XCTAssertEqual(Key.escape, Key.from(string: "<Escape>")) }
  func testReturn() { XCTAssertEqual(Key.return, Key.from(string: "<Return>")) }
  func testRunEscape() { XCTAssertEqual(1, KeyPress.from(string: "<Escape>").count) }
  func testRunReturn() { XCTAssertEqual(1, KeyPress.from(string: "<Return>").count) }
  func testPressEscapeKey() { XCTAssertEqual(Key.escape, KeyPress.from(string: "<Escape>").first!.key) }
  func testPressEscapeModifiers() { XCTAssertEqual([], KeyPress.from(string: "<Escape>").first!.modifiers) }
  func testPressReturnKey() { XCTAssertEqual(Key.return, KeyPress.from(string: "<Return>").first!.key) }
  func testPressReturnModifiers() { XCTAssertEqual([], KeyPress.from(string: "<Return>").first!.modifiers) }

  func testSpace()        { XCTAssertEqual(Key.space, Key.from(string: " ")) }
  func testLeftParen()    { XCTAssertEqual(Key.leftParen, Key.from(string: "(")) }
  func testRightParen()   { XCTAssertEqual(Key.rightParen, Key.from(string: ")")) }
  func testLeftBrace()    { XCTAssertEqual(Key.leftBrace, Key.from(string: "{")) }
  func testRightBrace()   { XCTAssertEqual(Key.rightBrace, Key.from(string: "}")) }
  func testLeftBracket()  { XCTAssertEqual(Key.leftBracket, Key.from(string: "[")) }
  func testRightBracket() { XCTAssertEqual(Key.rightBracket, Key.from(string: "]")) }
  func testColon()        { XCTAssertEqual(Key.colon, Key.from(string: ":")) }

  func test_a_DoesntHaveShift() { XCTAssertFalse(KeyPress.from(character: "a")!.modifiers.contains(ModifierKey.shift)) }
  func test_A_HasShift() { XCTAssertTrue(KeyPress.from(character: "A")!.modifiers.contains(ModifierKey.shift)) }
  func testUnderscoreHasShift() { XCTAssertTrue(KeyPress.from(character: "_")!.modifiers.contains(ModifierKey.shift)) }
  func testLeftParenHasShift() { XCTAssertTrue(KeyPress.from(character: "(")!.modifiers.contains(ModifierKey.shift)) }
  func testRightParenHasShift() { XCTAssertTrue(KeyPress.from(character: ")")!.modifiers.contains(ModifierKey.shift)) }
  func testLeftBraceHasShift() { XCTAssertTrue(KeyPress.from(character: "{")!.modifiers.contains(ModifierKey.shift)) }
  func testRightBraceHasShift() { XCTAssertTrue(KeyPress.from(character: "}")!.modifiers.contains(ModifierKey.shift)) }
  func testHashHasShift() { XCTAssertTrue(KeyPress.from(character: "#")!.modifiers.contains(ModifierKey.shift)) }
}
