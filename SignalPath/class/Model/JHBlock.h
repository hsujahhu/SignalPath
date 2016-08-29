//
//  JHBlock.h
//  SignalPath
//
//  Created by hsujahhu on 2016/8/27.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JHBlock : NSObject
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,strong) UIImage *image;
+ (JHBlock *)createObjectWithDict:(NSDictionary *)dict;
@end
