//
//  JHSignalPathViewController.m
//  SignalPath
//
//  Created by hsujahhu on 2016/8/26.
//  Copyright © 2016年 hsujahhu. All rights reserved.
//

#import "JHSignalPathViewController.h"
#import "DraggableCollectionViewFlowLayout.h"
#import "UICollectionView+Draggable.h"
#import "JHConstant.h"
#import "JHBlockCell.h"

@interface JHSignalPathViewController ()<UICollectionViewDataSource_Draggable,UICollectionViewDelegate>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) DraggableCollectionViewFlowLayout *layout;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation JHSignalPathViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Init

- (void)initData  {
    _dataArray = [[NSMutableArray alloc]init];
    _dataArray = [@[@"01",@"02",@"03",@"04",@"05",@"06",@"07",@"08",@"09",@"10"] mutableCopy];
}

- (void)initView {
    
    _layout = [[DraggableCollectionViewFlowLayout alloc]init];
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _layout.itemSize = CGSizeMake(80, 100);
    _layout.minimumInteritemSpacing = kScreenHeight/2;
    _layout.minimumLineSpacing = 16;
    
    CGRect cvframe = CGRectMake(0, 0,kScreenWidth,kScreenHeight);
    _collectionView = [[UICollectionView alloc]initWithFrame:cvframe
                                        collectionViewLayout:_layout];
    _collectionView.center = CGPointMake(self.view.center.x, self.view.center.y);
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor blackColor];
    _collectionView.contentInset = UIEdgeInsetsMake(kScreenHeight/2, 20, 0, 0);
    _collectionView.draggable = YES;
    [_collectionView registerClass:[JHBlockCell class]
        forCellWithReuseIdentifier:@"JHBlockCell"];
    
    [_collectionView registerClass:[UICollectionReusableView class]
        forSupplementaryViewOfKind: UICollectionElementKindSectionHeader
               withReuseIdentifier:@"HeaderView"];
    
    [_collectionView registerClass:[UICollectionReusableView class]
        forSupplementaryViewOfKind: UICollectionElementKindSectionFooter
               withReuseIdentifier:@"FooterView"];
    
    [self.view addSubview:_collectionView];
    
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    JHBlockCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"JHBlockCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor grayColor];
    NSString *str = _dataArray[indexPath.row];
    cell.label.text = str;
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (BOOL)collectionView:(LSCollectionViewHelper *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    // Prevent item from being moved to index 0
    return YES;
}

- (void)collectionView:(LSCollectionViewHelper *)collectionView moveItemAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSString *data1 = [_dataArray objectAtIndex:fromIndexPath.row];
    
    [_dataArray removeObject:data1];
    [_dataArray insertObject:data1 atIndex:toIndexPath.item];
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(0,44 * 2);
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(0,40 + 12 + 8);
//}
//
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionReusableView *reusableview = nil;
//    
//    if (kind == UICollectionElementKindSectionFooter) {
//        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
//                                                          withReuseIdentifier:@"FooterView"
//                                                                 forIndexPath:indexPath];
//        
//    }
//    if (kind == UICollectionElementKindSectionHeader) {
//        reusableview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//                                                          withReuseIdentifier:@"HeaderView"
//                                                                 forIndexPath:indexPath];
//    }
//    
//    return reusableview;
//}

@end
