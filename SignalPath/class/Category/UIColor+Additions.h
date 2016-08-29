//
//  UIColor+Additions.h
//  SignalPath
//
//  Created by hsujahhu on 2016/8/29.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)
- (UIColor *)darkerColor;
+ (UIColor *)colorWithHexString:(NSString *)hexValue alpha:(CGFloat)alpha;
@end
