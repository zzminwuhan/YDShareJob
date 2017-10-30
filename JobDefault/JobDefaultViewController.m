//
//  JobDefaultViewController.m
//  YDShareJob
//
//  Created by 李加建 on 2017/10/17.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "JobDefaultViewController.h"

#import "JobDefaultTableViewCell.h"

#import "JobDetailViewController.h"

#import <SDCycleScrollView.h>

#import "JobBannerModel.h"

#import "AlphaView.h"

@interface JobDefaultViewController ()<UITableViewDelegate,UITableViewDataSource ,SDCycleScrollViewDelegate >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;


@property (nonatomic ,strong)UIView *headView;
@property (nonatomic ,strong)NSMutableArray* bannerArray;
@property (nonatomic ,strong)SDCycleScrollView *cycleScrollView;

@property (nonatomic ,strong)AlphaView *headBarView;

@end

@implementation JobDefaultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self initTitle:APPName];
    
    self.dataSource = [NSMutableArray array];
    
    self.bannerArray = [NSMutableArray array];
    
    [self initTableView];
    
    [self loadData];
    
    [self loadBanner];
    
//    [self.view addSubview:self.headBarView];
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

//- (void)viewWillAppear:(BOOL)animated {
//    
//    [super viewWillAppear:animated];
//    
//    [self.navigationController setNavigationBarHidden:YES animated:animated];
//   
//}



- (AlphaView*)headBarView {
    
    if(_headBarView == nil){
        
        _headBarView = [[AlphaView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 64)];
        //        _headBarView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_headBarView];
        
        [self creatHeadBar];
    }
    
    return _headBarView;
}

- (void)creatHeadBar {
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2 - 80, 27, 160, 30)];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = APPName;
    label.textColor = RGB(255, 255, 255);
    
    [_headBarView addSubview:label];
    

}



- (UIView*)headView {
    
    if(_headView == nil){
        
        [self initHeadView];
    }
    
    return _headView;
}



- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    
    JobBannerModel *model = _bannerArray[index];
    
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
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, y, SCREEM_WIDTH, 40)];
    [btn setTitle:@"今日推荐" forState:UIControlStateNormal];
    [btn setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
    //    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    btn.titleLabel.font = FONT15;
    //    [btn setImage:[UIImage imageNamed:@"new_btn"] forState:UIControlStateNormal];
//    btn.backgroundColor = RGB(240, 240, 240);
    
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_headView addSubview:btn];
    
    //    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 0.5)];
    //    line.backgroundColor = RGB(200, 200, 200);
    //    [btn addSubview:line];
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, btn.height - 0.5, SCREEM_WIDTH, 0.5)];
    line2.backgroundColor = RGB(200, 200, 200);
    [btn addSubview:line2];
    
    
    _headView.frame = CGRectMake(0, 0, SCREEM_WIDTH, btn.bottom);
}




- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0)];
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
    JobDefaultTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[JobDefaultTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    
    
    JobDefaultModel *model = _dataSource[indexPath.row];
    
    [cell dataWithModel:model];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    JobDefaultModel *model = _dataSource[indexPath.row];
    
    JobDetailViewController *nextVC = [[JobDetailViewController alloc]init];
    nextVC.model = model;
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
    
    
}




- (void)loadData {
    
    [JobDefaultModel findObjects:^(NSArray * _Nullable objects, NSError * _Nullable error) {

        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:objects];
        
        [_tableView reloadData];
    }];

}



- (void)loadBanner {
    
    
    [JobBannerModel findObjects:^(NSArray * _Nullable objects, NSError * _Nullable error) {
      
        [_bannerArray removeAllObjects];
        
        [_bannerArray addObjectsFromArray:objects];
        
        
        [self updateHeadView];
    }];
     
    

}



- (void)updateHeadView {
    
    _tableView.tableHeaderView = self.headView;
    
    NSMutableArray * array = [NSMutableArray array];
    
    for(JobBannerModel *model in _bannerArray){
        
        NSString *url = model.img_url;
        [array addObject:url];
    }
    
    self.cycleScrollView.imageURLStringsGroup = array;
    
}

@end
