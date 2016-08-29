//
//  UICollectionView+FDKeyedHeightCache.h
//  holimoo
//
//  Created by hsujahhu on 2016/2/28.
//  Copyright © 2016年 Herxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDKeyedHeightCache : NSObject

- (BOOL)existsHeightForKey:(id<NSCopying>)key;
- (void)cacheHeight:(CGFloat)height byKey:(id<NSCopying>)key;
- (CGFloat)heightForKey:(id<NSCopying>)key;

// Invalidation
- (void)invalidateHeightForKey:(id<NSCopying>)key;
- (void)invalidateAllHeightCache;
@end

@interface UICollectionView (FDKeyedHeightCache)

/// Height cache by key. Generally, you don't need to use it directly.
@property (nonatomic, strong, readonly) FDKeyedHeightCache *fd_keyedHeightCache;
@end
