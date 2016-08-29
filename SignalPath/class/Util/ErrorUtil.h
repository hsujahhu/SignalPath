//
//  ErrorUtil.h
//  SignalPath
//
//  Created by hsujahhu on 2016/8/27.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorUtil : NSError
+ (NSError *)errorWithCode:(NSInteger)errorCode message:(NSString *)message;
+ (NSError *)errorWithCode:(NSInteger)errorCode;
@end
