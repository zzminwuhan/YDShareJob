//
//  FootBar.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "FootBar.h"

@implementation FootBar

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
    
    CGFloat y = 9;
    CGFloat h = self.height - y*2;
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake((self.width - 45)*0.6+30, y, (self.width - 45)*0.4, h)];
    
    [btn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"collect_s"] forState:UIControlStateSelected];
    [btn setTitle:@"收藏" forState:UIControlStateNormal];
    [btn setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
    
    btn.layer.borderWidth = 0.5;
    btn.layer.borderColor = RGB(200, 200, 200).CGColor;
    btn.layer.cornerRadius = 2;
    btn.layer.masksToBounds = YES;
    
    [self addSubview:btn];
    
    self.collectBtn = btn;
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(15, y, (self.width - 45)*0.6, h)];
    [btn2 setTitle:@"马上加入" forState:UIControlStateNormal];
//    [btn2 setTitle:@"已加入" forState:UIControlStateSelected];
//    [btn2 setTitle:@"" forState:UIControlStateHighlighted];
    btn2.layer.cornerRadius = 2;
    btn2.layer.masksToBounds = YES;

//    [btn2 setTitleColor:RGB(200, 200, 200) forState:UIControlStateSelected];
    [btn2 setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];

    btn2.backgroundColor = RGB(52, 152, 219);
    [self addSubview:btn2];
    
    self.reportBtn = btn2;
    
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 0.5)];
    line.backgroundColor = RGB(200, 200, 200);
    [self addSubview:line];
    
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn2 addTarget:self action:@selector(btn2Action:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btn2Action:(UIButton*)btn {
    
    
    
    if(_goBlock2 != nil){
        _goBlock2();
    }
}

// 收藏

- (void)btnAction:(UIButton*)btn {
    
    if(btn.selected == YES){
        if(_goBlock3 != nil){
            _goBlock3();
        }
    }
    else {
        
        if(_goBlock1 != nil){
            _goBlock1();
        }
    }
    
}


- (void)setReportBtnSel:(BOOL)isSel {
    
    
    if(isSel == YES){
        
        [self.reportBtn setTitle:@"已加入" forState:UIControlStateNormal];
        [self.reportBtn setTitleColor:RGB(200, 200, 200) forState:UIControlStateNormal];
    }
    else {
        [self.reportBtn setTitle:@"马上加入" forState:UIControlStateNormal];
        [self.reportBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    }
    
}


@end
