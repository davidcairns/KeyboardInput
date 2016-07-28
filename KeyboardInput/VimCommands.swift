//
//  VimCommands.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/29/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

// These values map a word to a special character.
public let Shorthands: [String: String] = [
  // Movement
  "up": "<UpArrow>",
  "down": "<DownArrow>",
  "left": "<LeftArrow>",
  "right": "<RightArrow>",  "write": "<RightArrow>",

  // Miscellaneous
  "suck": "<Escape>",
  "slap": "<Return>",       "slab": "<Return>",
  "buck": "<Backspace>",    "book": "<Backspace>",
  "shoot": "<Tab>",
  "pig": "<PageUp>",
  "piggy": "<PageDown>",
  "bone": "<Home>",
  "bend": "<End>",
  "go": " ",
  "lap": "(",
  "rap": ")",               "wrap": ")",
  "ring": "{",
  "wrong": "}",
  "shim": "[",
  "sham": "]",
  "cold": ":",
  "luke": ";",
  "equal": "=",
  "plus": "+",
  "minus": "-",
  "lack": "<",
  "rack": ">",
  "squeak": "\"",
  "pip": "'",
  "purse": "%",
  "bang": "!",
  "query": "?",
  "splat": "*",
  "splash": "/",
  "blunder": "_",
  "hash": "#",              "cash": "#",
  "tile": "~",
  "slip": "\\",
  "actor": "@",
  "amp": "&",

  // Control-commands
  "cab": "C-q",
  "cough": "C-w",
  "redo": "C-r",
  "cancel": "C-c",
  "clear": "C-l",
  "visual": "C-v",
]

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
  SingleMatchRecognizer(string: "apple", thenProduce: "A"),
  SingleMatchRecognizer(string: "over", thenProduce: "O"),
  SingleMatchRecognizer(string: "odor", thenProduce: "o"),
  SingleMatchRecognizer(string: "slurp", thenProduce: "d"),
  SingleMatchRecognizer(string: "change", thenProduce: "c"),
  SingleMatchRecognizer(string: "undo", thenProduce: "u"), SingleMatchRecognizer(string: "undue", thenProduce: "u"),
  SingleMatchRecognizer(string: "yank", thenProduce: "y"),
  SingleMatchRecognizer(string: "put", thenProduce: "p"),
  SingleMatchRecognizer(string: "paste", thenProduce: "P"),
  SingleMatchRecognizer(string: "chum", thenProduce: "x"),
  SingleMatchRecognizer(string: "replace", thenProduce: "r"),

  // Movement
  SingleMatchRecognizer(string: "back", thenProduce: "b"),
  SingleMatchRecognizer(string: "send", thenProduce: "e"),
  SingleMatchRecognizer(string: "word", thenProduce: "w"),
  SingleMatchRecognizer(string: "dollar", thenProduce: "$"),
  SingleMatchRecognizer(string: "zero", thenProduce: "0"),
  SingleMatchRecognizer(string: "felt", thenProduce: "f"),
  SingleMatchRecognizer(string: "next", thenProduce: "n"),
  SingleMatchRecognizer(string: "beginning", thenProduce: "gg"),
  SingleMatchRecognizer(string: "ending", thenProduce: "G"),

  // Miscellaneous keys
  SingleMatchRecognizer(string: "help", thenProduce: "h"),
  SingleMatchRecognizer(string: "crow", thenProduce: ","),
  SingleMatchRecognizer(string: "crap", thenProduce: "."),
  SingleMatchRecognizer(string: "join", thenProduce: "J"),
  SingleMatchRecognizer(string: "yes", thenProduce: "y"),
  SingleMatchRecognizer(string: "zoom", thenProduce: "z"),
  SingleMatchRecognizer(string: "top", thenProduce: "t"),
  SingleMatchRecognizer(string: "velcro", thenProduce: "v"),
  SingleMatchRecognizer(string: "goat", thenProduce: "G"),

  // Multi-Key Macros
  SingleMatchRecognizer(string: "comment", thenProduce: "// "),
  SingleMatchRecognizer(string: "chill", thenProduce: "::"),
  SingleMatchRecognizer(string: "shell", thenProduce: ":!"),
  SingleMatchRecognizer(string: "save", thenProduce: ":w "),
  SingleMatchRecognizer(string: "edit", thenProduce: ":e "),
  SingleMatchRecognizer(string: "darken", thenProduce: ":nohl"),
  SingleMatchRecognizer(string: "arrow", thenProduce: "->"),          // FIXME: STILL BROKEN WTF --DRC
  SingleMatchRecognizer(string: "scram", thenProduce: ":q"),
  SingleMatchRecognizer(string: "topper", thenProduce: "zt"),
  SingleMatchRecognizer(string: "glint", thenProduce: "int "),
  SingleMatchRecognizer(string: "glinting", thenProduce: "int64 "),
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
  SingleMatchRecognizer(string: "seedy", thenProduce: "cd "),  SingleMatchRecognizer(string: "CD", thenProduce: "cd "),
  SingleMatchRecognizer(string: "pseudo", thenProduce: "sudo "),  SingleMatchRecognizer(string: "pseudo-", thenProduce: "sudo "),
  SingleMatchRecognizer(string: "if", thenProduce: "if"),
  SingleMatchRecognizer(string: "else", thenProduce: "else "),
  SingleMatchRecognizer(string: "vixen", thenProduce: "vim "),
  SingleMatchRecognizer(string: "blogger", thenProduce: "OB_LOG_ERROR "),
  SingleMatchRecognizer(string: "test", thenProduce: "TEST"),
  SingleMatchRecognizer(string: "testy", thenProduce: "TESTF"),

  // Meta
  ContinuousCommandRecognizer(command: "say", makeHandlerBlock: { PassthroughTextHandler() }),
  ContinuousCommandRecognizer(command: "camel", makeHandlerBlock: { CamelCaseTransformer() }),
  ContinuousCommandRecognizer(command: "pesky", makeHandlerBlock: { PascalCaseTransformer() }),
  ContinuousCommandRecognizer(command: "under", makeHandlerBlock: { UnderscoredTransformer() }),
  ContinuousCommandRecognizer(command: "caps", makeHandlerBlock: { AllCapsTransformer() }),
  ContinuousCommandRecognizer(command: "squash", makeHandlerBlock: { NoSpacesTransformer() }),
  ContinuousCommandRecognizer(command: "dashing", makeHandlerBlock: { DashedTransformer() }),
  ContinuousCommandRecognizer(command: "path", makeHandlerBlock: { SlashedTransformer() }),
  ContinuousCommandRecognizer(command: "spelling", makeHandlerBlock: { SpellingTransformer() }),
  ContinuousCommandRecognizer(command: "fatso", makeHandlerBlock: { CapsSpellingTransformer() }),
] +
  // Add all the Shorthand pairs as single-match recognizers.
  Shorthands.map { SingleMatchRecognizer(string: $0.0, thenProduce: $0.1) }

