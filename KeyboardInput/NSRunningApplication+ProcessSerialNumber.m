//
//  NSRunningApplication+ProcessSerialNumber.m
//  KeyboardInput
//
//  Created by David Cairns on 6/24/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

#import "NSRunningApplication+ProcessSerialNumber.h"

@implementation NSRunningApplication (ProcessSerialNumber)
- (DCProcessSerialNumber *)processSerialNumber {
  return [[DCProcessSerialNumber alloc] initWithPid:self.processIdentifier];
}
@end
