//
//  VimCommands.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/29/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

public let VimCompatibleCommands: [CommandRecognizer] = [
  // Numbers
  SingleMatchRecognizer(string: "first", thenProduce: "1"),
  SingleMatchRecognizer(string: "second", thenProduce: "2"),
  SingleMatchRecognizer(string: "third", thenProduce: "3"),
  SingleMatchRecognizer(string: "fourth", thenProduce: "4"),
  SingleMatchRecognizer(string: "fifth", thenProduce: "5"),
  SingleMatchRecognizer(string: "sixth", thenProduce: "6"),
  SingleMatchRecognizer(string: "seventh", thenProduce: "7"),
  SingleMatchRecognizer(string: "eighth", thenProduce: "8"),
  SingleMatchRecognizer(string: "ninth", thenProduce: "9"),

  // Command
  SingleMatchRecognizer(string: "input", thenProduce: "i"),
  SingleMatchRecognizer(string: "append", thenProduce: "a"),
  SingleMatchRecognizer(string: "over", thenProduce: "o"),
  SingleMatchRecognizer(string: "odor", thenProduce: "O"),
  SingleMatchRecognizer(string: "slurp", thenProduce: "d"),
  SingleMatchRecognizer(string: "change", thenProduce: "c"),
  SingleMatchRecognizer(string: "undo", thenProduce: "u"),

  // Movement
  SingleMatchRecognizer(string: "back", thenProduce: "b"),
  SingleMatchRecognizer(string: "send", thenProduce: "e"),
  SingleMatchRecognizer(string: "word", thenProduce: "w"),
  SingleMatchRecognizer(string: "dollar", thenProduce: "$"),
  SingleMatchRecognizer(string: "zero", thenProduce: "0"),
  SingleMatchRecognizer(string: "up", thenProduce: "k"),
  SingleMatchRecognizer(string: "down", thenProduce: "j"),
  SingleMatchRecognizer(string: "left", thenProduce: "h"),
  SingleMatchRecognizer(string: "right", thenProduce: "l"),
  SingleMatchRecognizer(string: "felt", thenProduce: "f"),
  SingleMatchRecognizer(string: "next", thenProduce: "n"),
  SingleMatchRecognizer(string: "beginning", thenProduce: "gg"),
  SingleMatchRecognizer(string: "ending", thenProduce: "G"),

  // Miscellaneous keys
  SingleMatchRecognizer(string: "suck", thenProduce: "<Escape>"),
  SingleMatchRecognizer(string: "slap", thenProduce: "<Return>"),
  SingleMatchRecognizer(string: "choke", thenProduce: "<Backspace>"),
  SingleMatchRecognizer(string: "shoot", thenProduce: "<Tab>"),
  SingleMatchRecognizer(string: "yup", thenProduce: " "),
  SingleMatchRecognizer(string: "lap", thenProduce: "("),
  SingleMatchRecognizer(string: "rap", thenProduce: ")"),
  SingleMatchRecognizer(string: "ring", thenProduce: "{"),
  SingleMatchRecognizer(string: "wrong", thenProduce: "}"),
  SingleMatchRecognizer(string: "bing", thenProduce: "["),
  SingleMatchRecognizer(string: "bong", thenProduce: "]"),
  SingleMatchRecognizer(string: "cold", thenProduce: ":"),
  SingleMatchRecognizer(string: "luke", thenProduce: ";"),
  SingleMatchRecognizer(string: "equal", thenProduce: "="),
  SingleMatchRecognizer(string: "plus", thenProduce: "+"),
  SingleMatchRecognizer(string: "minus", thenProduce: "-"),
  SingleMatchRecognizer(string: "lack", thenProduce: "<"),
  SingleMatchRecognizer(string: "rack", thenProduce: ">"),
  SingleMatchRecognizer(string: "squeak", thenProduce: "\""),
  SingleMatchRecognizer(string: "purse", thenProduce: "%"),
  SingleMatchRecognizer(string: "bang", thenProduce: "!"),
  SingleMatchRecognizer(string: "hash", thenProduce: "#"),
  SingleMatchRecognizer(string: "splat", thenProduce: "*"),
  SingleMatchRecognizer(string: "/", thenProduce: "/"),
  SingleMatchRecognizer(string: "slip", thenProduce: "\\"),
  SingleMatchRecognizer(string: "help", thenProduce: "h"),
  SingleMatchRecognizer(string: ",", thenProduce: ","),
  SingleMatchRecognizer(string: ".", thenProduce: "."),
  SingleMatchRecognizer(string: "join", thenProduce: "J"),
  SingleMatchRecognizer(string: "yes", thenProduce: "y"),
  SingleMatchRecognizer(string: "actor", thenProduce: "@"),
  SingleMatchRecognizer(string: "zoo", thenProduce: "z"),
  SingleMatchRecognizer(string: "till", thenProduce: "t"),
  SingleMatchRecognizer(string: "amp", thenProduce: "&"),

  // Multi-Key
  SingleMatchRecognizer(string: "chill", thenProduce: "::"),
  SingleMatchRecognizer(string: "shell", thenProduce: ":!"),
  SingleMatchRecognizer(string: "save", thenProduce: ":w"),
  SingleMatchRecognizer(string: "scram", thenProduce: ":q"),
  SingleMatchRecognizer(string: "sin", thenProduce: "int"),
  SingleMatchRecognizer(string: "sinning", thenProduce: "int64"),
  SingleMatchRecognizer(string: "soak", thenProduce: "float"),
  SingleMatchRecognizer(string: "soaking", thenProduce: "float64"),
  SingleMatchRecognizer(string: "double", thenProduce: "double"),
  SingleMatchRecognizer(string: "constant", thenProduce: "const"),
  SingleMatchRecognizer(string: "odd", thenProduce: "Ob"),
  SingleMatchRecognizer(string: "string", thenProduce: "Str"),
  SingleMatchRecognizer(string: "get", thenProduce: "git"),


  // Meta
  ContinuousCommandRecognizer(command: "say", makeHandlerBlock: { PassthroughTextHandler() }),
  ContinuousCommandRecognizer(command: "camel", makeHandlerBlock: { CamelCaseTransformer() }),
  ContinuousCommandRecognizer(command: "pesky", makeHandlerBlock: { PascalCaseTransformer() }),
  ContinuousCommandRecognizer(command: "under", makeHandlerBlock: { UnderscoredTransformer() }),
  ContinuousCommandRecognizer(command: "caps", makeHandlerBlock: { AllCapsTransformer() }),
  ContinuousCommandRecognizer(command: "squash", makeHandlerBlock: { NoSpacesTransformer() }),
  ContinuousCommandRecognizer(command: "dashing", makeHandlerBlock: { DashedTransformer() }),
]
