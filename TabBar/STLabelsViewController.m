//
//  STLabelsViewController.m
//  DongJie
//
//  Created by yuyue on 2017/8/9.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "STLabelsViewController.h"


#import "STLabelsCollectionViewCell.h"


@interface STLabelsViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout >


@property (strong, nonatomic)UICollectionView *collectionView;

@property (nonatomic,strong)NSMutableArray *dataSource1;
@property (nonatomic,strong)NSMutableArray *dataSource2;

@property (nonatomic,strong)NSMutableArray *selArray1;
@property (nonatomic,strong)NSMutableArray *selArray2;

@property (nonatomic,strong)NSString *selStr1;
@property (nonatomic,strong)NSString *selStr2;

@property (nonatomic,strong)STLabelsModel *model;

@property (nonatomic,strong)UITextField *textField;

@end

@implementation STLabelsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"兼职意向"];
    
    _dataSource1 = [NSMutableArray array];
    _dataSource2 = [NSMutableArray array];
    
    _selArray1 = [NSMutableArray array];
    _selArray2 = [NSMutableArray array];
    
    [self initData];
    
    [self initRightItem];
    
    _model = [STLabelsModel userdefaults];
    
    [self creatView];
    
//    [self creatViewBar];
    
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



- (void)initRightItem {
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 44)];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    btn.titleLabel.font = FONT14;
    
    [self setRightBarWithCustomView:btn];
    
    [btn addTarget:self action:@selector(authBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
}





- (void)initData {
    
    NSArray *array = @[@"传单派发",@"商场促销",@"餐饮服务",@"客服话务",@"会展执行",
                       @"观众充场",@"外卖送餐",@"快递分拣",@"市场推广",@"销售导购",
                       @"现场保安",@"商业演出",@"礼仪模特",@"问卷调查",@"企业实习",
                       @"暑期兼职",@"临时工",@"App试玩",@"主播",@"其他兼职"];
    
    
    NSArray *selArray = [[AVUser currentUser] objectForKey:@"labels"];
    
    [_selArray1 addObjectsFromArray:selArray];
    
    for(int i=0;i<array.count;i++){
    
        // 初始化
        STLabelsModel *model = [STLabelsModel new];
        model.type_title = array[i];
        model.isSel = NO;
        
        if([selArray containsObject:model.type_title]){
            model.isSel = YES;
        }
        
        [_dataSource1 addObject:model];
    }
    
    
 
    
}



- (void)creatViewBar {
    
    
    CGFloat w = SCREEM_WIDTH - 100;
    
//    UIButton *jump = [[UIButton alloc]initWithFrame:CGRectMake(50, SCREEM_HEIGHT - 64 - 100, w, 40)];
//    
//    UIColor *jumpColor = [UIColor whiteColor];
//    
//    jump.layer.masksToBounds = YES;
//    jump.layer.cornerRadius = jump.height/2;
//    jump.backgroundColor = jumpColor;
//    [jump setTitle:@"重置" forState:UIControlStateNormal];
//    [jump setTitleColor:MAINCOLOR forState:UIControlStateNormal];
//    jump.layer.borderColor = MAINCOLOR.CGColor;
//    jump.layer.borderWidth = 1;
//    jump.titleLabel.font = FONT15;
//    
//    [self.view addSubview:jump];
    
    UIButton *auth = [[UIButton alloc]initWithFrame:CGRectMake(50, SCREEM_HEIGHT - 64 - 50, w, 40)];
    
    auth.layer.masksToBounds = YES;
    auth.layer.cornerRadius = auth.height/2;
    auth.backgroundColor = MAINCOLOR;
    [auth setTitle:@"保存" forState:UIControlStateNormal];
    [auth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    auth.titleLabel.font = FONT15;
    
    [self.view addSubview:auth];
    
    
//    [jump addTarget:self action:@selector(jumpBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [auth addTarget:self action:@selector(authBtnAction) forControlEvents:UIControlEventTouchUpInside];
}



- (void)jumpBtnAction {
    
  
    
}

- (void)authBtnAction {
    
    [self uploadData];
}





- (void)creatView {
    
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    //    flowLayout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH,SCREEM_HEIGHT - 0 - 64 ) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.alwaysBounceHorizontal = NO;
    
    //注册Cell，必须要有
    [self.collectionView registerClass:[STLabelsCollectionViewCell class] forCellWithReuseIdentifier:@"STLabelsCollectionViewCell"];
    
    
    [self.view addSubview:self.collectionView];
    
    
    //    [self.collectionView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footRefreshing)];
    
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
}







#pragma mark - UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _dataSource1.count;
    
}



//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"STLabelsCollectionViewCell";
    STLabelsCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    

    
    if(indexPath.section == 0){
        
        STLabelsModel *model1 = _dataSource1[indexPath.row];
        [cell dataWithModel:model1];
        cell.btnBlock = ^(){
            
            if(model1.isSel == YES){
                
                NSLog(@"add");
                model1.isSel = NO;
                [_selArray1 removeObject:model1.type_title];
                
            }
            else {
                
                [_selArray1 addObject:model1.type_title];
                model1.isSel = YES;
            }
            
            [self.collectionView reloadData];
        };
        
        
    }
  
    
    
    return cell;
}






#pragma mark - UICollectionViewDelegateFlowLayout


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return CGSizeMake(SCREEM_WIDTH/4, 50);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    
    return UIEdgeInsetsMake(5, 0, 5, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
//    CGFloat ww = (SCREEM_WIDTH - 90*4 - 40)/3;
    
    return 0;
}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    
//    return CGSizeMake(SCREEM_WIDTH, 44);
//}




#pragma mark - load json
- (void)loadData {
    
   
}



#pragma mark 上传数据
- (void)uploadData {
    
    
    AVUser *user = [AVUser currentUser];
    
    [user setObject:_selArray1 forKey:@"labels"];
    
    [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        if(succeeded == YES){
            
            [HUDManager alertText:@"保存成功"];
            
        }
        else {
            [HUDManager alertText:@"保存失败"];
        }
    }];
    
}










@end
