//
//  BlockUtil.m
//  SignalPath
//
//  Created by hsujahhu on 2016/8/27.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import "BlockUtil.h"
#import "ErrorUtil.h"
#import "AFNetworking.h"
#import "JHAPIClient.h"
#import "JHConstants.h"
#import "NSDictionary+SafetyAdditions.h"

NSString *const dataUrl = @"https://dl.positivegrid.com/ios_interview/SingleSignalPathExam/data.json";
@implementation BlockUtil

+ (void)fetchBlockDataWithBlock:(fetchResultsBlock)block
                       progress:(void (^)(NSProgress *))progress {
    
    AFHTTPSessionManager *manager = [JHAPIClient shared];
    NSProgress *currentProgress = [[NSProgress alloc]init];
    if (progress) {
        progress (currentProgress);
    }
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:dataUrl parameters:nil
        progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSError* error;
            NSDictionary* results = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                    options:kNilOptions
                                                                      error:&error];
            NSMutableArray *dataList = [[NSMutableArray alloc]init];
            if (!error) {
                NSError *error;
                NSArray *blockList = [BlockUtil blockArrayParseFromDict:results
                                                                  error:&error];
                if (blockList) {
                    currentProgress.totalUnitCount = blockList.count;
                    
                    for (NSDictionary *dict in blockList) {
                        JHBlock *block = [JHBlock createObjectWithDict:dict];
                        [dataList addObject:block];
                    }
                    [BlockUtil downloadBlockImages:dataList
                                          progress:^(NSProgress *downloadProgress) {
                                              [currentProgress addChild:downloadProgress withPendingUnitCount:1];
                                          } block:^(BOOL success, NSError *error) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  if (block) {
                                                      block (dataList,error);
                                                  }
                                              });
                                          }];
                }
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (block) {
                    block (nil,error);
                }
            });
            NSLog(@"Error: %@", error);
        }];
}

+ (void)downloadBlockImages:(NSArray<JHBlock *>*)blocks
                   progress:(void (^)(NSProgress * progress))progress
                      block:(fetchImageBlock)block {
    AFHTTPSessionManager *manager = [JHAPIClient shared];
    __block BOOL success = YES;
    dispatch_group_t group = dispatch_group_create();
    
    for (NSInteger i = 0; i < blocks.count; i++) {
        manager.responseSerializer = [AFImageResponseSerializer serializer];
        JHBlock *block = blocks[i];
        
        dispatch_group_enter(group);
        
        NSURLSessionDataTask *task =
        [manager GET:block.img parameters:nil
            progress:^(NSProgress * _Nonnull downloadProgress) {
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSLog(@"Response :%@",responseObject);
                block.image = responseObject;
                dispatch_group_leave(group);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                success = NO;
                NSLog(@"Error: %@", error);
                dispatch_group_leave(group);
            }];
        NSProgress *childProgress = [manager downloadProgressForTask:task];
        if (progress) {
            progress (childProgress);
        }
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (block) {
            block (success,nil);
        }
    });
}

+ (NSArray *)blockArrayParseFromDict:(NSDictionary *)dict error:(NSError **)error{
    
    NSDictionary *signalPath = [dict dictionaryForKey:@"sigPath"];
    if (signalPath) {
        NSArray *blocks = [signalPath arrayForKey:@"blocks"];
        if (!blocks) {
            NSString *message = @"blocks parsing error";
            *error = [ErrorUtil errorWithCode:JHErrorCodeParsingErorr message:message];
        }
        return blocks;
    }else{
        NSString *message = @"signalPath parsing error";
        *error = [ErrorUtil errorWithCode:JHErrorCodeParsingErorr message:message];
        NSLog(@"Error: signalPath parsing error");
        return nil;
    }
}
@end
