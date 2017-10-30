//
//  AboutViewController.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/13.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@property (nonatomic ,strong)UITextView * textView ;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNaviBarBtn:@"关于我们"];
    
    [self initTextView];
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


- (void)initTextView {

    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(15, 15, SCREEM_WIDTH - 30, SCREEM_HEIGHT - 64 - 30)];
    _textView.font = FONT14;
    _textView.layer.masksToBounds = YES;
    _textView.layer.cornerRadius = 4;
    _textView.editable = NO;
    
    
    [self.view addSubview:_textView];
    
    [self setText];
}



- (void)setText {
    
    
    NSString * textStr = @"手机注册实名验证毫无后顾之忧，以众多优质兼职资源为依托，让兼职者和优秀企业都能及时解决个人所需达成合作；兼职信息准确匹配，更快找到工作，为兼职者提供人性化，个性化，专业化的兼职信息服务。";
    
    // 调整行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:textStr];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:3];
    
    paragraphStyle.firstLineHeadIndent = 20;
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:RGB(50, 50, 50),NSFontAttributeName:FONT14 ,NSParagraphStyleAttributeName:paragraphStyle};
 
    
    [attributedString setAttributes:attributes range:NSMakeRange(0, textStr.length)];
    
    
    
    
    _textView.attributedText = attributedString;
    
}



@end
