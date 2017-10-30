//
//  ParkTimeViewController.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "ParkTimeViewController.h"

#import "Home2TableViewCell.h"

#import "ParkTimeModel.h"

#import "DetailViewController.h"


@interface ParkTimeViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)UISearchBar *searchBar;
@property (nonatomic ,strong)NSString *keyword;

@property (nonatomic ,assign)NSInteger selTag;

@end

@implementation ParkTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [NSMutableArray array];
    
    _keyword = @"";
    
//    [self initSearchBar];
//    [self creatMenu];
    
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





- (void)initSearchBar {
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 40)];
    _searchBar.placeholder = @"输入任务关键字";
    _searchBar.delegate = self;
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    _keyword = searchBar.text;
    
    [self.view endEditing:YES];
    
    [self.dataSource removeAllObjects];
    
    [self loadData];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    [self.view endEditing:YES];
}


- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64  - 50 - 0)];
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
    
    _tableView.tableHeaderView = _searchBar;
}


- (void)headRefreshing {
    
    _keyword = @"";
    
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
    
    DetailViewController *nextVC = [[DetailViewController alloc]init];
    nextVC.model = model;
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
}




- (void)loadData {
    
    
    
//    [ParkTimeModel findObjects:^(NSArray * _Nullable objects, NSError * _Nullable error) {
//        
//        [_dataSource addObjectsFromArray:objects];
//        
//        [_tableView reloadData];
//    }];
    
    
    
    if(_selTag == 0){
        
        [ParkTimeModel findKeyword:_keyword Objects:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            
            [_dataSource removeAllObjects];
            [_dataSource addObjectsFromArray:objects];
            
            [_tableView reloadData];
        }];
    }
    else if (_selTag == 1){
        
        [ParkTimeModel findNewObjects:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            [_dataSource removeAllObjects];
            [_dataSource addObjectsFromArray:objects];
            
            [_tableView reloadData];
            
        }];
    }
    else if (_selTag == 2){
     
        [ParkTimeModel findHotObjects:^(NSArray * _Nullable objects, NSError * _Nullable error) {
            [_dataSource removeAllObjects];
            [_dataSource addObjectsFromArray:objects];
            
            [_tableView reloadData];
        }];
    }
    
    
    
    
    
    
}



@end
