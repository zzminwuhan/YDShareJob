//
//  WalletViewController.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "WalletViewController.h"

#import "RewardPoints.h"

#import "WalletTableViewCell.h"

@interface WalletViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@property (nonatomic ,strong)UILabel *price;

@property (nonatomic ,strong)UIButton *signBtn;
@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"我的积分"];
    
    self.dataSource = [NSMutableArray array];
    
    [self initLeftItem];
    
    [self initHeadView];
    
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


- (void)initLeftItem {
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [btn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    [btn setTitle:@"说明" forState:UIControlStateNormal];
    btn.titleLabel.font = FONT14;
    
    [btn addTarget:self action:@selector(leftBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self setRightBarWithCustomView:btn];
    
}

- (void)leftBtnAction {
    
    NSString *message = @"积分是对会员签到、录用的奖励分值，积分越高，录用的几率越大。";
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"说明" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    
    [alert show];
}



- (void)initHeadView {
    
    
    UIView* headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 120)];
    
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 20, SCREEM_WIDTH - 30, 20)];
    label.text = @"总积分";
    label.font = FONT14;
    label.textColor = RGB(100, 100, 100);
    [headView addSubview:label];
    
    
    UILabel *price = [[UILabel alloc]initWithFrame:CGRectMake(15, 50, SCREEM_WIDTH - 30, 60)];
    price.text = @"0";
    price.font = [UIFont fontWithName:@"Helvetica" size:50];
    price.textColor = RGB(231, 76, 60);
    [headView addSubview:price];
    
    self.price = price;
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 120-0.5, SCREEM_WIDTH, 0.5)];
    line.backgroundColor = RGB(200, 200, 200);
    [headView addSubview:line];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 120, 45, 100, 30)];
    [btn setTitle:@"签到" forState:UIControlStateNormal];
    [btn setTitle:@"已签到" forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = FONT14;
    btn.backgroundColor = MAINCOLOR;
    
    [btn setImage:[UIImage imageNamed:@"sign"] forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 5)];
    [headView addSubview:btn];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = btn.height/2;
    
    [btn addTarget:self action:@selector(signBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.signBtn = btn;
    
    [self canSign:YES];
    
    
    [RewardPoints canAddRewardWithValue:nil block:^(BOOL isOK) {
        
        [self canSign:isOK];
    }];
    
    
}


- (void)signBtnAction {
    
    [RewardPoints addRewardWithValue:@"5" block:^(BOOL isOK) {
        
        [HUDManager alertText:@"签到成功"];
        [self canSign:NO];
        // 刷新数据
        [_dataSource removeAllObjects];
        [self loadData];
    }];
}



- (void)canSign:(BOOL)can {
    
    if(can == YES){
        
        self.signBtn.backgroundColor = MAINCOLOR;
        self.signBtn.userInteractionEnabled = YES;
        self.signBtn.selected = NO;
    }
    else {
        self.signBtn.backgroundColor = GRAY200;
        self.signBtn.userInteractionEnabled = NO;
        self.signBtn.selected = YES;
    }
    
}



- (void)initTableView  {
    
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 120, self.view.frame.size.width, self.view.frame.size.height - 64  - 120)];
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
    WalletTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[WalletTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    
    RewardPoints *model = _dataSource[indexPath.row];
    
//    cell.textLabel.text = model.value;
    
    [cell dataWithModel:model];
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}




- (void)loadData {
    
    
    [RewardPoints findObjects:^(NSArray * _Nullable objects, NSError * _Nullable error) {
       
        [_dataSource addObjectsFromArray:objects];
        
        [_tableView reloadData];
        
        [self countTotal];
        
    }];
}


- (void)countTotal {
    
    CGFloat total = 0.0;
    for(int i=0;i<_dataSource.count;i++){
        
        RewardPoints *model = _dataSource[i];

        total = total + [model.value integerValue];
    }
    
    self.price.text = [NSString stringWithFormat:@"%.0f",total];
}



@end
