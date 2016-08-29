//
//  JHBlock.h
//  SignalPath
//
//  Created by hsujahhu on 2016/8/27.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,JHBlockType) {
    JHBlockTypeGATE  = 0,
    JHBlockTypeCOMP     ,
    JHBlockTypeBOOST    ,
    JHBlockTypeDRIVE    ,
    JHBlockTypeEQ       ,
    JHBlockTypeMOD      ,
    JHBlockTypeDELAY    ,
    JHBlockTypeREVERB   ,
    JHBlockTypeUNKNOWN
};

@interface JHBlock : NSObject
@property (nonatomic,readonly) NSString *name;
@property (nonatomic,readonly) NSString *typeName;
@property (nonatomic,readonly) NSString *img;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,assign,readonly) JHBlockType type;

+ (JHBlock *)createObjectWithDict:(NSDictionary *)dict;
@end
