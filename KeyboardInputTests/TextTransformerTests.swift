//
//  TextTransformerTests.swift
//  KeyboardInput
//
//  Created by David Cairns on 7/3/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import XCTest
@testable import KeyboardInput

class TextTransformerTests: XCTestCase {
  let text = "mario and luigi"

  func runText(text: String, transformer: TextHandler) -> String {
    let words = text.componentsSeparatedByString(" ")
    return words.reduce("") { $0 + transformer.handle($1) }
  }

  func testSay() { XCTAssertEqual("mario and luigi", runText(text, transformer: PassthroughTextHandler())) }
  func testCamel() { XCTAssertEqual("marioAndLuigi", runText(text, transformer: CamelCaseTransformer())) }
  func testPascal() { XCTAssertEqual("MarioAndLuigi", runText(text, transformer: PascalCaseTransformer())) }
  func testUnderscore() { XCTAssertEqual("mario_and_luigi", runText(text, transformer: UnderscoredTransformer())) }
  func testAllCaps() { XCTAssertEqual("MARIO_AND_LUIGI", runText(text, transformer: AllCapsTransformer())) }
  func testDashed() { XCTAssertEqual("mario-and-luigi", runText(text, transformer: DashedTransformer())) }
}
