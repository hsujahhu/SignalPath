//
//  JHBlockCell.h
//  SignalPath
//
//  Created by hsujahhu on 2016/8/26.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JHBlock.h"

@interface JHBlockCell : UICollectionViewCell
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIView *selectedBlockView;
@property (nonatomic,strong) JHBlock *block;
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;
@end
