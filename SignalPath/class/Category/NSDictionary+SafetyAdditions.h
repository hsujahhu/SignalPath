//
//  NSDictionary+SafetyAdditions.h
//  holimoo
//
//  Created by hsujahhu on 2016/4/18.
//  Copyright © 2016年 Herxun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSDictionary (SafetyAdditions)

- (BOOL)hasKey:(NSString *)key;

- (NSString*)stringForKey:(id)key;
- (NSNumber*)numberForKey:(id)key;
- (NSArray*)arrayForKey:(id)key;
- (NSDictionary*)dictionaryForKey:(id)key;
- (NSInteger)integerForKey:(id)key;
- (NSUInteger)unsignedIntegerForKey:(id)key;
- (BOOL)boolForKey:(id)key;

- (int16_t)int16ForKey:(id)key;
- (int32_t)int32ForKey:(id)key;
- (int64_t)int64ForKey:(id)key;

- (char)charForKey:(id)key;
- (short)shortForKey:(id)key;
- (float)floatForKey:(id)key;
- (double)doubleForKey:(id)key;
- (long long)longLongForKey:(id)key;
- (unsigned long long)unsignedLongLongForKey:(id)key;

- (CGFloat)CGFloatForKey:(id)key;
- (CGPoint)pointForKey:(id)key;
- (CGSize)sizeForKey:(id)key;
- (CGRect)rectForKey:(id)key;

#pragma mark - 合并
+ (NSDictionary *)dictionaryByMerging:(NSDictionary *)dict1 with:(NSDictionary *)dict2;
- (NSDictionary *)dictionaryByMergingWith:(NSDictionary *)dict;

#pragma mark - json
-(NSString *)JSONString;
@end
