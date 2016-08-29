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
        _type = [dict stringForKey:@"type"];
        _name = [dict stringForKey:@"name"];
        _img =  [dict stringForKey:@"img"];
    }
    return self;
}

+ (JHBlock *)createObjectWithDict:(NSDictionary *)dict {
    JHBlock *block = [[JHBlock alloc]initWithDict:dict];
    return block;
}
@end
