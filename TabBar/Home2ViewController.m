//
//  Home2ViewController.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/14.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "Home2ViewController.h"

#import <SDCycleScrollView.h>

#import "HBannerModel.h"

#import "IconButton.h"

#import "ParkTimeModel.h"

#import <UIButton+WebCache.h>

#import "Home2TableViewCell.h"

#import "DetailViewController.h"


#import "MKMapUtils.h"

#import "SignManager.h"


#import "Icon2Btn.h"

#import "LogViewController.h"

#import "SearchViewController.h"

#import "JFCityViewController.h"

#import "YaoYiYaoViewController.h"

#import "WalletViewController.h"

#import "SGQRCodeScanningVC.h"

#import "OttoCycleLabel.h"

#import "NewsModel.h"

#import "NewsDetailViewController.h"

#import "HomeViewController.h"

#import "HomeTypeViewController.h"

@interface Home2ViewController ()<UITableViewDelegate,UITableViewDataSource ,SDCycleScrollViewDelegate ,JFCityViewControllerDelegate>

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;


@property (nonatomic ,strong)UIView *headView;
@property (nonatomic ,strong)NSMutableArray* bannerArray;
@property (nonatomic ,strong)SDCycleScrollView *cycleScrollView;

@property (nonatomic ,strong)NSMutableArray* btnsArray;

@property (nonatomic ,strong)NSMutableArray* iconsArray;

@property (nonatomic ,strong)IconButton *areaBtn;
@property (nonatomic,strong)LocationManager *manager;

@property (nonatomic ,strong)OttoCycleLabel *label;

@property (nonatomic ,strong)NSMutableArray* banner2Array;

@property (nonatomic ,strong)UIImageView *imgView1;
@property (nonatomic ,strong)UIImageView *imgView2;


@end

@implementation Home2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataSource = [NSMutableArray array];
    
    _bannerArray = [NSMutableArray array];
    
    _banner2Array = [NSMutableArray array];
    
    _btnsArray = [NSMutableArray array];
    
    _iconsArray = [NSMutableArray array];
    
    [self initNaviBarBtn:@"开店兼职"];
    
    [self initLeftItem];
    [self initRightItem];
    
    [self initHeadView];
    
    [self initTableView];
    
    [self loadData];
    
    [self loadBanner];
    
    NSString *url = [UserManager isBannaer];
    
    if(url != nil){
        
        
        _tableView.frame = CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT - 64);
    }
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
    
    IconButton *btn = [[IconButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
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
    
    
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(60, 0, SCREEM_WIDTH - 120, 36)];
    
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
    
    
    CGFloat y = 0;//cycleScrollView.bottom;
    
    CGFloat h1 = 90;
    
//    CGRect frame  = CGRectMake(0, h1, SCREEM_WIDTH, SCREEM_WIDTH*(300/750.f));
//    UIImage *placeholderImage = [UIImage imageNamed:@""];
//    // 网络加载图片的轮播器
//    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:placeholderImage];
//    cycleScrollView.delegate = self;
//    [_headView addSubview:cycleScrollView];
//    cycleScrollView.currentPageDotColor = MAINCOLOR;
//    cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
//    cycleScrollView.clipsToBounds = YES;
//    
//    
//    self.cycleScrollView = cycleScrollView;
    

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
    
  
    
    CGFloat h2 = h1 + 60;
    
    [self setNavTitleCycleLabel];
    
    CGFloat w2 = (SCREEM_WIDTH - 45)/2 ;
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, h2, w2, w2)];
    
    [_headView addSubview:image1];
    
    self.imgView1 = image1;
    
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(w2+30, h2, w2, w2)];
    
    [_headView addSubview:image2];
    
    self.imgView2 = image2;
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTap1)];
    image1.userInteractionEnabled = YES;
    [image1 addGestureRecognizer:tap1];
    
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgTap2)];
    image2.userInteractionEnabled = YES;
    [image2 addGestureRecognizer:tap2];
    
    
    CGFloat h3 = h2 + image1.height+10;
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, h3, SCREEM_WIDTH, 40)];
    [btn setTitle:@"今日推荐" forState:UIControlStateNormal];
    [btn setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    btn.titleLabel.font = FONT15;
//    [btn setImage:[UIImage imageNamed:@"new_btn"] forState:UIControlStateNormal];
    btn.backgroundColor = RGB(240, 240, 240);
    
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_headView addSubview:btn];
    
//    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 0.5)];
//    line.backgroundColor = RGB(200, 200, 200);
//    [btn addSubview:line];
//    
//    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, btn.height - 0.5, SCREEM_WIDTH, 0.5)];
//    line2.backgroundColor = RGB(200, 200, 200);
//    [btn addSubview:line2];
    
    
    _headView.frame = CGRectMake(0, 0, SCREEM_WIDTH, btn.bottom);
}


- (void)imgTap1 {
    
    if([UserManager isBannaer] != nil){
        
        if(_banner2Array.count > 0){
            
            HBannerModel *model = _banner2Array[0];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
        }
    }
    
}

- (void)imgTap2 {
    
    if([UserManager isBannaer] != nil){
        
        if(_banner2Array.count > 1){
            
            HBannerModel *model = _banner2Array[1];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.url]];
        }
    }
}



- (void)setNavTitleCycleLabel{
    

    OttoCycleLabel *label = [[OttoCycleLabel alloc] initWithFrame:CGRectMake(15+65, 100, SCREEM_WIDTH-30 -65, 40) ];
    
    [_headView addSubview:label];
  
    
    self.label = label;
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cycleLabelTap:)];
    
    [label addGestureRecognizer:tap];
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(20, label.top, 40, 40)];
    img.image = [UIImage imageNamed:@"toutiao"];
    [_headView addSubview:img];
    
    
//    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, label.top-5, SCREEM_WIDTH, 5)];
//    line.backgroundColor = RGB(240, 240, 240);
//    [_headView addSubview:line];
    
//    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, label.bottom, SCREEM_WIDTH, 0.5)];
//    line2.backgroundColor = RGB(200, 200, 200);
//    [_headView addSubview:line2];
    
}


- (void)startLabel {
    
    _label.timeInterval = 1;
    _label.backgroundColor = [UIColor clearColor];
    _label.directionMode = DirectionTransitionFromTop;
    _label.textAlignment = NSTextAlignmentLeft;
    _label.font = FONT(14);
    _label.textColor = RGB(50, 50, 50);
    [_label startCycling];
    _label.userInteractionEnabled = YES;
}


- (void)cycleLabelTap:(UITapGestureRecognizer*)tap {
    
    OttoCycleLabel *label = (OttoCycleLabel*)tap.view;
    
    NSInteger index = [label getSelIndex]-1;
    
    NSLog(@"cycle = %@",@(index));
    
    if(index < _bannerArray.count && index >= 0){
        
        NewsModel *model = _bannerArray[index];
        
        NewsDetailViewController *nextVC = [[NewsDetailViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        nextVC.model = model;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    
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
    else if (tag == 1){
        
        HomeViewController *nextVC = [[HomeViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else {
        
        HomeTypeViewController *nextVC = [[HomeTypeViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        nextVC.title2 = _iconsArray[tag];
        nextVC.titleTag = 3;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    
}



- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0  - 64 - 50)];
    _tableView.dataSource = self;
    
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
    
    if([_tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if([_tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    
    _tableView.tableFooterView = [[UIView alloc] init];
    _tableView.backgroundColor = GRAYCOLOR;
    
    
    
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefreshing)];
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefreshing)];
    
    [footer setTitle:@"" forState:MJRefreshStateNoMoreData];
    
    [footer endRefreshingWithNoMoreData];
    
    
    _tableView.mj_footer = footer;
    
    
}


- (void)headRefreshing {
    
    [_dataSource removeAllObjects];
    
    [_tableView.mj_header endRefreshing];
    
    [self loadData];
    
    [self loadBanner];
}


- (void)footRefreshing {
    
    [_tableView.mj_footer endRefreshing];
    
    [self loadData];
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Home2TableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[Home2TableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    
    
    ParkTimeModel *model = _dataSource[indexPath.row];
    
    [cell dataWithModel:model];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ParkTimeModel *model = _dataSource[indexPath.row];
    
    DetailViewController *nextVC = [[DetailViewController alloc]init];
    nextVC.model = model;
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
    
    
}




- (void)loadData {
    
    [ParkTimeModel findNewObjects:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        [_dataSource addObjectsFromArray:objects];
        
        [_tableView reloadData];
    }];
    
}



- (void)loadBanner {
    
    _tableView.tableHeaderView = self.headView;
    
//    [_bannerArray removeAllObjects];
    
    
    [HBannerModel findType:@"2" Objects:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [_banner2Array removeAllObjects];
        [_banner2Array addObjectsFromArray:objects];
        
        
        if(_banner2Array.count > 0){
            
            HBannerModel *model = _banner2Array[0];
            [self.imgView1 sd_setImageWithURL:[NSURL URLWithString:model.img_url]];
        }
        if(_banner2Array.count > 1){
            
            HBannerModel *model = _banner2Array[1];
            
            [self.imgView2 sd_setImageWithURL:[NSURL URLWithString:model.img_url]];
        }
        
        
    }];
    
    
    if(_bannerArray.count > 0){
        return;
    }
    
    [NewsModel findObjects:^(NSArray * _Nullable objects, NSError * _Nullable error) {
    
        [_bannerArray removeAllObjects];
        [_bannerArray addObjectsFromArray:objects];
        
        if(_bannerArray.count <= 0){
            return ;
        }
        
        NSMutableArray *array = [NSMutableArray array];
        for(NewsModel *model in _bannerArray){
            
            [array addObject:model.title];
        }
        [self.label initWithTexts:array];
        [self startLabel];
        
    }];
    
    
    
   
    
    
}

- (void)updateHeadView {
    
    _tableView.tableHeaderView = self.headView;
    
    
    NSMutableArray * array = [NSMutableArray array];
    
    for(HBannerModel *model in _bannerArray){
        
        NSString *url = model.img_url;
        [array addObject:url];
    }
    
    self.cycleScrollView.imageURLStringsGroup = array;
    
    
    
    
}


@end
