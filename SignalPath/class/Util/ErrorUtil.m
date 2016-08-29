//
//  ErrorUtil.m
//  SignalPath
//
//  Created by hsujahhu on 2016/8/27.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import "ErrorUtil.h"

@implementation ErrorUtil

+ (NSError *)errorWithCode:(NSInteger)errorCode message:(NSString *)message {
    
    NSString *errorExplanation = message;
    NSDictionary *result = @{@"code":@(errorCode),
                             @"error":message};
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionaryWithDictionary:result];
    if (errorExplanation) {
        userInfo[NSLocalizedDescriptionKey] = errorExplanation;
    }
    return [NSError errorWithDomain:@"" code:errorCode userInfo:userInfo];
}

+ (NSError *)errorWithCode:(NSInteger)errorCode {
    
    return [ErrorUtil errorWithCode:errorCode
                            message:[ErrorUtil errorMessageWithCode:errorCode]];
}

+ (NSString *)errorMessageWithCode:(NSInteger)errorCode {
    
    return @"";
}

@end
