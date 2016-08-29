//
//  JHAPIClient.h
//  SignalPath
//
//  Created by hsujahhu on 2016/8/27.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface JHAPIClient : AFHTTPSessionManager
+ (instancetype)shared;
@end
