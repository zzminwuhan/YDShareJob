//
//  STLabelsCollectionViewCell.m
//  DongJie
//
//  Created by yuyue on 2017/8/11.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "STLabelsCollectionViewCell.h"


@interface STLabelsCollectionViewCell ()

@property (nonatomic ,strong)UIButton *button;

@property (nonatomic ,strong)UIButton *delBtn;

@end


@implementation STLabelsCollectionViewCell





- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    [self creatView];
    
    
    return self;
}



- (void)creatView {
    
//    self.contentView.backgroundColor = [UIColor redColor];
    
    _button = [[UIButton alloc]initWithFrame:CGRectMake(self.width/2-35, self.height/2 - 15, 70, 30)];
    
    _button.layer.masksToBounds = YES;
    _button.layer.cornerRadius = 2;
    _button.layer.borderWidth = 1;
    
    [_button setTitleColor:GRAY100 forState:UIControlStateNormal];
    [_button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    _button.titleLabel.font = FONT14;
    
    [self.contentView addSubview:_button];
    
    
    [_button addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];


//    _delBtn = [[UIButton alloc]initWithFrame:CGRectMake(_button.right - 10, _button.top-10, 20, 20)];
//    _delBtn.backgroundColor = [UIColor blackColor];
//    _delBtn.layer.masksToBounds = YES;
//    _delBtn.layer.cornerRadius = _delBtn.height/2;
//    [self.contentView addSubview:_delBtn];
//    [_delBtn setTitle:@"-" forState:UIControlStateNormal];
//    
//
//    [_delBtn addTarget:self action:@selector(delBtnAction) forControlEvents:UIControlEventTouchUpInside];
}


- (void)delBtnAction {
    
    if(_delBtnBlock !=  nil){
        _delBtnBlock();
    }
}



- (void)btnAction {
    
    NSLog(@"add");
    
    if(_btnBlock !=  nil){
        _btnBlock();
    }
}





- (void)dataWithModel:(STLabelsModel*)model {
    
    [_button setTitle:model.type_title forState:UIControlStateNormal];
    
    if(model.isSel == YES){
        _button.layer.borderColor = MAINCOLOR.CGColor;
        _button.backgroundColor =  MAINCOLOR;
        _button.selected = YES;
        _delBtn.hidden = YES;
    }
    else {
        
        _button.backgroundColor = [UIColor whiteColor];
        _button.layer.borderColor = GRAY100.CGColor;
        _button.selected = NO;
        _delBtn.hidden = NO;

    }
    
}


@end
