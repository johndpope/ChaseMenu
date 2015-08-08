//
//  Theme.m
//  VVOpenSource
//
//  Created by John Pope on 17/02/2015.
//
//

#import "Theme.h"
#import "NSColor+Extension.h"


@implementation Theme

+ (Theme *)shared {
    static Theme *_me = NULL;
    if (_me == NULL)
        _me = [[Theme alloc] init];
    return _me;
}

- (id)init {
    self = [super init];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"toggleTheme" object:nil queue:[NSOperationQueue mainQueue] usingBlock: ^(NSNotification *note) {
        [Theme toggleTheme];
    }];
    return self;
}

+(BOOL)isDarkTheme{
    return YES;
}

//86898f
+ (NSColor *)fadedBgColor {
    if ([self isDarkTheme]) {
        return [NSColor colorFromHexString:@"535353"];
    }
    else {
        return [NSColor colorFromHexString:@"567bc7"];
    }
}

+ (NSColor *)bgColor {
    if ([self isDarkTheme]) {
        return [NSColor colorFromHexString:@"eeeeee"];
    }
    else {
        return [NSColor whiteColor];
    }
}

+ (NSColor *)bgOnColor {
    if ([self isDarkTheme]) {
        return [NSColor colorFromHexString:@"eeeeee"];
    }
    else {
        return [NSColor colorFromHexString:@"eeeeee"];
    }
}

+ (NSColor *)folderBG {
    if ([self isDarkTheme]) {
        return [NSColor colorFromHexString:@"3b3b3b"];
    }
    else {
        return [NSColor colorFromHexString:@"f8f8f8"];
    }
}

+ (NSColor *)iosdetail {
    if ([self isDarkTheme]) {
        return [NSColor colorWithWhite:0.537 alpha:1.000];
    }
    else {
        return [NSColor colorWithWhite:0.537 alpha:1.000];
    }
}

+ (NSColor *)headerBar {
    if ([self isDarkTheme]) {
        return [NSColor blackColor];
    }
    else {
        return [NSColor colorFromHexString:@"f2f2f2"];
    }
}

+ (NSColor *)borderColor {
    if ([self isDarkTheme]) {
        return [NSColor whiteColor];
    }
    else {
        return [NSColor colorFromHexString:@"86898f"];
    }
}

+ (NSColor *)headerText {
    if ([self isDarkTheme]) {
        return [NSColor whiteColor];
    }
    else {
        return [NSColor colorFromHexString:@"86898f"];
    }
}




@end
