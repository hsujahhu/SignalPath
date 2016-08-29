//
//  UICollectionView+FDTemplateLayoutCell.h
//  holimoo
//
//  Created by hsujahhu on 2016/2/28.
//  Copyright © 2016年 Herxun. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "UICollectionView+FDKeyedHeightCache.h"
#import "UICollectionView+FDIndexPathHeightCache.h"
#import "UICollectionView+FDTemplateLayoutCellDebug.h"

@interface UICollectionView (FDTemplateLayoutCell)

- (void)fd_registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;
- (void)fd_registerNibName:(NSString *)nibName forCellWithReuseIdentifier:(NSString *)identifier;

/// Access to internal template layout cell for given reuse identifier.
/// Generally, you don't need to know these template layout cells.
///
/// @param identifier Reuse identifier for cell which must be registered.
///
- (UICollectionViewCell *)fd_templateCellForReuseIdentifier:(NSString *)identifier;

/// Returns width of cell of type specifed by a reuse identifier and configured
/// by the configuration block.
///
/// The cell would be layed out on a fixed-height, horizontally expanding basis with
/// respect to its dynamic content, using auto layout. Thus, it is imperative that
/// the cell was set up to be self-satisfied, i.e. its content always determines
/// its width given the width is equal to the collectionview's.
///
/// @param identifier A string identifier for retrieving and maintaining template
///        cells with system's "-dequeueReusableCellWithIdentifier:" call.
/// @param configuration An optional block for configuring and providing content
///        to the template cell. The configuration should be minimal for scrolling
///        performance yet sufficient for calculating cell's height.
///
- (CGFloat)fd_widthForCellWithIdentifier:(NSString *)identifier itemHeight:(CGFloat)itemHeight configuration:(void (^)(id cell))configuration;

/// Returns height of cell of type specifed by a reuse identifier and configured
/// by the configuration block.
///
/// The cell would be layed out on a fixed-width, vertically expanding basis with
/// respect to its dynamic content, using auto layout. Thus, it is imperative that
/// the cell was set up to be self-satisfied, i.e. its content always determines
/// its height given the width is equal to the tableview's.
///
/// @param identifier A string identifier for retrieving and maintaining template
///        cells with system's "-dequeueReusableCellWithIdentifier:" call.
/// @param configuration An optional block for configuring and providing content
///        to the template cell. The configuration should be minimal for scrolling
///        performance yet sufficient for calculating cell's height.
///
- (CGFloat)fd_heightForCellWithIdentifier:(NSString *)identifier itemWidth:(CGFloat)itemWidth configuration:(void (^)(id cell))configuration;

/// This method does what "-fd_heightForCellWithIdentifier:configuration" does, and
/// calculated height will be cached by its index path, returns a cached height
/// when needed. Therefore lots of extra height calculations could be saved.
///
/// No need to worry about invalidating cached heights when data source changes, it
/// will be done automatically when you call "-reloadData" or any method that triggers
/// UITableView's reloading.
///
/// @param indexPath where this cell's height cache belongs.
///
- (CGFloat)fd_heightForCellWithIdentifier:(NSString *)identifier itemWidth:(CGFloat)itemWidth cacheByIndexPath:(NSIndexPath *)indexPath configuration:(void (^)(id cell))configuration;

/// This method caches height by your model entity's identifier.
/// If your model's changed, call "-invalidateHeightForKey:(id <NSCopying>)key" to
/// invalidate cache and re-calculate, it's much cheaper and effective than "cacheByIndexPath".
///
/// @param key model entity's identifier whose data configures a cell.
///
- (CGFloat)fd_heightForCellWithIdentifier:(NSString *)identifier itemWidth:(CGFloat)itemWidth cacheByKey:(id<NSCopying>)key configuration:(void (^)(id cell))configuration;

@end

@interface UICollectionViewCell (FDTemplateLayoutCell)

/// Indicate this is a template layout cell for calculation only.
/// You may need this when there are non-UI side effects when configure a cell.
/// Like:
///   - (void)configureCell:(FooCell *)cell atIndexPath:(NSIndexPath *)indexPath {
///       cell.entity = [self entityAtIndexPath:indexPath];
///       if (!cell.fd_isTemplateLayoutCell) {
///           [self notifySomething]; // non-UI side effects
///       }
///   }
///
@property (nonatomic, assign) BOOL fd_isTemplateLayoutCell;

/// Enable to enforce this template layout cell to use "frame layout" rather than "auto layout",
/// and will ask cell's height by calling "-sizeThatFits:", so you must override this method.
/// Use this property only when you want to manually control this template layout cell's height
/// calculation mode, default to NO.
///
@property (nonatomic, assign) BOOL fd_enforceFrameLayout;

@end
