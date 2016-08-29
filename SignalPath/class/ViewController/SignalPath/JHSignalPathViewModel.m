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
    if (_dataArray[indexPath.row] == _selectedBlock) {
        [cell setSelected:YES animated:NO];
    }else{
        [cell setSelected:NO animated:NO];
    }
}

- (void)configureCellMoveFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    JHBlock *block = [_dataArray objectAtIndex:fromIndexPath.row];
    
    [_dataArray removeObject:block];
    [_dataArray insertObject:block atIndex:toIndexPath.item];
}

- (void)selectCell:(JHBlockCell *)cell
       atIndexPath:(NSIndexPath *)indexPath
          animated:(BOOL)animated{
    [cell setSelected:YES animated:animated];
    _selectedBlock = _dataArray[indexPath.row];
}

- (void)deleteSelectedBlock {
    [self.dataArray removeObject:_selectedBlock];
    _selectedBlock = nil;
}

- (NSIndexPath *)getSelectedBlockIndexPath {
    if (!_selectedBlock) {
        return nil;
    }
    NSInteger index = [_dataArray indexOfObject:_selectedBlock];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    return indexPath;
}

- (void)fetchSignalPathDataWithBlock:(void(^)(NSError *error))block {
    
    [BlockUtil fetchBlockDataWithBlock:^(NSArray<JHBlock *> *blocks, NSError *error) {
        [self.progress removeObserver:self forKeyPath:@"fractionCompleted"];
        _progress = nil;
        if (!error) {
            _dataArray = [blocks mutableCopy];
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

- (void)reloadSignalPathDataWithBlock:(void(^)(NSError *error))block {
    [BlockUtil clearBlockDataCacheWithBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (block) {
                block(nil);
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
