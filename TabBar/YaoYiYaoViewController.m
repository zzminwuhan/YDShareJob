//
//  YaoYiYaoViewController.m
//  QKParkTime
//
//  Created by 李加建 on 2017/10/17.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "YaoYiYaoViewController.h"

#import "AlphaView.h"

#import "ParkTimeModel.h"

#import <AudioToolbox/AudioToolbox.h>

#import "DetailViewController.h"

#import "Home1_2DetailViewController.h"

@interface YaoYiYaoViewController ()

@property (nonatomic ,strong)UIImageView *imgView;

@property (nonatomic ,strong)AlphaView *headBarView;

@property (nonatomic ,strong)UIView *alertView;

@property (nonatomic ,strong)UIImageView *img;
@property (nonatomic ,strong)UILabel *label1;
@property (nonatomic ,strong)UILabel *label2;

@property (nonatomic ,strong)ParkTimeModel *model;

@end

@implementation YaoYiYaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"摇一摇"];
    
    [self startYao];
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT)];
    
    imgView.image = [UIImage imageNamed:@"yaoyiyao.png"];
    [self.view addSubview:imgView];
    
    
    
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(40, 0, SCREEM_WIDTH - 80, SCREEM_WIDTH - 80)];
    
    img.image = [UIImage imageNamed:@"yao"];
    
    [self.view addSubview:img];
    img.center = CGPointMake(self.view.center.x, self.view.center.y - 32);
    
    self.imgView = img;
    
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


- (void)tapAction {
    
    
    Home1_2DetailViewController *nextVC = [[Home1_2DetailViewController alloc]init];
    nextVC.model = _model;
    nextVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:nextVC animated:YES];
    
    [self.alertView removeFromSuperview];
}


- (UIView*)alertView {
    
    if(_alertView == nil){
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH - 40, 80)];
        
        view.backgroundColor = [UIColor whiteColor];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 4;
        
        
        view.center = CGPointMake(self.view.center.x, self.view.center.y - 32);
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
        
        [view addGestureRecognizer:tap];
        
//        [self.view addSubview:view];
        
        
        _img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        
        _img.clipsToBounds = YES;
        _img.contentMode = UIViewContentModeScaleAspectFill;
        [view addSubview:_img];
        
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(80, 0, view.width - 100, 40)];
        
//        label.text = model.title;
        label.font = FONT15;
        label.textColor = RGB(50, 50, 50);
        
        [view addSubview:label];
        
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(80, 40, view.width - 100, 30)];
        
//        label1.text = model.price;
        label1.font = FONT14;
        label1.textColor = RGB(231, 76, 60);
        
        [view addSubview:label1];
        
        self.label1 = label;
        self.label2 = label1;
        
        _alertView = view;
    }
    return _alertView;
}


- (void)creatHeadBar {
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(SCREEM_WIDTH/2 - 80, 27, 160, 30)];
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"摇一摇";
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


- (void)viewWillDisappear:(BOOL)animated {
    
    [self.imgView.layer removeAllAnimations];
}


- (void)startYao {
    
    [UIApplication sharedApplication].applicationSupportsShakeToEdit = YES;
    // 并让自己成为第一响应者
    [self becomeFirstResponder];
}


#pragma mark - ShakeToEdit 摇动手机之后的回调方法

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
    //检测到摇动开始
    if (motion == UIEventSubtypeMotionShake)
        
    {
        
        // your code
        
        NSLog(@"begin animations");
        
        [self.alertView removeFromSuperview];
        
        [self yaoAnimation];
        
    }
    
}

- (void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    
    
    NSLog(@"Cancel animations");
    [self.alertView removeFromSuperview];
    //摇动取消
    
}

- (void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event

{
    
    //摇动结束
    
    if (event.subtype == UIEventSubtypeMotionShake) {
        
        // your code
        
        NSLog(@"end animations");
        
//        [self.imgView.layer removeAllAnimations];
        
        [self getData];
    }
    else {
        
        NSLog(@"end animations = %@",@(event.subtype));
    }
    
}




- (void)yaoAnimation {

 
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.fromValue = @(-0.3);
    animation.toValue = @(0.3);
    animation.duration = 0.2;
    animation.repeatCount = HUGE_VALF;
    animation.autoreverses = YES;
    
    [self.imgView.layer addAnimation:animation forKey:@"animateLayer"];
    
    
    
}




- (void)getData {
    
    int x = arc4random() % _dataSource.count;
    
    ParkTimeModel *model = _dataSource[x];
    
    sleep(1);
    
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    
    [self.imgView.layer removeAllAnimations];
    
    NSLog(@"%@",model);
    
    _model = model;
    
    [self showAnimaViewWithModel:model];
}



- (void)showAnimaViewWithModel:(ParkTimeModel*)model {
    
    

    [self.view addSubview:self.alertView];
    
    _label1.text = model.title;
    _label2.text = model.price;
    
    
    AVFile *file = [model.job objectForKey:@"image"];
    
    [file getThumbnail:YES width:400 height:400 withBlock:^(UIImage * _Nullable image, NSError * _Nullable error) {
        
        _img.image = image;
    }];
    
    [self animationAlert:self.alertView];
    
    NSLog(@"alert");
    
}



- (void) animationAlert:(UIView *)view
{
    
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.0f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
    
    
}



@end
