//
//  JHSignalPathViewController.m
//  SignalPath
//
//  Created by hsujahhu on 2016/8/26.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import "JHSignalPathViewController.h"

// View
#import "MBProgressHUD.h"

// ViewModel
#import "JHSignalPathViewModel.h"

// Util
#import "BlockUtil.h"

// FlowLayout
#import "JHCollectionViewFlowLayout.h"

// Category
#import "UICollectionView+FDTemplateLayoutCell.h"
#import "UIView+LayoutUtil.h"

// Constants
#import "JHConstants.h"

@interface JHSignalPathViewController ()<LXReorderableCollectionViewDelegateFlowLayout,LXReorderableCollectionViewDataSource,UICollectionViewDelegate,JHSignalPathViewModelDelegate,UIAlertViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIButton *deleteButton;
@property (nonatomic,strong) UIButton *refreshButton;
@property (nonatomic,strong) UIButton *reloadButton;
@property (nonatomic,strong) MBProgressHUD *hud;
@property (nonatomic,strong) JHSignalPathViewModel *viewModel;
@property (nonatomic,strong) JHCollectionViewFlowLayout *layout;
@end

@implementation JHSignalPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self fetchData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (self) {
        _viewModel = [[JHSignalPathViewModel alloc]init];
        _viewModel.delegate = self;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _viewModel = [[JHSignalPathViewModel alloc]init];
        _viewModel.delegate = self;
    }
    return self;
}

- (void)initView {
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteButton setImage:[UIImage imageNamed:@"ic_delete"] forState:UIControlStateNormal];
    [_deleteButton addTarget:self
                      action:@selector(deleteButtonListener:)
            forControlEvents:UIControlEventTouchUpInside];
    [_deleteButton setSize:CGSizeMake(44, 44)];
    [self.view addSubview:_deleteButton];
    [_deleteButton pinEdgeToSuperViewEdge:HXEdgeLeft withInset:15];
    [_deleteButton pinEdgeToSuperViewEdge:HXEdgeBottom withInset:15];
    
    _refreshButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_refreshButton setImage:[UIImage imageNamed:@"ic_refresh"] forState:UIControlStateNormal];
    [_refreshButton addTarget:self
                      action:@selector(refreshButtonListener:)
            forControlEvents:UIControlEventTouchUpInside];
    [_refreshButton setSize:CGSizeMake(44, 44)];
    [self.view addSubview:_refreshButton];
    [_refreshButton pinEdgeToSuperViewEdge:HXEdgeRight withInset:15];
    [_refreshButton pinEdgeToSuperViewEdge:HXEdgeBottom withInset:15];
    
    _reloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_reloadButton setImage:[UIImage imageNamed:@"ic_cloud_download"] forState:UIControlStateNormal];
    [_reloadButton addTarget:self
                       action:@selector(reloadButtonListener:)
             forControlEvents:UIControlEventTouchUpInside];
    [_reloadButton setSize:CGSizeMake(44, 44)];
    [self.view addSubview:_reloadButton];
    [_reloadButton pinEdge:HXEdgeRight toEdge:HXEdgeLeft ofView:_refreshButton withOffset:12];
    [_reloadButton pinEdgeToSuperViewEdge:HXEdgeBottom withInset:15];
    
    _layout = [[JHCollectionViewFlowLayout alloc]init];
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _layout.itemSize = CGSizeMake(80, 200);
    _layout.minimumInteritemSpacing = 0;
    _layout.minimumLineSpacing = 8;
    
    CGRect cvframe = CGRectMake(0, 0,kScreenWidth,200);
    _collectionView = [[UICollectionView alloc]initWithFrame:cvframe
                                        collectionViewLayout:_layout];
    _collectionView.center = CGPointMake(self.view.center.x, self.view.center.y);
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.clipsToBounds = NO;
    _collectionView.backgroundColor = [UIColor blackColor];
    
    [self.collectionView fd_registerClass:[JHBlockCell class]
               forCellWithReuseIdentifier:@"JHBlockCell"];
    [_collectionView registerClass:[UICollectionReusableView class]
        forSupplementaryViewOfKind: UICollectionElementKindSectionHeader
               withReuseIdentifier:@"HeaderView"];
    
    [_collectionView registerClass:[UICollectionReusableView class]
        forSupplementaryViewOfKind: UICollectionElementKindSectionFooter
               withReuseIdentifier:@"FooterView"];
    
    [self.view addSubview:_collectionView];
    
}

#pragma mark - Fetch

- (void)fetchData {
    
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _hud.mode = MBProgressHUDModeDeterminateHorizontalBar;
    _hud.label.text = @"Loading 0%";
    
    [_viewModel fetchSignalPathDataWithBlock:^(NSError *error) {
        
        [_hud hideAnimated:YES];
        if (!error) {
            [self.collectionView reloadData];
        }else {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error"
                                                           message:@"fetching Data error"
                                                          delegate:self
                                                 cancelButtonTitle:@"OK"
                                                 otherButtonTitles:@"Retry", nil];
            [alert show];
        }
    }];
}

- (void)reloadData {
    
    [_viewModel reloadSignalPathDataWithBlock:^(NSError *error) {
        if (!error) {
            [self fetchData];
        }
    }];
}

#pragma mark - Listener

- (void)deleteButtonListener:(UIButton *)button {
    if (_viewModel.selectedBlock) {
        
        WS(weakSelf);
        NSIndexPath *indexPath = [_viewModel getSelectedBlockIndexPath];
        [weakSelf.viewModel deleteSelectedBlock];
        [weakSelf.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    }
}

- (void)refreshButtonListener:(UIButton *)button {
    [self fetchData];
}

- (void)reloadButtonListener:(UIButton *)button {
    [self reloadData];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self fetchData];
    }
}

#pragma mark - JHSignalPathViewModelDelegate

- (void)signalPathDataDownloadProgress:(CGFloat)progress {
    
    NSInteger percentage = progress * 100;
    _hud.label.text = [NSString stringWithFormat:@"Loading %li%%",(long)percentage];
    [_hud setProgress:progress];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _viewModel.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JHBlockCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"JHBlockCell" forIndexPath:indexPath];
    [_viewModel configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    JHBlockCell *cell = (JHBlockCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    if (_viewModel.selectedBlock) {
        JHBlockCell *prevSelectedCell = (JHBlockCell *)[self.collectionView cellForItemAtIndexPath:[_viewModel getSelectedBlockIndexPath]];
        if (prevSelectedCell) {
            [prevSelectedCell setSelected:NO animated:NO];
        }
    }
    [_viewModel selectCell:cell atIndexPath:indexPath animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat height = _layout.itemSize.height;
    
    CGFloat width = [collectionView
                     fd_widthForCellWithIdentifier:_viewModel.cellReuseIdentifier
                     itemHeight:height
                     configuration:^(JHBlockCell *cell) {
       
                         [_viewModel configureCell:cell atIndexPath:indexPath];
   
                     }];
    return CGSizeMake(width, height);
}

#pragma mark - LXReorderableCollectionViewDataSource methods

- (void)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath willMoveToIndexPath:(NSIndexPath *)toIndexPath {
    
    [_viewModel configureCellMoveFromIndexPath:fromIndexPath toIndexPath:toIndexPath];
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath locationInCell:(CGPoint)location {
    
    JHBlockCell *cell = (JHBlockCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    CGRect imageViewFrame = [cell convertRect:cell.imageView.frame fromView:cell.selectedBlockView];
    CGRect touchRect = CGRectMake(location.x, location.y, 1, 1);
    
    if (!imageViewFrame.size.width)return NO;
    
    return CGRectIntersectsRect(touchRect, imageViewFrame);
}

- (BOOL)collectionView:(UICollectionView *)collectionView itemAtIndexPath:(NSIndexPath *)fromIndexPath canMoveToIndexPath:(NSIndexPath *)toIndexPath {

    return YES;

}

#pragma mark - LXReorderableCollectionViewDelegateFlowLayout methods

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout willEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    JHBlockCell *cell = (JHBlockCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (_viewModel.dataArray[indexPath.row] == _viewModel.selectedBlock) {
        [cell setSelected:NO animated:NO];
    }
}

- (void)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout didEndDraggingItemAtIndexPath:(NSIndexPath *)indexPath {
    JHBlockCell *cell = (JHBlockCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (_viewModel.dataArray[indexPath.row] == _viewModel.selectedBlock) {
        [_viewModel selectCell:cell atIndexPath:indexPath animated:NO];
    }
}

@end
