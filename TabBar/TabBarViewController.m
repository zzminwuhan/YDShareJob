//
//  TabBarViewController.m
//  YDShareJob
//
//  Created by 李加建 on 2017/10/18.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "TabBarViewController.h"

#import "InfoViewController.h"

#import "MessageViewController.h"

#import "Home2ViewController.h"

#import "ParkTimeViewController.h"

#import "Home1_2ViewController.h"
#import "TotalViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initTabBar];
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





- (void)initTabBar {
    
    Home1_2ViewController *vc1 = [[Home1_2ViewController alloc]init];
    UIBaseNavigationController *navi1 = [[UIBaseNavigationController alloc]initWithRootViewController:vc1];
    vc1.title = @"首页";

    
    
    TotalViewController *vc2 = [[TotalViewController alloc]init];
    
    UIBaseNavigationController *navi2 = [[UIBaseNavigationController alloc]initWithRootViewController:vc2];
    
    vc2.title = @"全部";
    InfoViewController *vc3 = [[InfoViewController alloc]init];
    
    UIBaseNavigationController *navi3 = [[UIBaseNavigationController alloc]initWithRootViewController:vc3];
    
    vc3.title = @"我的";
    
    
    MessageViewController *vc4 = [[MessageViewController alloc]init];
    
    UIBaseNavigationController *navi4 = [[UIBaseNavigationController alloc]initWithRootViewController:vc4];
    
    vc4.title = @"消息";
    
    
    [self setVC:vc1 image:@"tabbar_002" selectedImage:@"tabbar_001"];
    [self setVC:vc1 image:@"tabbar_002" selectedImage:@"tabbar_001"];
    [self setVC:vc2 image:@"tabbar_004" selectedImage:@"tabbar_003"];
    [self setVC:vc3 image:@"tabbar_006" selectedImage:@"tabbar_005"];
    [self setVC:vc4 image:@"tabbar_008" selectedImage:@"tabbar_007"];
    
    
    self.tabBar.translucent = NO;
    self.viewControllers = @[navi1,navi2,navi4,navi3];
    
    [[UITabBar appearance] setTintColor:MAINCOLOR];
    
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    
    
    navi1.navigationBar.translucent = NO;
    navi2.navigationBar.translucent = NO;
    navi3.navigationBar.translucent = NO;
    navi4.navigationBar.translucent = NO;
    
    
    //    [[UINavigationBar appearance] setBarTintColor:MAINCOLOR];
    //    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor] ,NSFontAttributeName:FONT18 }];
    
    
    //    tabBar 画线颜色
    CGRect rect = CGRectMake(0, 0, SCREEM_WIDTH, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, RGB(200, 200, 200).CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [[UITabBar appearance] setShadowImage:img];
    
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
    
    
    //    self.viewControllers = @[navi1];
    
    
}




- (void)setVC:(UIViewController *)vc image:(NSString *)image selectedImage:(NSString *)selectedImage {
    
    
    //    vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:nil image:[UIImage imageNamed:image] selectedImage:[UIImage imageNamed:selectedImage]];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    [vc.tabBarItem setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [vc.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -3)];
    
}




@end
