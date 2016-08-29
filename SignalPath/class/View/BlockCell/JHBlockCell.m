//
//  JHBlockCell.m
//  SignalPath
//
//  Created by hsujahhu on 2016/8/26.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import "JHBlockCell.h"
#import "UIView+LayoutUtil.h"

@interface JHBlockCell ()
@property (assign,nonatomic) CGFloat selectedBlockViewHeight;
@end
@implementation JHBlockCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        CGRect blockFrame = frame;
        blockFrame.size = CGSizeMake(self.width * 0.6, self.selectedBlockViewHeight);
        _selectedBlockView = [[UIView alloc]initWithFrame:blockFrame];
        _selectedBlockView.layer.cornerRadius = 4;
        _selectedBlockView.layer.masksToBounds = YES;
        _selectedBlockView.clipsToBounds = YES;
        [self.contentView addSubview:_selectedBlockView];
        
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.selectedBlockView addSubview:_imageView];
        
        _label = [[UILabel alloc]init];
        _label.numberOfLines = 1;
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont boldSystemFontOfSize:11];
        _label.textAlignment = NSTextAlignmentCenter;
        [self.selectedBlockView addSubview:_label];
    }
    return self;
}

- (void)setBlock:(JHBlock *)block {
    
    CGFloat imageHeight = (self.selectedBlockViewHeight - 16) * 0.8;
    CGFloat imageWidth = 0;
    CGFloat imageRatio = block.image.size.width/block.image.size.height;
    if (imageRatio > 2) {
        imageWidth = imageHeight * imageRatio /2;
    }
    else{
        imageWidth = imageHeight * imageRatio;
    }
    
    _selectedBlockView.width = self.width * 0.8;
    _selectedBlockView.center = CGPointMake(self.width/2, self.height/2);
    
    [_imageView setSize:CGSizeMake(imageWidth, imageHeight)];
    [_imageView setCenterX:_selectedBlockView.width/2];
    [_imageView setY:8];
    
    _imageView.image = block.image;
    _label.text = block.typeName;
    [_label sizeToFit];
    [_label setHeight:(self.selectedBlockViewHeight - 16) * 0.2];
    [_label setCenterX:_selectedBlockView.width/2];
    [_label pinEdge:HXEdgeTop toEdge:HXEdgeBottom ofView:_imageView withOffset:0];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(MAX(_imageView.width, _label.width)/0.7, size.height);
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    
    if (self.highlighted) {
        [UIView
         animateWithDuration:0.2
         delay:0.0
         options:UIViewAnimationOptionBeginFromCurrentState|
         UIViewAnimationOptionAllowUserInteraction |
         UIViewAnimationOptionOverrideInheritedOptions|
         UIViewAnimationOptionCurveEaseOut
         animations:^{
             self.imageView.transform = CGAffineTransformMakeScale(0.8f, 0.8f);
         }
         completion:^(BOOL finished) {
             
         }];
    }else {
        [UIView
         animateWithDuration:0.2
         delay:0.0
         options:UIViewAnimationOptionBeginFromCurrentState|
         UIViewAnimationOptionAllowUserInteraction |
         UIViewAnimationOptionOverrideInheritedOptions|
         UIViewAnimationOptionCurveEaseOut
         animations:^{
             self.imageView.transform = CGAffineTransformIdentity;
         }
         completion:^(BOOL finished) {
             
         }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:YES];
    if (!animated) {
        UIColor *color = selected ? [[UIColor grayColor] colorWithAlphaComponent:0.5] : [UIColor clearColor];
        self.selectedBlockView.backgroundColor = color;
        return;
    }
    
    if (selected) {
        self.selectedBlockView.backgroundColor = [UIColor clearColor];
        [UIView
         animateWithDuration:0.3
         delay:0.0
         options:UIViewAnimationOptionBeginFromCurrentState|
         UIViewAnimationOptionAllowUserInteraction |
         UIViewAnimationOptionOverrideInheritedOptions|
         UIViewAnimationOptionCurveEaseOut
         animations:^{
             self.selectedBlockView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
         }
         completion:^(BOOL finished) {
             
         }];
    }else{
        self.selectedBlockView.backgroundColor = [UIColor clearColor];
    }
}

- (CGFloat)selectedBlockViewHeight {
    return self.height * 0.5;
}
@end
