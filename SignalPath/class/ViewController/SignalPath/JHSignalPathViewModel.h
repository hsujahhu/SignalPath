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
@property (nonatomic,readonly) NSMutableArray *dataArray;
@property (nonatomic,readonly) NSProgress *progress;
@property (nonatomic,readonly) NSString *cellReuseIdentifier;
@property (nonatomic,readonly) JHBlock *selectedBlock;
@property (nonatomic) Class registerClass;

- (void)configureCell:(JHBlockCell *)cell
          atIndexPath:(NSIndexPath *)indexPath;

- (void)configureCellMoveFromIndexPath:(NSIndexPath *)fromIndexPath
                           toIndexPath:(NSIndexPath *)toIndexPath;

- (void)selectCell:(JHBlockCell *)cell
       atIndexPath:(NSIndexPath *)indexPath
          animated:(BOOL)animated;

- (void)deleteSelectedBlock;
- (NSIndexPath *)getSelectedBlockIndexPath;
- (void)fetchSignalPathDataWithBlock:(void(^)(NSError *error))block;
- (void)reloadSignalPathDataWithBlock:(void(^)(NSError *error))block;
@end
