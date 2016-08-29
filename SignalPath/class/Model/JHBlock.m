//
//  JHBlock.m
//  SignalPath
//
//  Created by hsujahhu on 2016/8/27.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import "JHBlock.h"
#import "NSDictionary+SafetyAdditions.h"

@implementation JHBlock

- (id)initWithDict:(NSDictionary *)dict {
    
    self = [super init];
    if (self) {
        NSNumber *typeNum = [dict numberForKey:@"type"];
        if (typeNum) {
            NSInteger num = [typeNum integerValue];
            if (num <= JHBlockTypeUNKNOWN) {
                _type = num;
            }else{
                _type = JHBlockTypeUNKNOWN;
            }
        }
        _name = [dict stringForKey:@"name"];
        _img =  [dict stringForKey:@"img"];
        _typeName = [self getTypeName];
    }
    return self;
}

+ (JHBlock *)createObjectWithDict:(NSDictionary *)dict {
    JHBlock *block = [[JHBlock alloc]initWithDict:dict];
    return block;
}

- (NSString *)getTypeName {
    
    switch (_type) {
        case JHBlockTypeGATE:
            return @"GATE";
            break;
        case JHBlockTypeCOMP:
            return @"COMP";
            break;
        case JHBlockTypeBOOST:
            return @"BOOST";
            break;
        case JHBlockTypeDRIVE:
            return @"DRIVE";
            break;
        case JHBlockTypeEQ:
            return @"EQ";
            break;
        case JHBlockTypeMOD:
            return @"MOD";
            break;
        case JHBlockTypeDELAY:
            return @"DELAY";
            break;
        case JHBlockTypeREVERB:
            return @"REVERB";
            break;
        case JHBlockTypeUNKNOWN:
            return @"UNKNOWN";
            break;
        default:
            break;
    }
}
@end
