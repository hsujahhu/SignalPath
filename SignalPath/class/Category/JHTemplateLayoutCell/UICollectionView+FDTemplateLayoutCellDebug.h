//
//  UICollectionView+FDTemplateLayoutCellDebug.h
//  holimoo
//
//  Created by hsujahhu on 2016/2/28.
//  Copyright © 2016年 Herxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (FDTemplateLayoutCellDebug)

/// Helps to debug or inspect what is this "FDTemplateLayoutCell" extention doing,
/// turning on to print logs when "creating", "calculating", "precaching" or "hitting cache".
///
/// Default to NO, log by NSLog.
///
@property (nonatomic, assign) BOOL fd_debugLogEnabled;

/// Debug log controlled by "fd_debugLogEnabled".
- (void)fd_debugLog:(NSString *)message;

@end
