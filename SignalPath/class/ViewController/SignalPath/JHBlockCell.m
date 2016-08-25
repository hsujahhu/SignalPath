//
//  JHBlockCell.m
//  SignalPath
//
//  Created by hsujahhu on 2016/8/26.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import "JHBlockCell.h"

@implementation JHBlockCell

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _label = [[UILabel alloc]init];
        _label.frame = self.bounds;
        _label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_label];
    }
    return self;
}
@end
