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
  func testEscape() { XCTAssertEqual(Key.Escape, Key.from(string: "<Escape>")) }
  func testReturn() { XCTAssertEqual(Key.Return, Key.from(string: "<Return>")) }
  func testRunEscape() { XCTAssertEqual(1, KeyPress.from(string: "<Escape>").count) }
  func testRunReturn() { XCTAssertEqual(1, KeyPress.from(string: "<Return>").count) }
  func testPressEscapeKey() { XCTAssertEqual(Key.Escape, KeyPress.from(string: "<Escape>").first!.key) }
  func testPressEscapeModifiers() { XCTAssertEqual([], KeyPress.from(string: "<Escape>").first!.modifiers) }
  func testPressReturnKey() { XCTAssertEqual(Key.Return, KeyPress.from(string: "<Return>").first!.key) }
  func testPressReturnModifiers() { XCTAssertEqual([], KeyPress.from(string: "<Return>").first!.modifiers) }

  func testSpace()        { XCTAssertEqual(Key.Space, Key.from(string: " ")) }
  func testLeftParen()    { XCTAssertEqual(Key.LeftParen, Key.from(string: "(")) }
  func testRightParen()   { XCTAssertEqual(Key.RightParen, Key.from(string: ")")) }
  func testLeftBrace()    { XCTAssertEqual(Key.LeftBrace, Key.from(string: "{")) }
  func testRightBrace()   { XCTAssertEqual(Key.RightBrace, Key.from(string: "}")) }
  func testLeftBracket()  { XCTAssertEqual(Key.LeftBracket, Key.from(string: "[")) }
  func testRightBracket() { XCTAssertEqual(Key.RightBracket, Key.from(string: "]")) }
  func testColon()        { XCTAssertEqual(Key.Colon, Key.from(string: ":")) }

  func test_a_DoesntHaveShift() { XCTAssertFalse(KeyPress.from(character: "a")!.modifiers.contains(ModifierKey.Shift)) }
  func test_A_HasShift() { XCTAssertTrue(KeyPress.from(character: "A")!.modifiers.contains(ModifierKey.Shift)) }
  func testUnderscoreHasShift() { XCTAssertTrue(KeyPress.from(character: "_")!.modifiers.contains(ModifierKey.Shift)) }
  func testLeftParenHasShift() { XCTAssertTrue(KeyPress.from(character: "(")!.modifiers.contains(ModifierKey.Shift)) }
  func testRightParenHasShift() { XCTAssertTrue(KeyPress.from(character: ")")!.modifiers.contains(ModifierKey.Shift)) }
  func testLeftBraceHasShift() { XCTAssertTrue(KeyPress.from(character: "{")!.modifiers.contains(ModifierKey.Shift)) }
  func testRightBraceHasShift() { XCTAssertTrue(KeyPress.from(character: "}")!.modifiers.contains(ModifierKey.Shift)) }
}
