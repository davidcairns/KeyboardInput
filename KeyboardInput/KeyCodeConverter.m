//
//  KeyCodeConverter.m
//  KeyboardInput
//
//  Created by David Cairns on 6/24/16.
//  Copyright © 2016 David Cairns. All rights reserved.
//

#import "KeyCodeConverter.h"
#import <Carbon/Carbon.h>

@implementation KeyCodeConverter {
  // Single-characters NSString -> NSNumber-keycode.
  NSDictionary *_charStringsToKeyCodes;
}

+ (instancetype)sharedInstance {
  static KeyCodeConverter *__singleton = NULL;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    __singleton = [[KeyCodeConverter alloc] init];
  });
  return __singleton;
}

- (instancetype)init {
  if((self = [super init])) {
    NSMutableDictionary *const charsToCodes = [NSMutableDictionary dictionary];
    for(size_t i = 0; i < 128; i++) {
      const NSString *charString = [self charStringForKeyCode:(CGKeyCode)i];
      charsToCodes[charString] = @(i);
    }
    _charStringsToKeyCodes = [NSDictionary dictionaryWithDictionary:charsToCodes];
  }
  return self;
}


- (CGKeyCode)keyCodeForCharString:(NSString *)charString {
  return [self keyCodeForCharacter:[charString characterAtIndex:0]];
}

- (CGKeyCode)keyCodeForCharacter:(unichar)character {
  NSString *const charString = [NSString stringWithCharacters:&character length:1];
  NSNumber *const keyCodeNumber = _charStringsToKeyCodes[charString];
  return (CGKeyCode)keyCodeNumber.unsignedShortValue;
}

- (unichar)characterForKeyCode:(CGKeyCode)keyCode {
  TISInputSourceRef keyboard = TISCopyCurrentKeyboardInputSource();
  CFDataRef layoutData = TISGetInputSourceProperty(keyboard, kTISPropertyUnicodeKeyLayoutData);
  const UCKeyboardLayout *keyboardLayout = (const UCKeyboardLayout *)CFDataGetBytePtr(layoutData);

  const UInt32 keyAction = kUCKeyActionDisplay;
  const UInt32 modifierKeyState = 0;
  const UInt32 keyboardType = LMGetKbdType();
  const OptionBits keyTranslateOptions = kUCKeyTranslateNoDeadKeysBit;
  UInt32 keysDown = 0;
  unichar characters[4]; // we may have to store more than one character...
  const UniCharCount maxStringLength = sizeof(characters) / sizeof(unichar);
  UniCharCount actualLength = 0;
  const OSStatus err = UCKeyTranslate(keyboardLayout, keyCode, keyAction, modifierKeyState, keyboardType, keyTranslateOptions, &keysDown, maxStringLength, &actualLength, characters);
  if(err != noErr) {
    NSLog(@"Error translating key code %x; error: %x", keyCode, err);
  }

  // ... but we just care about the first one.
  return characters[0];
}
- (NSString *)charStringForKeyCode:(CGKeyCode)keyCode {
  const unichar character = [self characterForKeyCode:keyCode];
  return [NSString stringWithCharacters:&character length:1];
}
@end



