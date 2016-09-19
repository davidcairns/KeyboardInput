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

  // Specific Keys / Characters
  "suck": "<Escape>",       "sucks": "<Escape>",
  "slap": "<Return>",       "slaps": "<Return>",       "slapped": "<Return>",       "slab": "<Return>",   "bam": "<Return>",   "ban": "<Return>",
  "buck": "<Backspace>",    "book": "<Backspace>",
  "shoot": "<Tab>",         "shoots": "<Tab>",
  "pig": "<PageUp>",
  "piggy": "<PageDown>",
  "bone": "<Home>",
  "bend": "<End>",
  "go": " ",
  "crow": ",",
  "crap": ".",
  "lap": "(",
  "rap": ")",               "wrap": ")",
  "ring": "{",
  "wrong": "}",
  "shim": "[",
  "sham": "]",
  "cold": ":",
  "luke": ";",
  "pipe": "|",
  "equal": "=",
  "plus": "+",
  "minus": "-",
  "lake": "<",
  "rake": ">",  "raking": ">>",
  "squeak": "\"",
  "pipsqueak": "'",
  "purse": "%",
  "bang": "!",
  "query": "?",
  "splat": "*",
  "splash": "/",            "swim": "/",
  "blunder": "_",
  "hash": "#",              "cash": "#",
  "tile": "~",
  "slip": "\\",
  "actor": "@",
  "amp": "&",

  // Useful multi-key sequences
  "chill": "::",
  "header": ".h",
  "call": "()",
  "ms.": "mz",
  "mrs.": "mezz",
  "dr.": "docker",
]

// Formatters are special -- we should let them interrupt each other so we don’t have to e.g. pause mid-
// sentence if trying to output "Then we check VimCompatibleCommands for compatible handlers".
public let Formatters: [CommandRecognizer] = [
  ContinuousCommandRecognizer(command: "say", makeHandlerBlock: { PassthroughTextHandler() }),  ContinuousCommandRecognizer(command: "run", makeHandlerBlock: { PassthroughTextHandler() }),
  ContinuousCommandRecognizer(command: "camel", makeHandlerBlock: { CamelCaseTransformer() }),
  ContinuousCommandRecognizer(command: "pesky", makeHandlerBlock: { PascalCaseTransformer() }),
  ContinuousCommandRecognizer(command: "under", makeHandlerBlock: { UnderscoredTransformer() }),
  ContinuousCommandRecognizer(command: "caps", makeHandlerBlock: { AllCapsTransformer() }),
  ContinuousCommandRecognizer(command: "squash", makeHandlerBlock: { NoSpacesTransformer() }),
  ContinuousCommandRecognizer(command: "dashing", makeHandlerBlock: { DashedTransformer() }),
  ContinuousCommandRecognizer(command: "path", makeHandlerBlock: { SlashedTransformer() }),
  ContinuousCommandRecognizer(command: "spelling", makeHandlerBlock: { SpellingTransformer() }),
  ContinuousCommandRecognizer(command: "bigger", makeHandlerBlock: { CapsSpellingTransformer() }),
  ContinuousCommandRecognizer(command: "sentence", makeHandlerBlock: { SentenceTextHandler() }),
]

public let VimCompatibleCommands: [CommandRecognizer] = [
  // Numbers
  SingleMatchRecognizer(string: "first", thenProduce: "1"),  SingleMatchRecognizer(string: "1st", thenProduce: "2"),
  SingleMatchRecognizer(string: "second", thenProduce: "2"),  SingleMatchRecognizer(string: "2nd", thenProduce: "2"),
  SingleMatchRecognizer(string: "third", thenProduce: "3"),  SingleMatchRecognizer(string: "3rd", thenProduce: "2"),
  SingleMatchRecognizer(string: "fourth", thenProduce: "4"),  SingleMatchRecognizer(string: "forth", thenProduce: "4"),
  SingleMatchRecognizer(string: "fifth", thenProduce: "5"),  SingleMatchRecognizer(string: "5th", thenProduce: "2"),
  SingleMatchRecognizer(string: "sixth", thenProduce: "6"),  SingleMatchRecognizer(string: "6th", thenProduce: "2"),
  SingleMatchRecognizer(string: "seventh", thenProduce: "7"),  SingleMatchRecognizer(string: "7th", thenProduce: "2"),
  SingleMatchRecognizer(string: "eighth", thenProduce: "8"),  SingleMatchRecognizer(string: "8th", thenProduce: "2"),
  SingleMatchRecognizer(string: "ninth", thenProduce: "9"),  SingleMatchRecognizer(string: "9th", thenProduce: "2"),

  // Command
  SingleMatchRecognizer(string: "input", thenProduce: "i"),
  SingleMatchRecognizer(string: "indigo", thenProduce: "I"),
  SingleMatchRecognizer(string: "append", thenProduce: "a"),
  SingleMatchRecognizer(string: "apple", thenProduce: "A"),
  SingleMatchRecognizer(string: "over", thenProduce: "O"),
  SingleMatchRecognizer(string: "odor", thenProduce: "o"),
  SingleMatchRecognizer(string: "slurp", thenProduce: "d"),
  SingleMatchRecognizer(string: "slurping", thenProduce: "dd"),
  SingleMatchRecognizer(string: "change", thenProduce: "c"),
  SingleMatchRecognizer(string: "undo", thenProduce: "u"), SingleMatchRecognizer(string: "undue", thenProduce: "u"),
  SingleMatchRecognizer(string: "yank", thenProduce: "y"),  SingleMatchRecognizer(string: "yanking", thenProduce: "yy"),
  SingleMatchRecognizer(string: "put", thenProduce: "p"),  SingleMatchRecognizer(string: "puts", thenProduce: "p"),
  SingleMatchRecognizer(string: "paste", thenProduce: "P"),
  SingleMatchRecognizer(string: "chum", thenProduce: "x"),
  SingleMatchRecognizer(string: "replace", thenProduce: "r"),

  // Movement
  SingleMatchRecognizer(string: "back", thenProduce: "b"),
  SingleMatchRecognizer(string: "send", thenProduce: "e"),  SingleMatchRecognizer(string: "sent", thenProduce: "e"),
  SingleMatchRecognizer(string: "word", thenProduce: "w"),
  SingleMatchRecognizer(string: "dollar", thenProduce: "$"),
  SingleMatchRecognizer(string: "zero", thenProduce: "0"),
  SingleMatchRecognizer(string: "felt", thenProduce: "f"),
  SingleMatchRecognizer(string: "next", thenProduce: "n"),
  SingleMatchRecognizer(string: "previous", thenProduce: "N"),
  SingleMatchRecognizer(string: "step", thenProduce: "s"),
  SingleMatchRecognizer(string: "beginning", thenProduce: "gg"),
  SingleMatchRecognizer(string: "ending", thenProduce: "G"),

  // Miscellaneous keys
  SingleMatchRecognizer(string: "help", thenProduce: "h"),
  SingleMatchRecognizer(string: "join", thenProduce: "J"),
  SingleMatchRecognizer(string: "yes", thenProduce: "y"),
  SingleMatchRecognizer(string: "zoom", thenProduce: "z"),  SingleMatchRecognizer(string: "zooms", thenProduce: "z"),
  SingleMatchRecognizer(string: "top", thenProduce: "t"),
  SingleMatchRecognizer(string: "topping", thenProduce: "T"),
  SingleMatchRecognizer(string: "velcro", thenProduce: "v"),
  SingleMatchRecognizer(string: "vines", thenProduce: "V"),
  SingleMatchRecognizer(string: "goat", thenProduce: "G"),

  // Multi-Key Macros
  SingleMatchRecognizer(string: "comment", thenProduce: "// "),
  SingleMatchRecognizer(string: "shell", thenProduce: ":!"),
  SingleMatchRecognizer(string: "save", thenProduce: ":w "),
  SingleMatchRecognizer(string: "edit", thenProduce: ":e "),
  SingleMatchRecognizer(string: "scram", thenProduce: ":q"),
  SingleMatchRecognizer(string: "servo", thenProduce: ":wa"),
  SingleMatchRecognizer(string: "psycho", thenProduce: ":wq"),
  SingleMatchRecognizer(string: "darken", thenProduce: ":nohl"),
  SingleMatchRecognizer(string: "arrow", thenProduce: "->"),          // FIXME: STILL BROKEN WTF --DRC
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
  SingleMatchRecognizer(string: "assign", thenProduce: " = "),
  SingleMatchRecognizer(string: "seedy", thenProduce: "cd "),  SingleMatchRecognizer(string: "cd", thenProduce: "cd "),
  SingleMatchRecognizer(string: "ellis", thenProduce: "ls "),
  SingleMatchRecognizer(string: "repo", thenProduce: "git "),
  SingleMatchRecognizer(string: "pseudo", thenProduce: "sudo "),  SingleMatchRecognizer(string: "pseudo-", thenProduce: "sudo "),  SingleMatchRecognizer(string: "suede", thenProduce: "sudo "),
  SingleMatchRecognizer(string: "if", thenProduce: "if"),
  SingleMatchRecognizer(string: "else", thenProduce: "else "),
  SingleMatchRecognizer(string: "blanket", thenProduce: "utf8"),
  SingleMatchRecognizer(string: "vixen", thenProduce: "vim "),
  SingleMatchRecognizer(string: "blogger", thenProduce: "OB_LOG_ERROR "),
  SingleMatchRecognizer(string: "test", thenProduce: "test"),
  SingleMatchRecognizer(string: "testy", thenProduce: "testf"),


  // Control-commands
  SingleMatchRecognizer(string: "tank", thenProduce: "C-q"),
  SingleMatchRecognizer(string: "cough", thenProduce: "C-w"),
  SingleMatchRecognizer(string: "redo", thenProduce: "C-r"),
  SingleMatchRecognizer(string: "cancel", thenProduce: "C-c"),
  SingleMatchRecognizer(string: "clear", thenProduce: "C-l"),
  SingleMatchRecognizer(string: "ace", thenProduce: "C-a"),
  SingleMatchRecognizer(string: "easy", thenProduce: "C-e"),
  SingleMatchRecognizer(string: "visual", thenProduce: "C-v"),
  SingleMatchRecognizer(string: "nancy", thenProduce: "C-n"),       // multi-cursor plug-in!
  SingleMatchRecognizer(string: "background", thenProduce: "C-z"),
  SingleMatchRecognizer(string: "foreground", thenProduce: "fg"),
]
  // Add all the Formatters
  + Formatters

  // Add all the Shorthand pairs as single-match recognizers.
  + Shorthands.map { SingleMatchRecognizer(string: $0.0, thenProduce: $0.1) }

