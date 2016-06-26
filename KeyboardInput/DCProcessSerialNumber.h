//
//  DCProcessSerialNumber.h
//  KeyboardInput
//
//  Created by David Cairns on 6/24/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DCProcessSerialNumber : NSObject

- (instancetype)initWithPid:(pid_t)pid;

- (ProcessSerialNumber *)ptr;

@end
