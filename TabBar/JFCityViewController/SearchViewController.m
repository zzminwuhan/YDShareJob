//
//  SearchViewController.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/21.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "SearchViewController.h"

#import "Home2TableViewCell.h"

#import "ParkTimeModel.h"

#import "DetailViewController.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)UITextField *textField;

@property (nonatomic ,strong)NSString *keyword;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataSource = [NSMutableArray array];
    
    [self initNaviBarBtn:@""];
    
    [self creatView];
    
    [self initTableView];
    
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
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)creatView {
    
    
    _textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH - 120, 30)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.layer.masksToBounds = YES;
    _textField.layer.cornerRadius = 5;
    [self setTitleViewWithCustomView:_textField];
    _textField.font = FONT15;
    _textField.placeholder = @"请输入关键字";
    _textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
//    [btn setImage:[UIImage imageNamed:@"search_btn"] forState:UIControlStateNormal];
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setRightBarWithCustomView:btn];
    btn.titleLabel.font = FONT14;
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
//    _textField.text = @"人";
    
}


- (void)btnAction {
    
    [self.view endEditing:YES];
    
    [self loadData];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    
    [self.view endEditing:YES];
}


- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64  - 0)];
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
    
    
    
    
    [ParkTimeModel findKeyword:_textField.text Objects:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        [self.dataSource removeAllObjects];
        
        [_dataSource addObjectsFromArray:objects];
        
        [_tableView reloadData];
    }];
}






@end
