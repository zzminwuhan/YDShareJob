//
//  ReportViewController.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/13.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "ReportViewController.h"

#import "ReportTableViewCell.h"

#import "ParkTimeModel.h"

#import "DetailViewController.h"

#import "CollectModel.h"

#import "ReportModel.h"

#import "MessageModel.h"

@interface ReportViewController ()<UITableViewDelegate,UITableViewDataSource ,UIAlertViewDelegate>

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)NSString *reportId;

@property (nonatomic ,strong)ReportModel *delModel;

@end

@implementation ReportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"我的申请"];
    
    self.dataSource = [NSMutableArray array];
    
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
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 0  - 50)];
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
    
    //    _tableView.tableHeaderView = _headView;
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
    ReportTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[ReportTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    
    ReportModel *model =  _dataSource[indexPath.row];
    
    [cell dataWithModel:model];
    
    // 取消
    [cell setGoBlock1:^{
        
        self.delModel = model;
        [self quxiaoAction];
    }];
    
    // 举报
    [cell setGoBlock2:^{
        
        [self JuBaoAction];
    }];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ReportModel *model = _dataSource[indexPath.row];
    
    DetailViewController *nextVC = [[DetailViewController alloc]init];
    nextVC.model = model.jobModel;
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}











- (void)loadData {
    
    
    
    [ReportModel findObjects:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        [_dataSource addObjectsFromArray:objects];
        
        [_tableView reloadData];
    }];
    
    
}



- (void)quxiaoAction {
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否确定取消" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 2000;
    [alert show];
}



- (void)JuBaoAction {
    
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"举报原因" message:@"请选择您的举报原因。经查证如不属实将影响您的信用度" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"岗位已过期",@"收费/虚假信息",@"到岗不予录用",@"其他", nil];
    alert.tag = 1000;
    
    [alert show];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    
    if(alertView.tag == 1000){
        
        if(buttonIndex != 0){
            
            [HUDManager alertText:@"提交成功"];
        }
    }
    else if (alertView.tag == 2000){
        
        if(buttonIndex != 0){
            
            [ReportModel delReport:self.delModel.Id block:^(BOOL isOK) {
                
                [_dataSource removeObject:self.delModel];
                [_tableView reloadData];
                
                ParkTimeModel *model  = self.delModel.jobModel;
                NSString * str = [NSString stringWithFormat:@"【%@】取消申请",model.title];
                [MessageModel addMsg:@"系统提示" detail:str block:^{
                    
                }];
                
                [HUDManager alertText:@"取消成功"];
                
            }];
        }
    }
    
    
}




@end
