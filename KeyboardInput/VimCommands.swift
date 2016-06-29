//
//  VimCommands.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/29/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

public let VimCompatibleCommands: [CommandRecognizer] = [
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
  SingleMatchRecognizer(string: "dollar", thenProduce: "$"),
  SingleMatchRecognizer(string: "zero", thenProduce: "0"),
  SingleMatchRecognizer(string: "up", thenProduce: "k"),
  SingleMatchRecognizer(string: "down", thenProduce: "j"),
  SingleMatchRecognizer(string: "left", thenProduce: "h"),
  SingleMatchRecognizer(string: "right", thenProduce: "l"),
  SingleMatchRecognizer(string: "begin", thenProduce: "gg"),
  SingleMatchRecognizer(string: "end", thenProduce: "G"),
  // Meta
  ContinuousCommandRecognizer(command: "say", makeHandlerBlock: { PassthroughTextHandler() }),
  ContinuousCommandRecognizer(command: "camel", makeHandlerBlock: { CamelCaseTransformer() }),
  ContinuousCommandRecognizer(command: "under", makeHandlerBlock: { UnderscoredTransformer() }),
  ContinuousCommandRecognizer(command: "caps", makeHandlerBlock: { AllCapsTransformer() }),
]
