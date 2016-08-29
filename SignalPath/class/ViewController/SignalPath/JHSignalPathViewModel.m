//
//  JHSignalPathViewModel.m
//  SignalPath
//
//  Created by hsujahhu on 2016/8/28.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import "JHSignalPathViewModel.h"
#import "BlockUtil.h"

@implementation JHSignalPathViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataArray = [[NSMutableArray alloc]init];
        _registerClass = [JHBlockCell class];
        _cellReuseIdentifier = @"JHBlockCell";
    }
    return self;
}

- (void) dealloc {
    if (self.progress) {
        [self.progress removeObserver:self forKeyPath:@"fractionCompleted"];
    }
}

- (void)configureCell:(JHBlockCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    JHBlock *block = _dataArray[indexPath.row];
    [cell setBlock:block];
    if (indexPath == _selectedIndexPath) {
        cell.backgroundColor = [UIColor grayColor];
    }
}

- (void)selectCell:(JHBlockCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor grayColor];
    _selectedIndexPath = indexPath;
}

- (void)deleteSelectedBlock {
    [self.dataArray removeObjectAtIndex:_selectedIndexPath.row];
}

- (void)removeSelectedIndexPath {
    _selectedIndexPath = nil;
}

- (void)fetchSignalPathDataWithBlock:(void(^)(NSError *error))block {
    
    [BlockUtil fetchBlockDataWithBlock:^(NSArray<JHBlock *> *blocks, NSError *error) {
        if (!error) {
            self.dataArray = [blocks mutableCopy];
            [self.progress removeObserver:self forKeyPath:@"fractionCompleted"];
            _progress = nil;
        }
        if (block) {
            block (error);
        }
    } progress:^(NSProgress * progress) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (!self.progress) {
                _progress = progress;
                [self.progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:NULL];
            }
        });
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *, id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"fractionCompleted"]) {
        // process value
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(signalPathDataDownloadProgress:)]) {
                [self.delegate signalPathDataDownloadProgress:self.progress.fractionCompleted];
            }
        });
    }
}
@end
