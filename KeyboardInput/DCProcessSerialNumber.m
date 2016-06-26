//
//  DCProcessSerialNumber.m
//  KeyboardInput
//
//  Created by David Cairns on 6/24/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

#import "DCProcessSerialNumber.h"

@implementation DCProcessSerialNumber {
  ProcessSerialNumber _psn;
  BOOL _valid;
}

//#pragma clang diagnostic push
//#pragma clang diagnost ignore "-Wdeprecated-declarations"
- (instancetype)initWithPid:(pid_t)pid {
  if((self = [super init])) {
    const OSStatus psnErr = GetProcessForPID(pid, &_psn);
    if(psnErr != noErr) {
      NSLog(@"Failed to get Terminal’s PSN, with err: %x", psnErr);
      _valid = NO;
    }
    else {
      _valid = YES;
    }
  }
  return self;
}
//#pragma clang diagnostic pop

- (ProcessSerialNumber *)ptr {
  if(!_valid) {
    return NULL;
  }
  return &_psn;
}
@end
