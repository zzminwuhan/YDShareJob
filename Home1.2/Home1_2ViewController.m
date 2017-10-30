//
//  Home1_2ViewController.m
//  YDShareJob
//
//  Created by 李加建 on 2017/10/23.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "Home1_2ViewController.h"

#import "Home1_2HeadView.h"
#import "Home1_2CollectionViewCell.h"

#import "BBFlowLayout.h"

#import "Home1_2DetailViewController.h"

#import <SDCycleScrollView.h>

#import "HBannerModel.h"

#import "IconButton.h"

#import "LocationManager.h"

#import "JFCityViewController.h"

#import "SearchViewController.h"

#import "YaoYiYaoViewController.h"

#import "WalletViewController.h"

#import "SGQRCodeScanningVC.h"

#import "HomeTypeViewController.h"

@interface Home1_2ViewController ()<UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout ,BBFlowLayoutDelegate ,JFCityViewControllerDelegate ,SDCycleScrollViewDelegate>


@property (strong, nonatomic)UICollectionView *collectionView;

@property (nonatomic ,strong)NSMutableArray *dataSource;

@property (nonatomic ,strong)IconButton *areaBtn;
@property (nonatomic,strong)LocationManager *manager;

@property (nonatomic ,strong)NSMutableArray* bannerArray;
@property (nonatomic,strong)UIView *headView;
@property (nonatomic ,strong)SDCycleScrollView *cycleScrollView;

@property (nonatomic ,strong)NSMutableArray* iconsArray;

@property (nonatomic ,strong)NSMutableArray* btnsArray;

@end

@implementation Home1_2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [NSMutableArray array];
    
    _bannerArray = [NSMutableArray array];
    
    _btnsArray = [NSMutableArray array];
    
    _iconsArray = [NSMutableArray array];
    
    [self initLeftItem];
    [self initRightItem];
    
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




- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    
}

- (void)initLeftItem {
    
    IconButton *btn = [[IconButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    [btn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    btn.titleLabel.font = FONT11;
    [btn setImage:[UIImage imageNamed:@"location"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setLeftBarWithCustomView:btn];
    
    self.areaBtn= btn;
    
    [self getLocation];
    
}



- (void)leftBtnAction {
    
    JFCityViewController *cityViewController = [[JFCityViewController alloc] init];
    cityViewController.delegate = self;
    cityViewController.title = @"城市";
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:cityViewController];
    
    [navigationController.navigationBar setBarTintColor:MAINCOLOR];
    navigationController.navigationBar.translucent = NO;
    navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    [self presentViewController:navigationController animated:YES completion:nil];
}


- (void)cityName:(NSString *)name {
    
    UIButton *btn = self.areaBtn ;
    
    [btn setTitle:name forState:UIControlStateNormal];
}


- (void)initRightItem {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    [btn setImage:[UIImage imageNamed:@"scan_btn"] forState:UIControlStateNormal];
    [self setRightBarWithCustomView:btn];
    [btn addTarget:self action:@selector(rightItemAction) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(50, 0, SCREEM_WIDTH - 100, 32)];
    
    btn2.backgroundColor = RGB(255, 255, 255);
    btn2.imageView.layer.masksToBounds = YES;
    btn2.imageView.layer.cornerRadius = 5;
    [btn2 setTitle:@"请输入关键字" forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"search_btn"] forState:UIControlStateNormal];
    btn2.titleLabel.font = FONT14;
    [btn2 setTitleColor:RGB(100, 100, 100) forState:UIControlStateNormal];
    [btn2 setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [btn2 setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    
    btn2.layer.masksToBounds = YES;
    btn2.layer.cornerRadius = 5;
    
    //    [_headView addSubview:btn2];
    
    [self setTitleViewWithCustomView:btn2];
    
    [btn2 addTarget:self action:@selector(searchBtnAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)searchBtnAction {
    
    SearchViewController *nextVC = [[SearchViewController alloc]init];
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
    
}


- (void)rightItemAction {
    
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        SGQRCodeScanningVC *nextVC = [[SGQRCodeScanningVC alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        
        //    [nextVC setScanSuccess:^(NSString *scanString){
        //
        //        [self scanActionWithString:scanString];
        //    }];
        
        [self.navigationController pushViewController:nextVC animated:YES];
    }else {
        NSLog(@"无相机");
    }
    
}


- (void)getLocation {
    
    _manager = [[LocationManager alloc]init];
    
    [_manager findMe];
    
    __weak typeof(self) weakSelf = self;
    
    _manager.getAddress = ^(NSString *city ,double lng , double lat){
        
        NSLog(@"city = %@",city);
        
        UIButton *btn = weakSelf.areaBtn ;
        
        [btn setTitle:city forState:UIControlStateNormal];
        
        
    };
    
    
}


- (UIView*)headView {
    
    if(_headView == nil){
        
        [self initHeadView];
    }
    
    return _headView;
}



- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    HBannerModel *model = _bannerArray[index];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
    
}


- (void)initHeadView {
    
    _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 0)];
    _headView.backgroundColor = [UIColor whiteColor];
    
    
    CGRect frame  = CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_WIDTH*(300/750.f));
    UIImage *placeholderImage = [UIImage imageNamed:@""];
    // 网络加载图片的轮播器
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
    cycleScrollView.delegate = self;
    [_headView addSubview:cycleScrollView];
    cycleScrollView.currentPageDotColor = MAINCOLOR;
    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    cycleScrollView.clipsToBounds = YES;


    self.cycleScrollView = cycleScrollView;
    
    CGFloat y = cycleScrollView.bottom;
    
    CGFloat h1 = 90;
    
    CGFloat max = 4;
    CGFloat w = SCREEM_WIDTH/max;
    
    NSArray *array = @[@"附近",@"最新",@"签到",@"摇一摇"];
    NSArray *arrayImage = @[@"001",@"002",@"003",@"004"];
    
    [self.iconsArray  addObjectsFromArray:array];
    
    for(int i=0;i<4;i++){
        
        IconButton *btn = [[IconButton alloc]initWithFrame:CGRectMake(i*w, y+0, w, h1)];
        
        [_headView addSubview:btn];
        [btn setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
        btn.titleLabel.font = FONT14;
        [_btnsArray addObject:btn];
        
        
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:arrayImage[i]] forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, y+h1+5, SCREEM_WIDTH, 44)];
    [btn setTitle:@"今日推荐" forState:UIControlStateNormal];
    [btn setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
    //    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    btn.titleLabel.font = FONT15;
    //    [btn setImage:[UIImage imageNamed:@"new_btn"] forState:UIControlStateNormal];
//    btn.backgroundColor = RGB(240, 240, 240);
    
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [_headView addSubview:btn];
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 0.5)];
    line.backgroundColor = RGB(200, 200, 200);
    [btn addSubview:line];
    
    //    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, btn.height - 0.5, SCREEM_WIDTH, 0.5)];
    //    line2.backgroundColor = RGB(200, 200, 200);
    //    [btn addSubview:line2];
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 7, 5, 30)];
    line2.backgroundColor = RGB(231, 76, 60);
    [btn addSubview:line2];
    
    
    _headView.frame = CGRectMake(0, 0, SCREEM_WIDTH, btn.bottom);
}

- (void)btnAction:(UIButton*)btn {
    
    NSInteger tag = [_btnsArray indexOfObject:btn];
    
    NSLog(@"= %@",@(tag));
    
    
    if(tag == 3){
        
        YaoYiYaoViewController *nextVC = [[YaoYiYaoViewController alloc]init];
        nextVC.dataSource = self.dataSource;
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 2){
        
        WalletViewController *nextVC = [[WalletViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
   
    else {
        
        HomeTypeViewController *nextVC = [[HomeTypeViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        nextVC.title2 = _iconsArray[tag];
        nextVC.titleTag = tag;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    
}





- (void)creatView {
    
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];

    
    //确定是水平滚动，还是垂直滚动
//    BBFlowLayout * flowLayout = [[BBFlowLayout alloc]init];
//    flowLayout.delegate = self;

        
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH,SCREEM_HEIGHT - 0 - 64 - 50 ) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.alwaysBounceHorizontal = NO;
    
    //注册Cell，必须要有
    [self.collectionView registerClass:[Home1_2CollectionViewCell class] forCellWithReuseIdentifier:@"Home1_2CollectionViewCell"];
    
    
    [self.view addSubview:self.collectionView];
    
    
    [self.collectionView registerClass:[Home1_2HeadView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader  withReuseIdentifier:@"Home1_2HeadView"];
    
    
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




#pragma mark - 头部或者尾部视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //如果是头部视图 (因为这里的kind 有头部和尾部所以需要判断  默认是头部,严谨判断比较好)
    /*
     JHHeaderReusableView 头部的类
     kHeaderID  重用标识
     */
    if (kind == UICollectionElementKindSectionHeader) {
        
        
        Home1_2HeadView *headerRV = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"Home1_2HeadView" forIndexPath:indexPath];
        
        
        [headerRV addSubview:self.headView];
        
        return headerRV;
        
    }
    else //有兴趣的也可以添加尾部视图
    {
        return nil;
    }
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
    
    if(_dataSource.count <= 0){
        
        return cell;
    }
    
   
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {

    CGFloat h = self.headView.height;
    
    return CGSizeMake(SCREEM_WIDTH, h);
}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    
//    return CGSizeMake(SCREEM_WIDTH, 0.1);
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
    
    [ParkTimeModel findNewObjects:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        [_dataSource addObjectsFromArray:objects];
        
        [self.collectionView reloadData];
    }];
    
    
    NSString *type = @"1";
    
    
    [HBannerModel findType:type Objects:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        [_bannerArray removeAllObjects];
        [_bannerArray addObjectsFromArray:objects];
        
        [self updateHeadView];
    }];
}

- (void)updateHeadView {
    
    NSLog(@"%@",self.headView);
    
    NSMutableArray * array = [NSMutableArray array];
    
    for(HBannerModel *model in _bannerArray){
        
        NSString *url = model.img_url;
        [array addObject:url];
    }
    
    self.cycleScrollView.imageURLStringsGroup = array;
    
}


@end
