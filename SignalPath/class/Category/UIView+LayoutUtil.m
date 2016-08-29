//
//  UIView+LayoutUtil.m
//  holimoo
//
//  Created by hsujahhu on 2016/2/27.
//  Copyright © 2016年 Herxun. All rights reserved.
//

#import "UIView+LayoutUtil.h"

@implementation UIView (LayoutUtil)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)trailing {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setTrailing:(CGFloat)trailing {
    CGRect frame = self.frame;
    frame.origin.x = trailing - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (void)pinEdgeToSuperViewEdge:(HXEdge)edge withInset:(CGFloat)inset {
    if (edge == HXEdgeLeft) {
        [self setX:inset];
    }
    else if (edge == HXEdgeRight) {
        [self setX:CGRectGetWidth(self.superview.frame) - CGRectGetWidth(self.frame) - inset];
    }
    else if (edge == HXEdgeTop) {
        [self setY:inset];
    }
    else {
        [self setY:CGRectGetHeight(self.superview.frame) - CGRectGetHeight(self.frame) - inset];
    }
}

- (void)pinEdge:(HXEdge)pinEdge toEdge:(HXEdge)edge ofView:(UIView *)view withOffset:(CGFloat)offset {
    
    if (pinEdge == HXEdgeTop && edge == HXEdgeTop) {
        [self setY:view.frame.origin.y + offset];
    }
    else if (pinEdge == HXEdgeRight && edge == HXEdgeRight) {
        [self setX:CGRectGetWidth(view.frame) + view.frame.origin.x - CGRectGetWidth(self.frame) - offset];
    }
    else if (pinEdge == HXEdgeLeft && edge == HXEdgeLeft) {
        [self setX:view.frame.origin.x + offset];
    }
    else if (pinEdge == HXEdgeBottom && edge == HXEdgeBottom) {
        [self setY:CGRectGetHeight(view.frame) + view.frame.origin.y - CGRectGetHeight(self.frame) - offset];
    }
    else if (pinEdge == HXEdgeTop && edge == HXEdgeBottom) {
        [self setY:CGRectGetHeight(view.frame) + view.frame.origin.y + offset];
    }
    else if (pinEdge == HXEdgeBottom && edge == HXEdgeTop) {
        [self setY:view.frame.origin.y - CGRectGetHeight(self.frame) - offset];
    }
    else if (pinEdge == HXEdgeLeft && edge == HXEdgeRight) {
        [self setX:view.frame.origin.x + CGRectGetWidth(view.frame) + offset];
    }
    else if (pinEdge == HXEdgeRight && edge == HXEdgeLeft) {
        [self setX:view.frame.origin.x - CGRectGetWidth(self.frame) - offset];
    }
}
@end
