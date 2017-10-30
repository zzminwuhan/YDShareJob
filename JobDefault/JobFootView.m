//
//  JobFootView.m
//  YDShareJob
//
//  Created by 李加建 on 2017/10/17.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "JobFootView.h"


@interface JobFootView ()


@end

@implementation JobFootView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self creatView];
    
    return self;
}


- (void)creatView {
    
    
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 0.5)];
    line.backgroundColor = RGB(200, 200, 200);
    [self addSubview:line];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, 5, SCREEM_WIDTH - 30, 40)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"立即加入" forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.titleLabel.font = FONT15;
    btn.layer.cornerRadius = 2;
    btn.backgroundColor = MAINCOLOR;
    [self addSubview:btn];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}



- (void)btnAction {
    
    if(_goBlock1 != nil){
        _goBlock1();
    }
}


@end
