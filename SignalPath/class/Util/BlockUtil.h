//
//  BlockUtil.h
//  SignalPath
//
//  Created by hsujahhu on 2016/8/27.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "JHBlock.h"

typedef void(^fetchResultsBlock)(NSArray<JHBlock *> *blocks,NSError *error);
typedef void(^fetchImageBlock)(BOOL finish,BOOL success,NSError *error);

@interface BlockUtil : NSObject
+ (void)fetchBlockDataWithBlock:(fetchResultsBlock)block
                       progress:(void (^)(NSProgress * progress))progress;
+ (void)clearBlockDataCacheWithBlock:(void(^)(void))block;
@end
