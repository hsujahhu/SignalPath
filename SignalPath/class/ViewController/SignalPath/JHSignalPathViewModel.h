//
//  JHSignalPathViewModel.h
//  SignalPath
//
//  Created by hsujahhu on 2016/8/28.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHBlock.h"
#import "JHBlockCell.h"

@protocol JHSignalPathViewModelDelegate <NSObject>
- (void)signalPathDataDownloadProgress:(CGFloat)progress;
@end

@interface JHSignalPathViewModel : NSObject
@property (nonatomic,weak) id <JHSignalPathViewModelDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,readonly) NSProgress *progress;
@property (nonatomic,readonly) NSString *cellReuseIdentifier;
@property (nonatomic,readonly) NSIndexPath *selectedIndexPath;
@property (nonatomic) Class registerClass;
- (void)configureCell:(JHBlockCell *)cell
          atIndexPath:(NSIndexPath *)indexPath;
- (void)selectCell:(JHBlockCell *)cell
       atIndexPath:(NSIndexPath *)indexPath;
- (void)deleteSelectedBlock;
- (void)removeSelectedIndexPath;
- (void)fetchSignalPathDataWithBlock:(void(^)(NSError *error))block;
@end
