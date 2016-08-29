//
//  UIColor+Additions.m
//  SignalPath
//
//  Created by hsujahhu on 2016/8/29.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

+ (UIColor *)colorWithHexString:(NSString *)hexValue alpha:(CGFloat)alpha
{
    UIColor *defaultResult = [UIColor whiteColor];
    if ([hexValue hasPrefix:@"#"] && [hexValue length] > 1) {
        hexValue = [hexValue substringFromIndex:1];
    }
    NSUInteger componentLength = 0;
    if ([hexValue length] == 3) {
        componentLength = 1;
    } else if ([hexValue length] == 6) {
        componentLength = 2;
    } else {
        return defaultResult;
    }
    
    BOOL isValid = YES;
    CGFloat components[3];
    
    for (NSUInteger i = 0; i < 3; i++) {
        NSString *component = [hexValue substringWithRange:NSMakeRange(componentLength * i, componentLength)];
        if (componentLength == 1) {
            component = [component stringByAppendingString:component];
        }
        NSScanner *scanner = [NSScanner scannerWithString:component];
        unsigned int value;
        isValid &= [scanner scanHexInt:&value];
        components[i] = (CGFloat)value / 255.0f;
    }
    if (!isValid)
        return defaultResult;
    
    return [UIColor colorWithRed:components[0]
                           green:components[1]
                            blue:components[2]
                           alpha:alpha];
}

- (UIColor *)darkerColor {
    
    CGFloat r, g, b, a;
    if ([self getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.06, 0.0)
                               green:MAX(g - 0.06, 0.0)
                                blue:MAX(b - 0.06, 0.0)
                               alpha:a];
    return nil;
}
@end
