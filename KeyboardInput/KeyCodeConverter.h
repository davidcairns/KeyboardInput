//
//  KeyCodeConverter.h
//  KeyboardInput
//
//  Created by David Cairns on 6/24/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyCodeConverter : NSObject

+ (instancetype)sharedInstance;

- (CGKeyCode)keyCodeForCharString:(NSString *)charString;
- (CGKeyCode)keyCodeForCharacter:(unichar)character;
- (unichar)characterForKeyCode:(CGKeyCode)keyCode;

@end
