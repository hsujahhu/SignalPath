//
//  JHCollectionViewFlowLayout.m
//  SignalPath
//
//  Created by hsujahhu on 2016/8/28.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import "JHCollectionViewFlowLayout.h"

@interface JHDecorationView : UICollectionReusableView
@property (nonatomic,strong) CAShapeLayer *line;
@end

@implementation JHCollectionViewFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    [self registerClass:[JHDecorationView class] forDecorationViewOfKind:@"JHDecoraionView"];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)decorationViewKind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes* att = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    CGFloat width = MAX(self.collectionViewContentSize.width, self.collectionView.frame.size.width);
    att.frame = CGRectMake(0, 0, width, self.collectionView.frame.size.height);
    return att;
    
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray* attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    
    NSIndexPath* indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [attributes addObject:[self layoutAttributesForDecorationViewOfKind:@"JHDecoraionView" atIndexPath:indexPath]];
    
    return attributes;
}

@end

@implementation JHDecorationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _line = [CAShapeLayer layer];
        UIBezierPath *path = [[UIBezierPath alloc]init];
        NSLog(@"%@",NSStringFromCGRect(frame));
        [path moveToPoint:CGPointMake(0,CGRectGetHeight(self.frame)/2 -2)];
        [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame),
                                         CGRectGetHeight(self.frame)/2 - 2)];
        _line.path = path.CGPath;
        _line.strokeColor = [UIColor yellowColor].CGColor;
        _line.lineWidth = 4;
        [self.layer addSublayer:_line];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    UIBezierPath *path = [[UIBezierPath alloc]init];
    [path moveToPoint:CGPointMake(0,CGRectGetHeight(self.frame)/2 -2)];
    [path addLineToPoint:CGPointMake(CGRectGetWidth(self.frame),
                                     CGRectGetHeight(self.frame)/2 - 2)];
    _line.path = path.CGPath;
}

@end