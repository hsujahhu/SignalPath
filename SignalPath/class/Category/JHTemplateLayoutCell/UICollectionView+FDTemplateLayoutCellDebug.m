//
//  UICollectionView+FDTemplateLayoutCellDebug.m
//  holimoo
//
//  Created by hsujahhu on 2016/2/28.
//  Copyright © 2016年 Herxun. All rights reserved.
//

#import "UICollectionView+FDTemplateLayoutCellDebug.h"
#import <objc/runtime.h>

@implementation UICollectionView (FDTemplateLayoutCellDebug)

- (BOOL)fd_debugLogEnabled {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setFd_debugLogEnabled:(BOOL)debugLogEnabled {
    objc_setAssociatedObject(self, @selector(fd_debugLogEnabled), @(debugLogEnabled), OBJC_ASSOCIATION_RETAIN);
}

- (void)fd_debugLog:(NSString *)message {
    if (self.fd_debugLogEnabled) {
        NSLog(@"** FDTemplateLayoutCell ** %@", message);
    }
}

@end
