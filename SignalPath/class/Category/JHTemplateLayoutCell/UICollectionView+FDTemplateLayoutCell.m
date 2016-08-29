//
//  UICollectionView+FDTemplateLayoutCell.m
//  holimoo
//
//  Created by hsujahhu on 2016/2/28.
//  Copyright © 2016年 Herxun. All rights reserved.
//

#import "UICollectionView+FDTemplateLayoutCell.h"
#import <objc/runtime.h>

@implementation UICollectionView (FDTemplateLayoutCell)

- (void)fd_registerClass:(nullable Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier {
    
    [self registerClass:cellClass forCellWithReuseIdentifier:identifier];
    
    UICollectionViewCell *templateCell = self.fd_templateCellsByIdentifiers[identifier];
    if (!templateCell) {
        templateCell = [[cellClass alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
        self.fd_templateCellsByIdentifiers[identifier] = templateCell;
    }
}

- (void)fd_registerNibName:(NSString *)nibName forCellWithReuseIdentifier:(NSString *)identifier {
    
    [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellWithReuseIdentifier:identifier];
    
    UICollectionViewCell *templateCell = self.fd_templateCellsByIdentifiers[identifier];
    if (!templateCell) {
        templateCell = [[[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil] objectAtIndex:0];
        self.fd_templateCellsByIdentifiers[identifier] = templateCell;
    }
}

- (__kindof UICollectionViewCell *)fd_templateCellForReuseIdentifier:(NSString *)identifier {
    NSAssert(identifier.length > 0, @"Expect a valid identifier - %@", identifier);
    
    UICollectionViewCell *templateCell = self.fd_templateCellsByIdentifiers[identifier];
    
    if (!templateCell) {
        templateCell = [self dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        NSAssert(templateCell != nil, @"Cell must be registered to table view for identifier - %@", identifier);
        templateCell.fd_isTemplateLayoutCell = YES;
        templateCell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        self.fd_templateCellsByIdentifiers[identifier] = templateCell;
        [self fd_debugLog:[NSString stringWithFormat:@"layout cell created - %@", identifier]];
    }
    
    return templateCell;
}

- (CGFloat)fd_widthForCellWithIdentifier:(NSString *)identifier itemHeight:(CGFloat)itemHeight configuration:(void (^)(id cell))configuration {
    
    UICollectionViewCell *templateLayoutCell = [self fd_templateCellForReuseIdentifier:identifier];
    
    // Manually calls to ensure consistent behavior with actual cells (that are displayed on screen).
    //    [templateLayoutCell prepareForReuse];
    
    CGRect frame = templateLayoutCell.frame;
    frame.size.height = itemHeight;
    templateLayoutCell.frame = frame;
    
    // Customize and provide content for our template cell.
    if (configuration) {
        configuration(templateLayoutCell);
    }
    
    CGFloat contentViewHeight = itemHeight;
    
    CGSize fittingSize = CGSizeZero;
    
    SEL selector = @selector(sizeThatFits:);
    BOOL inherited = ![templateLayoutCell isMemberOfClass:UICollectionViewCell.class];
    BOOL overrided = [templateLayoutCell.class instanceMethodForSelector:selector] != [UICollectionViewCell instanceMethodForSelector:selector];
    if (inherited && !overrided) {
        NSAssert(NO, @"Customized cell must override '-sizeThatFits:' method if not using auto layout.");
    }
    fittingSize = [templateLayoutCell sizeThatFits:CGSizeMake(0, contentViewHeight)];
    
    return fittingSize.width;
}

- (CGFloat)fd_heightForCellWithIdentifier:(NSString *)identifier itemWidth:(CGFloat)itemWidth configuration:(void (^)(id cell))configuration {
    if (!identifier) {
        return 0;
    }
    
    UICollectionViewCell *templateLayoutCell = [self fd_templateCellForReuseIdentifier:identifier];
    
    // Manually calls to ensure consistent behavior with actual cells (that are displayed on screen).
//    [templateLayoutCell prepareForReuse];
    
    CGRect frame = templateLayoutCell.frame;
    frame.size.width = itemWidth;
    templateLayoutCell.frame = frame;
    
    // Customize and provide content for our template cell.
    if (configuration) {
        configuration(templateLayoutCell);
    }
    
    CGFloat contentViewWidth = itemWidth;
    
    CGSize fittingSize = CGSizeZero;
    
    if (templateLayoutCell.fd_enforceFrameLayout) {
        // If not using auto layout, you have to override "-sizeThatFits:" to provide a fitting size by yourself.
        // This is the same method used in iOS8 self-sizing cell's implementation.
        // Note: fitting height should not include separator view.
        SEL selector = @selector(sizeThatFits:);
        BOOL inherited = ![templateLayoutCell isMemberOfClass:UICollectionViewCell.class];
        BOOL overrided = [templateLayoutCell.class instanceMethodForSelector:selector] != [UICollectionViewCell instanceMethodForSelector:selector];
        if (inherited && !overrided) {
            NSAssert(NO, @"Customized cell must override '-sizeThatFits:' method if not using auto layout.");
        }
        fittingSize = [templateLayoutCell sizeThatFits:CGSizeMake(contentViewWidth, 0)];
    } else {
        // Add a hard width constraint to make dynamic content views (like labels) expand vertically instead
        // of growing horizontally, in a flow-layout manner.
        if (contentViewWidth > 0) {
            NSLayoutConstraint *widthFenceConstraint = [NSLayoutConstraint constraintWithItem:templateLayoutCell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:contentViewWidth];
            [templateLayoutCell.contentView addConstraint:widthFenceConstraint];
            // Auto layout engine does its math
            fittingSize = [templateLayoutCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
            [templateLayoutCell.contentView removeConstraint:widthFenceConstraint];
        }
    }
    
    if (templateLayoutCell.fd_enforceFrameLayout) {
        [self fd_debugLog:[NSString stringWithFormat:@"calculate using frame layout - %@", @(fittingSize.height)]];
    } else {
        [self fd_debugLog:[NSString stringWithFormat:@"calculate using auto layout - %@", @(fittingSize.height)]];
    }
    
    return fittingSize.height;
}

- (CGFloat)fd_heightForCellWithIdentifier:(NSString *)identifier itemWidth:(CGFloat)itemWidth cacheByIndexPath:(NSIndexPath *)indexPath configuration:(void (^)(id cell))configuration {
    if (!identifier || !indexPath) {
        return 0;
    }
    
    // Hit cache
    if ([self.fd_indexPathHeightCache existsHeightAtIndexPath:indexPath]) {
        [self fd_debugLog:[NSString stringWithFormat:@"hit cache by index path[%@:%@] - %@", @(indexPath.section), @(indexPath.row), @([self.fd_indexPathHeightCache heightForIndexPath:indexPath])]];
        return [self.fd_indexPathHeightCache heightForIndexPath:indexPath];
    }
    
    CGFloat height = [self fd_heightForCellWithIdentifier:identifier itemWidth:itemWidth configuration:configuration];
    [self.fd_indexPathHeightCache cacheHeight:height byIndexPath:indexPath];
    [self fd_debugLog:[NSString stringWithFormat: @"cached by index path[%@:%@] - %@", @(indexPath.section), @(indexPath.row), @(height)]];
    
    return height;
}

- (CGFloat)fd_heightForCellWithIdentifier:(NSString *)identifier itemWidth:(CGFloat)itemWidth cacheByKey:(id<NSCopying>)key configuration:(void (^)(id cell))configuration {
    if (!identifier || !key) {
        return 0;
    }
    
    // Hit cache
    if ([self.fd_keyedHeightCache existsHeightForKey:key]) {
        CGFloat cachedHeight = [self.fd_keyedHeightCache heightForKey:key];
        [self fd_debugLog:[NSString stringWithFormat:@"hit cache by key[%@] - %@", key, @(cachedHeight)]];
        return cachedHeight;
    }
    
    CGFloat height = [self fd_heightForCellWithIdentifier:identifier itemWidth:itemWidth configuration:configuration];
    [self.fd_keyedHeightCache cacheHeight:height byKey:key];
    [self fd_debugLog:[NSString stringWithFormat:@"cached by key[%@] - %@", key, @(height)]];
    
    return height;
}

- (NSMutableDictionary<NSString *, __kindof UICollectionViewCell *> *)fd_templateCellsByIdentifiers {
    NSMutableDictionary<NSString *, __kindof UICollectionViewCell *> *templateCellsByIdentifiers = objc_getAssociatedObject(self, _cmd);
    if (!templateCellsByIdentifiers) {
        templateCellsByIdentifiers = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, templateCellsByIdentifiers, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return templateCellsByIdentifiers;
}

@end

@implementation UICollectionViewCell (FDTemplateLayoutCell)

- (BOOL)fd_isTemplateLayoutCell {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setFd_isTemplateLayoutCell:(BOOL)isTemplateLayoutCell {
    objc_setAssociatedObject(self, @selector(fd_isTemplateLayoutCell), @(isTemplateLayoutCell), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)fd_enforceFrameLayout {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setFd_enforceFrameLayout:(BOOL)enforceFrameLayout {
    objc_setAssociatedObject(self, @selector(fd_enforceFrameLayout), @(enforceFrameLayout), OBJC_ASSOCIATION_RETAIN);
}

@end
