//
//  UIView+LayoutUtil.h
//  holimoo
//
//  Created by hsujahhu on 2016/2/27.
//  Copyright © 2016年 Herxun. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HXEdge) {
    HXEdgeLeft ,
    HXEdgeRight ,
    HXEdgeTop ,
    HXEdgeBottom
};

@interface UIView (LayoutUtil)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat trailing;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;

- (void)pinEdgeToSuperViewEdge:(HXEdge)edge withInset:(CGFloat)inset;
- (void)pinEdge:(HXEdge)pinEdge toEdge:(HXEdge)edge ofView:(UIView *)view withOffset:(CGFloat)offset;
@end
