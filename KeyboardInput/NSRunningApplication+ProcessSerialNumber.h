//
//  NSRunningApplication+ProcessSerialNumber.h
//  KeyboardInput
//
//  Created by David Cairns on 6/24/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "DCProcessSerialNumber.h"

@interface NSRunningApplication (ProcessSerialNumber)

@property(nonatomic, readonly)DCProcessSerialNumber *processSerialNumber;

@end
