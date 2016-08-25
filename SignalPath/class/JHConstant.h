//
//  JHConstant.h
//  SignalPath
//
//  Created by hsujahhu on 2016/8/26.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#ifndef JHConstant_h
#define JHConstant_h

#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)

#define kStatusBarHeight 20.f

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#endif /* JHConstant_h */
