//
//  Detail1_2HeadView.m
//  YDShareJob
//
//  Created by 李加建 on 2017/10/23.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "Detail1_2HeadView.h"


@interface Detail1_2HeadView ()

@property (nonatomic ,strong)UILabel *label;
@property (nonatomic ,strong)UILabel *price;
@property (nonatomic ,strong)UILabel *number;
@property (nonatomic ,strong)UILabel *mark;

@property (nonatomic ,strong)UILabel *detail;

@property (nonatomic ,strong)UILabel *time;

@property (nonatomic ,strong)UILabel *address;

@property (nonatomic ,strong)UIView *topView;
@property (nonatomic ,strong)UIView *bottomView;

@property (nonatomic ,strong)UIButton *addressBtn;

@end

@implementation Detail1_2HeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
//    self.backgroundColor = [UIColor whiteColor];
    
    [self creatView];
    
    return self;
}



- (void)creatView {
    
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, SCREEM_WIDTH - 30, 20)];
    _label.numberOfLines = 0;
    _label.lineBreakMode = NSLineBreakByCharWrapping;
    
    [self addSubview:_label];
    
    
    _topView = [[UIView alloc]initWithFrame:CGRectMake(15, 50, SCREEM_WIDTH -30, 120)];
    _topView.layer.borderWidth = 0.5;
    _topView.layer.borderColor = RGB(200, 200, 200).CGColor;
    _topView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_topView];
    
    
    _price = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, SCREEM_WIDTH - 60, 30)];
    
    _price.font = FONT14;
    [_topView addSubview:_price];
    
    _time = [[UILabel alloc]initWithFrame:CGRectMake(15, _price.bottom, SCREEM_WIDTH - 60, 30)];
    _time.textColor = GRAY50;
    _time.font = FONT14;
    [_topView addSubview:_time];
    
    _address = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, SCREEM_WIDTH - 60, 30)];
    _address.textColor = GRAY50;
    _address.font = FONT14;
    [_topView addSubview:_address];
    
    _number = [[UILabel alloc]initWithFrame:CGRectMake(15, _time.bottom, SCREEM_WIDTH - 60, 30)];
    _number.textColor = GRAY50;
    _number.font = FONT14;
    [_topView addSubview:_number];
    
    _mark = [[UILabel alloc]initWithFrame:CGRectMake(15, _number.bottom, SCREEM_WIDTH - 60, 30)];
    _mark.textColor = GRAY50;
    _mark.font = FONT14;
    [_topView addSubview:_mark];
    
    
    _addressBtn = [[UIButton alloc]initWithFrame:CGRectMake(15, _topView.bottom +15, SCREEM_WIDTH - 30, 40)];
    _addressBtn.layer.borderWidth = 0.5;
    _addressBtn.layer.borderColor = RGB(200, 200, 200).CGColor;
    _addressBtn.backgroundColor = [UIColor whiteColor];
    [self addSubview:_addressBtn];
    
    [_addressBtn addSubview:_address];
    
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(15, _addressBtn.bottom +15, SCREEM_WIDTH - 30, 40)];
    _bottomView.layer.borderWidth = 0.5;
    _bottomView.layer.borderColor = RGB(200, 200, 200).CGColor;
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_bottomView];
    
    
    _detail = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, SCREEM_WIDTH - 60, 20)];
    _detail.numberOfLines = 0;
    _detail.font = FONT(13);
    [_bottomView addSubview:_detail];
    
    
    [_addressBtn addTarget:self action:@selector(tap22Action) forControlEvents:UIControlEventTouchUpInside];
}


- (void)tap22Action {
    
    NSLog(@"map");
    
    if(_mapBlock != nil){
        _mapBlock();
    }
}


- (void)dataWithModel:(ParkTimeModel*)model  {
    
    _label.text = model.title;
    _label.frame = CGRectMake(15, 15, SCREEM_WIDTH - 30, 20);
    [_label sizeToFit];
    
    _topView.frame = CGRectMake(15, _label.bottom + 15, SCREEM_WIDTH -30, 120);
    
    _price.attributedText = [self show2Title:@"薪资\t " text:model.price]; //[NSString stringWithFormat:@"薪资\t %@",model.price];
    
    _time.text = [NSString stringWithFormat:@"日期\t %@",model.date];
    
    _address.text = [NSString stringWithFormat:@"地址\t %@",model.address];
    
    _number.text = [NSString stringWithFormat:@"人数\t %@",model.nums];
    
    _mark.text = [NSString stringWithFormat:@"其他 | %@",model.style];
    
    
    _addressBtn.frame = CGRectMake(15, _topView.bottom +15, SCREEM_WIDTH - 30, 40);
    
    _detail.frame = CGRectMake(15, 15, SCREEM_WIDTH - 60, 20);
    _detail.text = model.detail;
    
    [_detail sizeToFit];
    
    _bottomView.frame = CGRectMake(15, _addressBtn.bottom+15, SCREEM_WIDTH - 30, _detail.bottom +15);
    
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, _bottomView.bottom);
}



- (NSAttributedString *)show2Title:(NSString *)title text:(NSString*)text {
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:GRAY50,NSFontAttributeName:FONT14};
    
    NSDictionary *attributes2 = @{NSForegroundColorAttributeName:[UIColor redColor],NSFontAttributeName:FONT14};
    
    NSAttributedString * attri1 =[[NSAttributedString alloc]initWithString:title attributes:attributes];
    
    NSAttributedString * attri2 =[[NSAttributedString alloc]initWithString:text attributes:attributes2];
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] init];
    
    [attriString appendAttributedString:attri1];
    [attriString appendAttributedString:attri2];
    
    return attriString ;
    
}


@end
