//
//  TotalViewController.m
//  YDShareJob
//
//  Created by 李加建 on 2017/10/23.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "TotalViewController.h"

#import "Home1_2HeadView.h"
#import "Home1_2CollectionViewCell.h"

#import "BBFlowLayout.h"

#import "Home1_2DetailViewController.h"

@interface TotalViewController () <UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout ,BBFlowLayoutDelegate >


@property (strong, nonatomic)UICollectionView *collectionView;

@property (nonatomic ,strong)NSMutableArray *dataSource;

@end

@implementation TotalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [NSMutableArray array];
    
    [self creatView];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/




- (void)creatView {
    
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //    flowLayout.delegate = self;
    
    //确定是水平滚动，还是垂直滚动
//    BBFlowLayout * flowLayout = [[BBFlowLayout alloc]init];
//    flowLayout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH,SCREEM_HEIGHT - 64 - 50 ) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.alwaysBounceHorizontal = NO;
    
    //注册Cell，必须要有
    [self.collectionView registerClass:[Home1_2CollectionViewCell class] forCellWithReuseIdentifier:@"Home1_2CollectionViewCell"];
    
    
    [self.view addSubview:self.collectionView];
    
    self.collectionView.backgroundColor = RGB(240, 240, 240);
    
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefreshing)];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefreshing)];
    
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    [footer endRefreshingWithNoMoreData];
    
    _collectionView.mj_footer = footer;
    
}


- (void)headRefreshing {
    
    [_dataSource removeAllObjects];
    
    [_collectionView.mj_header endRefreshing];
    
    [self loadData];
    
    
}


- (void)footRefreshing {
    
    [_collectionView.mj_footer endRefreshing];
    
    [self loadData];
}








#pragma mark - UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _dataSource.count;
    
}



//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Home1_2CollectionViewCell";
    Home1_2CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    
    ParkTimeModel *model = _dataSource[indexPath.row];
    
    
    [cell dataWithModel:model];
    
    
    return cell;
}






#pragma mark - UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    CGFloat w = (SCREEM_WIDTH - 1)/2;
    
    
    return CGSizeMake(w, w+60);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 1;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    //    CGFloat ww = (SCREEM_WIDTH - 90*4 - 40)/3;
    
    return 1;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//
//    return CGSizeMake(SCREEM_WIDTH, 44);
//}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ParkTimeModel *model = _dataSource[indexPath.row];
    
    Home1_2DetailViewController *nextVC = [[Home1_2DetailViewController alloc]init];
    nextVC.model = model;
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
    
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (NSInteger)columnCountInBBflowLayout:(BBFlowLayout *)BBflowLayout {
    
    return 2;
}


- (UIEdgeInsets)edgeInsetsInBBflowLayout:(BBFlowLayout *)BBflowLayout {
    
    return UIEdgeInsetsMake(5, 5, 5, 5);
}

- (CGSize)sizeInBBflowLayout:(BBFlowLayout *)BBflowLayout {
    
    return CGSizeMake((SCREEM_WIDTH - 15)/2 , (SCREEM_WIDTH - 15)/2 + 60);
}

- (CGFloat)rowMarginInBBflowLayout:(BBFlowLayout *)BBflowLayout {
    
    return 5;
}

- (CGFloat)columnMarginInBBflowLayout:(BBFlowLayout *)BBflowLayout {
    
    return 5;
}


#pragma mark - load json

- (void)loadData {
    
    [ParkTimeModel findObjects:^(NSArray * _Nullable objects, NSError * _Nullable error) {

        [_dataSource addObjectsFromArray:objects];

        [_collectionView reloadData];
    }];
    
}


@end
