//
//  NSString+FFExtension.m
//  FFExtension
//
//  Created by hufeng on 21/9/18.
//  Copyright © 2018年 shensz. All rights reserved.
//

#import "NSString+FFExtension.h"
#import "NSObject+methodSwizzle.h"
#import <objc/runtime.h>

@implementation NSString (FFExtension)

+ (void)startHook
{
    Class originClass = NSClassFromString(@"__NSCFConstantString");
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(characterAtIndex:) swizzleSelector:@selector(ff_characterAtIndex:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(substringFromIndex:) swizzleSelector:@selector(ff_substringFromIndex:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(substringToIndex:) swizzleSelector:@selector(ff_substringToIndex:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(substringWithRange:) swizzleSelector:@selector(ff_substringWithRange:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(hasPrefix:) swizzleSelector:@selector(ff_hasPrefix:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(hasSuffix:) swizzleSelector:@selector(ff_hasSuffix:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(rangeOfString:options:range:locale:) swizzleSelector:@selector(ff_rangeOfString:options:range:locale:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(rangeOfComposedCharacterSequenceAtIndex:) swizzleSelector:@selector(ff_rangeOfComposedCharacterSequenceAtIndex:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(rangeOfComposedCharacterSequencesForRange:) swizzleSelector:@selector(ff_rangeOfComposedCharacterSequencesForRange:)];
    [self ff_instancenSwizzleWithClass:originClass originSelector:@selector(stringByAppendingString:) swizzleSelector:@selector(ff_stringByAppendingString:)];
    
    
    ///< mutable
    [self ff_instancenSwizzleWithClass:NSClassFromString(@"__NSCFString") originSelector:@selector(characterAtIndex:) swizzleSelector:@selector(ff_characterAtIndex:)];
    
}

- (unichar)ff_characterAtIndex:(NSUInteger)index
{
    if (index < self.length) {
        return [self ff_characterAtIndex:index];
    }
    
    NSLog(@"capture crash, index %lu is out of bounds 0...%lu", index, self.length);
    
    return 0;
}



- (NSString *)ff_substringFromIndex:(NSUInteger)from
{
    if (from < self.length) {
        return [self ff_substringFromIndex:from];
    }
    
    return nil;
}

- (NSString *)ff_substringToIndex:(NSUInteger)to
{
    if (to < self.length) {
        return [self ff_substringFromIndex:to];
    }
    
    return nil;
}

- (NSString *)ff_substringWithRange:(NSRange)range
{
    if (range.location + range.length < self.length) {
        return [self ff_substringWithRange:range];
    }
    
    return nil;
}

- (BOOL)ff_hasPrefix:(NSString *)str
{
    if (str) {
        return [self ff_hasPrefix:str];
    }
    
    return NO;
}

- (BOOL)ff_hasSuffix:(NSString *)str
{
    if (str) {
        return [self ff_hasSuffix:str];
    }
    
    return NO;
}

- (NSRange)ff_rangeOfString:(NSString *)searchString options:(NSStringCompareOptions)mask range:(NSRange)rangeOfReceiverToSearch locale:(nullable NSLocale *)locale
{
    if (searchString && rangeOfReceiverToSearch.location + rangeOfReceiverToSearch.length < self.length) {
        return [self ff_rangeOfString:searchString options:mask range:rangeOfReceiverToSearch locale:locale];
    }
    
    return NSMakeRange(0, 0);
}

- (NSRange)ff_rangeOfComposedCharacterSequenceAtIndex:(NSUInteger)index
{
    if (index < self.length) {
        return [self ff_rangeOfComposedCharacterSequenceAtIndex:index];
    }
    
    return NSMakeRange(0, 0);
}

- (NSRange)ff_rangeOfComposedCharacterSequencesForRange:(NSRange)range API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0))
{
    if (range.location + range.length < self.length) {
        return [self ff_rangeOfComposedCharacterSequencesForRange:range];
    }
    
    return NSMakeRange(0, 0);
}

- (NSString *)ff_stringByAppendingString:(NSString *)aString
{
    if (aString) {
        return [self ff_stringByAppendingString:aString];
    }
    
    return self;
}


/*
- (void)replaceCharactersInRange:(NSRange)range withString:(NSString *)aString;
- (void)insertString:(NSString *)aString atIndex:(NSUInteger)loc;
- (void)deleteCharactersInRange:(NSRange)range;
- (void)appendString:(NSString *)aString;
- (void)appendFormat:(NSString *)format, ... NS_FORMAT_FUNCTION(1,2);
- (void)setString:(NSString *)aString;

*/


@end