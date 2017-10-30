//
//  SettingsViewController.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/13.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "SettingsViewController.h"

#import "PwdViewController.h"

#import "AboutViewController.h"

@interface SettingsViewController ()<UITableViewDelegate,UITableViewDataSource >

@property (strong,nonatomic)UITableView*tableView;
@property (strong,nonatomic)NSArray*tableArr;
@property (nonatomic,strong)NSMutableArray* dataSource;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"设置"];
    
    _dataSource = [NSMutableArray arrayWithArray:@[@"关于我们",@"修改密码",@"清除缓存"]];
    
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
    
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 200)];
    _tableView.tableFooterView = footView;
    _tableView.backgroundColor = GRAYCOLOR;
    
    
    
    CGRect loginf = CGRectMake(20, 100, SCREEM_WIDTH - 40, 44);
    UIButton *login = [[UIButton alloc]initWithFrame:loginf ];
    login.backgroundColor = MAINCOLOR;
    [login setTitle:@"退出登录" forState:UIControlStateNormal];
    [login setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    login.titleLabel.font = FONT15;
//    login.layer.masksToBounds = YES;
//    login.layer.cornerRadius = 4;
    [footView addSubview:login];
    
    [login addTarget:self action:@selector(submitBtnAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)submitBtnAction {
    
    [AVUser logOut];  //清除缓存用户对象
//    AVUser *currentUser = [AVUser currentUser];
    [HUDManager alertText:@"退出成功"];
    [UserManager removeToken];
    [self.navigationController popViewControllerAnimated:YES];
}





- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return _dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    if(_dataSource.count <= 0){
        return cell;
    }
    
    cell.textLabel.font = FONT15;
    cell.textLabel.text = _dataSource[indexPath.row];
    
//    NSString *imgName = _tableArr[indexPath.row];
//    cell.imageView.image = [UIImage imageNamed:imgName];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    
    return CGRectGetHeight(cell.frame);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSInteger tag = indexPath.row;
    
    if(tag == 0){
        
        AboutViewController *nextVC = [[AboutViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
    }
    else if (tag == 1){
        
        PwdViewController *nextVC = [[PwdViewController alloc]init];
        nextVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:nextVC animated:YES];
       
    }
    else if (tag == 2){
        
        [HUDManager alertText:@"清除缓存成功"];
        
    }
    else if (tag == 3){
        
    }
}




@end
