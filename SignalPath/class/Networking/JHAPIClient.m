//
//  JHAPIClient.m
//  SignalPath
//
//  Created by hsujahhu on 2016/8/27.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import "JHAPIClient.h"

@implementation JHAPIClient

+ (instancetype)shared {
    static JHAPIClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [JHAPIClient manager];
        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
        NSData * certData =[NSData dataWithContentsOfFile:cerPath];
        NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
        [securityPolicy setAllowInvalidCertificates:NO];
        [securityPolicy setPinnedCertificates:certSet];
        [securityPolicy setValidatesDomainName:NO];
        _sharedClient.securityPolicy = securityPolicy;
    });
    
    return _sharedClient;
}

@end
