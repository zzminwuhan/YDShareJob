//
//  HomeViewController.m
//  YDShareJob
//
//  Created by 李加建 on 2017/10/19.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HomeViewController.h"

#import "HomeTableViewCell.h"

#import "DetailViewController.h"

#import "AlphaView.h"

#import "ReportModel.h"

#import "LogViewController.h"

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)AlphaView *headBarView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [NSMutableArray array];
    
    [self initTableView];
    
    [self loadData];
    
    [self.view addSubview:self.headBarView];
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
    label.text = @"最新";
    label.textColor = RGB(255, 255, 255);
    
    [_headBarView addSubview:label];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20, 50, 44)];
    [btn setImage:[UIImage imageNamed:@"btn_back"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];

    [_headBarView addSubview:btn];
}


- (void)leftBtnAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    
}

- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0  - 0 - 0)];
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
    
    _tableView.pagingEnabled = YES;
    
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
    HomeTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    
    
    ParkTimeModel *model = _dataSource[indexPath.row];
    
    [cell dataWithModel:model];
    
    
    cell.goBlock = ^{
        
        AVUser *user = [AVUser currentUser];
        
        if(user == nil){
            

            UINavigationController *navi = [[UINavigationController alloc]initWithRootViewController:[[LogViewController alloc]init]];
            [self presentViewController:navi animated:YES completion:nil];
            
            return;
            
        }
        
        
        [ReportModel isReportWithJob:model.job block:^(BOOL isColl) {
            
            if(isColl == YES){
                [HUDManager alertText:@"已经报名"];
            }
            else {
                
                [ReportModel addReportWithJob:model.job block:^(BOOL isOk){
                    
                    NSString * str = [NSString stringWithFormat:@"【%@】报名成功",model.title];
                    [MessageModel addMsg:@"系统提示" detail:str block:^{
                        
                    }];
                    [HUDManager alertText:@"报名成功"];
                    
                }];
            }
            
        }];
    };
    
    cell.goBlock2 = ^{
        
        DetailViewController *nextVC = [[DetailViewController alloc]init];
        nextVC.model = model;
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    };
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
//    ParkTimeModel *model = _dataSource[indexPath.row];
//    
//    DetailViewController *nextVC = [[DetailViewController alloc]init];
//    nextVC.model = model;
//    nextVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:nextVC animated:YES];
    
}




- (void)loadData {
    
    [ParkTimeModel findNewObjects:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        [_dataSource addObjectsFromArray:objects];
        
        [_tableView reloadData];
    }];
    
}



@end
