//
//  JHConstants.h
//  SignalPath
//
//  Created by hsujahhu on 2016/8/27.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)

#define kStatusBarHeight 20.f

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

typedef NS_ENUM(NSInteger,JHErrorCode) {
    
    JHErrorCodeParsingErorr = 1001,
    
};
