//
//  Home1_2DetailViewController.m
//  YDShareJob
//
//  Created by 李加建 on 2017/10/23.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "Home1_2DetailViewController.h"

#import "Detail1_2HeadView.h"

#import "FootBar.h"

#import "MapViewController.h"

#import "CollectModel.h"

#import "ReportModel.h"

#import "MessageModel.h"

#import "LogViewController.h"

#import "Home2TableViewCell.h"

@interface Home1_2DetailViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)Detail1_2HeadView*headView ;

@property (nonatomic ,strong)FootBar *footBar ;

@end

@implementation Home1_2DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"任务详情"];
    
    [self initLeftItem];
    
    [self initHeadView];
    
    [self creatFootBar];
    
    [self initTableView];
    
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
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [btn setImage:[UIImage imageNamed:@"share_btn"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setRightBarWithCustomView:btn];
    
}

- (void)leftBtnAction {
    
    NSString * string = [NSString stringWithFormat:@"https://itunes.apple.com/cn/app/id%@?mt=8",APPSTOREID];
    
    NSString *share_title = @"分享给你";
    NSString *share_url = string;
    UIActivityViewController *avc = [[UIActivityViewController alloc]initWithActivityItems:@[share_title,[NSURL URLWithString:share_url]] applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
    
}




- (void)initHeadView {
    
    
    Detail1_2HeadView *headView = [[Detail1_2HeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 100)];
    
    [headView setMapBlock:^{
        
        MapViewController *nextVC = [[MapViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        nextVC.model = self.model;
        [self.navigationController pushViewController:nextVC animated:YES];
    }];
    
    _headView = headView;
}



- (void)creatFootBar {
    
    FootBar *footBar = [[FootBar alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT - 64 - 60, SCREEM_WIDTH, 60)];
    
    [self.view addSubview:footBar];
    // 收藏
    [footBar setGoBlock1:^{
        
        // 广告
        NSString *url = [UserManager isBannaer];
        
        if(url != nil){
            
            return ;
        }
        
        
        NSString * token = [UserManager getToken];
        
        if(token == nil){
            
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:[[LogViewController alloc]init]];
            [self presentViewController:navi animated:YES completion:nil];
            
            return;
        }
        
        [CollectModel addCollectWithJob:_model.job block:^{
            
            self.footBar.collectBtn.selected = YES;
            [HUDManager alertText:@"收藏成功"];
        }];
        
        
    }];
    
    //取消收藏
    [footBar setGoBlock3:^{
        
        // 广告
        NSString *url = [UserManager isBannaer];
        
        if(url != nil){
            return ;
        }
        
        NSString * token = [UserManager getToken];
        
        if(token == nil){
            
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:[[LogViewController alloc]init]];
            [self presentViewController:navi animated:YES completion:nil];
            
            return;
        }
        
        
        [CollectModel delWithJob:_model.job block:^{
            self.footBar.collectBtn.selected = NO;
            [HUDManager alertText:@"取消成功"];
        }];
        
        
    }];
    
    // 报名
    [footBar setGoBlock2:^{
        
        // 广告
        NSString *url = _model.url;
        
        NSString *banner = [UserManager isBannaer];
        
        if([_model.bid isEqualToString:BUNDLEID] == YES && banner != nil){
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
            return ;
        }
        
        
        // 登录
        NSString * token = [UserManager getToken];
        
        if(token == nil){
            
            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:[[LogViewController alloc]init]];
            [self presentViewController:navi animated:YES completion:nil];
            
            return;
        }
        
        // 是否报名
        UIButton *btn = self.footBar.reportBtn;
        if(btn.selected == YES){
            return;
        }
        
        
        [ReportModel addReportWithJob:_model.job block:^(BOOL isOk){
            
            NSString * str = [NSString stringWithFormat:@"【%@】报名成功",_model.title];
            [MessageModel addMsg:@"系统提示" detail:str block:^{
                
            }];
            
            self.footBar.reportBtn.selected = YES;
            [self.footBar setReportBtnSel:YES];
            [HUDManager alertText:@"报名成功"];
            
            
        }];
        
    }];
    
    
    _footBar = footBar;
}



- (void)report {
    
    
    AVQuery *query = [AVQuery queryWithClassName:@"Park_Time"];
    
    AVObject *object = [query getObjectWithId:_model.Id];
    
    NSArray *reports = [object objectForKey:@"Report"];
    
    NSMutableArray *arr = [NSMutableArray array];
    [arr addObjectsFromArray:reports];
    
    
    [arr addObject:[UserManager getToken]];
    
    [object setObject:arr forKey:@"Report"];
    
    NSLog(@"report");
}



- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, SCREEM_HEIGHT - 64  - 60)];
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
    
    _tableView.tableHeaderView = _headView;
}


- (void)headRefreshing {
    
    [_dataSource removeAllObjects];
    
    [_tableView.mj_header endRefreshing];
    
    [self loadData];
    
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
    
    Home1_2DetailViewController *nextVC = [[Home1_2DetailViewController alloc]init];
    nextVC.model = model;
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}




- (void)loadData {
    
    
    [_model findObjectId:_model.Id success:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        
        [_headView dataWithModel:_model];
        
        self.tableView.tableHeaderView = _headView;
    }];
    
    
    [CollectModel isCollectWithJob:_model.job block:^(BOOL isColl) {
        
        self.footBar.collectBtn.selected = isColl;
    }];
    
    
    [ReportModel isReportWithJob:_model.job block:^(BOOL isColl) {
        
        self.footBar.reportBtn.selected = isColl;
        
        [self.footBar setReportBtnSel:isColl];
        
    }];
    
    
    
    [ParkTimeModel findHotObjects:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        [_dataSource removeAllObjects];
        [_dataSource addObjectsFromArray:objects];
        
        [self.tableView reloadData];
        
    }];
    
}


@end
