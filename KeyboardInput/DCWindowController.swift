//
//  DCWindowController.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/26/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Cocoa

/*  We should ensure that our main window's controller is an instance of this class;
 *  this allows our view controller to handle arbitrary key messages without
 *  eventually falling back to the default window controller's "unhandled message"
 *  functionality, which causes a system BEEP whenever a keydown occurs. --DRC
 */

final class DCWindowController: NSWindowController {
  override func noResponder(for eventSelector: Selector) {}
  override func doCommand(by aSelector: Selector) {}
  override func `try`(toPerform anAction: Selector, with anObject: Any?) -> Bool { return true }
}
