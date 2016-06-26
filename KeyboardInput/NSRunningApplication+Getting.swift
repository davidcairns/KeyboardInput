//
//  NSRunningApplication+Getting.swift
//  KeyboardInput
//
//  Created by David Cairns on 6/26/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

import Foundation

extension NSRunningApplication {
  class func app(withBundleIdentifier bundleIdentifier: String) -> NSRunningApplication! {
    let matchingProcesses = NSRunningApplication.runningApplicationsWithBundleIdentifier(bundleIdentifier)
    if matchingProcesses.count == 0 {
      print("Couldn’t find app with identifier '\(bundleIdentifier)'")
      return nil
    }

    // Get Terminal’s pid.
    return matchingProcesses.first
  }
}
