//
//  JHBlockCell.m
//  SignalPath
//
//  Created by hsujahhu on 2016/8/26.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import "JHBlockCell.h"
#import "UIView+LayoutUtil.h"

@implementation JHBlockCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imageView];
        
        _label = [[UILabel alloc]init];
        [_label setY:self.height * 0.8];
        _label.numberOfLines = 1;
        _label.textColor = [UIColor whiteColor];
        _label.font = [UIFont boldSystemFontOfSize:11];
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
    }
    return self;
}

- (void)setBlock:(JHBlock *)block {
    
    CGFloat imageHeight = self.height * 0.8;
    CGFloat imageWidth = 0;
    CGFloat imageRatio = block.image.size.width/block.image.size.height;
    if (imageRatio > 2) {
        imageWidth = imageHeight * imageRatio /2;
    }
    else{
        imageWidth = imageHeight * imageRatio;
    }
    [_imageView setSize:CGSizeMake(imageWidth, imageHeight)];
    [_imageView setCenterX:self.width/2];
    
    _imageView.image = block.image;
    _label.text = block.name;
    [_label sizeToFit];
    [_label setHeight:self.height * 0.2];
    [_label setCenterX:self.width/2];
    
    self.backgroundColor = [UIColor clearColor];
}

- (CGSize)sizeThatFits:(CGSize)size {
    return CGSizeMake(MAX(_imageView.width, _label.width), size.height);
}

- (void)setHighlighted:(BOOL)highlighted
{
//    [super setHighlighted:highlighted];
//    
//    if (self.highlighted) {
//        self.backgroundColor = [UIColor redColor];
//    }
}
@end
