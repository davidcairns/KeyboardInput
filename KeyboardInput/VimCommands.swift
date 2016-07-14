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
  SingleMatchRecognizer(string: "fourth", thenProduce: "4"),  SingleMatchRecognizer(string: "forth", thenProduce: "4"),
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
  SingleMatchRecognizer(string: "undo", thenProduce: "u"), SingleMatchRecognizer(string: "undue", thenProduce: "u"), // homophones!!!!
  SingleMatchRecognizer(string: "redo", thenProduce: "C-r"),
  SingleMatchRecognizer(string: "yank", thenProduce: "y"),
  SingleMatchRecognizer(string: "put", thenProduce: "p"),
  SingleMatchRecognizer(string: "chum", thenProduce: "x"),
  SingleMatchRecognizer(string: "replace", thenProduce: "r"),

  // Movement
  SingleMatchRecognizer(string: "back", thenProduce: "b"),
  SingleMatchRecognizer(string: "send", thenProduce: "e"),
  SingleMatchRecognizer(string: "word", thenProduce: "w"),
  SingleMatchRecognizer(string: "dollar", thenProduce: "$"),
  SingleMatchRecognizer(string: "zero", thenProduce: "0"),
//  SingleMatchRecognizer(string: "up", thenProduce: "k"),
//  SingleMatchRecognizer(string: "down", thenProduce: "j"),
//  SingleMatchRecognizer(string: "left", thenProduce: "h"),
//  SingleMatchRecognizer(string: "right", thenProduce: "l"),
	SingleMatchRecognizer(string: "up", thenProduce: "<UpArrow>"),
	SingleMatchRecognizer(string: "down", thenProduce: "<DownArrow>"),
	SingleMatchRecognizer(string: "left", thenProduce: "<LeftArrow>"),
	SingleMatchRecognizer(string: "right", thenProduce: "<RightArrow>"),
  SingleMatchRecognizer(string: "felt", thenProduce: "f"),
  SingleMatchRecognizer(string: "next", thenProduce: "n"),
  SingleMatchRecognizer(string: "beginning", thenProduce: "gg"),
  SingleMatchRecognizer(string: "ending", thenProduce: "G"),          // FIXME: Fix support for capital letters!

  // Miscellaneous keys
  SingleMatchRecognizer(string: "suck", thenProduce: "<Escape>"),
  SingleMatchRecognizer(string: "slap", thenProduce: "<Return>"),
  SingleMatchRecognizer(string: "buck", thenProduce: "<Backspace>"),
  SingleMatchRecognizer(string: "shoot", thenProduce: "<Tab>"),
  SingleMatchRecognizer(string: "yup", thenProduce: " "),  SingleMatchRecognizer(string: "yep", thenProduce: " "),
  SingleMatchRecognizer(string: "lap", thenProduce: "("),
  SingleMatchRecognizer(string: "rap", thenProduce: ")"),  SingleMatchRecognizer(string: "wrap", thenProduce: ")"),
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
  SingleMatchRecognizer(string: "query", thenProduce: "?"),
//  SingleMatchRecognizer(string: "hash", thenProduce: "#"),
  SingleMatchRecognizer(string: "splat", thenProduce: "*"),
  SingleMatchRecognizer(string: "splash", thenProduce: "/"),
//  SingleMatchRecognizer(string: "blunder", thenProduce: "_"),               // FIXME: Fix support for capital letters!
  SingleMatchRecognizer(string: "slip", thenProduce: "\\"),
  SingleMatchRecognizer(string: "help", thenProduce: "h"),
  SingleMatchRecognizer(string: "crow", thenProduce: ","),  SingleMatchRecognizer(string: "sham", thenProduce: "."),
  SingleMatchRecognizer(string: "crap", thenProduce: "."),  SingleMatchRecognizer(string: "shim", thenProduce: ","),
  SingleMatchRecognizer(string: "join", thenProduce: "J"),            // FIXME: Fix support for capital letters!
  SingleMatchRecognizer(string: "yes", thenProduce: "y"),
  SingleMatchRecognizer(string: "actor", thenProduce: "@"),
  SingleMatchRecognizer(string: "zoo", thenProduce: "z"),
  SingleMatchRecognizer(string: "till", thenProduce: "t"),
  SingleMatchRecognizer(string: "amp", thenProduce: "&"),
  SingleMatchRecognizer(string: "velcro", thenProduce: "v"),

  // Multi-Key Macros
  SingleMatchRecognizer(string: "comment", thenProduce: "// "),
  SingleMatchRecognizer(string: "chill", thenProduce: "::"),
  SingleMatchRecognizer(string: "shell", thenProduce: ":!"),
  SingleMatchRecognizer(string: "save", thenProduce: ":w "),
  SingleMatchRecognizer(string: "edit", thenProduce: ":e "),
  SingleMatchRecognizer(string: "darken", thenProduce: ":nohl"),
//  SingleMatchRecognizer(string: "arrow", thenProduce: "->"),          // FIXME!
  SingleMatchRecognizer(string: "scram", thenProduce: ":q"),
  SingleMatchRecognizer(string: "sin", thenProduce: "int "),
  SingleMatchRecognizer(string: "sinning", thenProduce: "int64 "),
  SingleMatchRecognizer(string: "soak", thenProduce: "float "),
  SingleMatchRecognizer(string: "soaking", thenProduce: "float64 "),
  SingleMatchRecognizer(string: "double", thenProduce: "double "),
  SingleMatchRecognizer(string: "boolean", thenProduce: "bool "),
  SingleMatchRecognizer(string: "constant", thenProduce: "const "),
  SingleMatchRecognizer(string: "structure", thenProduce: "struct "),
  SingleMatchRecognizer(string: "classy", thenProduce: "class "),
  SingleMatchRecognizer(string: "odd", thenProduce: "Ob"),
  SingleMatchRecognizer(string: "string", thenProduce: "Str "),
  SingleMatchRecognizer(string: "get", thenProduce: "git "),
  SingleMatchRecognizer(string: "seedy", thenProduce: "cd "),
  SingleMatchRecognizer(string: "pseudo", thenProduce: "sudo "),
  SingleMatchRecognizer(string: "if", thenProduce: "if "),
  SingleMatchRecognizer(string: "else", thenProduce: "else "),
  SingleMatchRecognizer(string: "vim", thenProduce: "vim "),
  SingleMatchRecognizer(string: "blogger", thenProduce: "OB_LOG_ERROR "),

  // Control-commands
  SingleMatchRecognizer(string: "cabbie", thenProduce: "C-b"),
  SingleMatchRecognizer(string: "coffin", thenProduce: "C-w"),

  // Meta
  ContinuousCommandRecognizer(command: "say", makeHandlerBlock: { PassthroughTextHandler() }),
  ContinuousCommandRecognizer(command: "camel", makeHandlerBlock: { CamelCaseTransformer() }),
  ContinuousCommandRecognizer(command: "pesky", makeHandlerBlock: { PascalCaseTransformer() }),
  ContinuousCommandRecognizer(command: "under", makeHandlerBlock: { UnderscoredTransformer() }),
  ContinuousCommandRecognizer(command: "caps", makeHandlerBlock: { AllCapsTransformer() }),
  ContinuousCommandRecognizer(command: "squash", makeHandlerBlock: { NoSpacesTransformer() }),
  ContinuousCommandRecognizer(command: "dashing", makeHandlerBlock: { DashedTransformer() }),
]
