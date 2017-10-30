//
//  Detail2HeadView.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/19.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "Detail2HeadView.h"


@interface Detail2HeadView ()

@property (nonatomic ,strong)UILabel *label;
@property (nonatomic ,strong)UILabel *price;
@property (nonatomic ,strong)UILabel *mark;

@property (nonatomic ,strong)UILabel *detail;

@property (nonatomic ,strong)UILabel *time;

@property (nonatomic ,strong)UILabel *address;

@property (nonatomic ,strong)UIView *bottomView;

@end


@implementation Detail2HeadView

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
    
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, SCREEM_WIDTH - 40, 30)];
    [_label setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
    [self addSubview:_label];
    
    _price = [[UILabel alloc]initWithFrame:CGRectMake(15, 45, SCREEM_WIDTH - 40, 20)];
    _price.textColor = [UIColor orangeColor];
    _price.font = FONT14;
    [self addSubview:_price];
    
    _mark = [[UILabel alloc]initWithFrame:CGRectMake(15, 65, SCREEM_WIDTH - 40, 20)];
    _mark.textColor = RGB(150, 150, 150);
    _mark.font = FONT12;
    [self addSubview:_mark];
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, SCREEM_WIDTH, 10)];
    line1.backgroundColor = GRAYCOLOR;
    [self addSubview:line1];
    
#pragma mark 职位描述
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 100, SCREEM_WIDTH - 30, 40)];
    label1.text = @"职位描述";
    label1.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [self addSubview:label1];
    
    
    _detail = [[UILabel alloc]initWithFrame:CGRectMake(15, label1.bottom, SCREEM_WIDTH - 30, 20)];
    _detail.font = FONT14;
    _detail.textColor = RGB(50, 50, 50);
    _detail.numberOfLines = 0;
    [self addSubview:_detail];
    
    
    

    [self creatBottomView];
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, _bottomView.bottom);
}



- (void)creatBottomView {
    
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, _detail.bottom, SCREEM_WIDTH, 200)];
    
    [self addSubview:_bottomView];
    
#pragma mark 工作时间
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 10)];
    line2.backgroundColor = GRAYCOLOR;
    [_bottomView addSubview:line2];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(15, line2.bottom, SCREEM_WIDTH - 30, 40)];
    label2.text = @"工作时间";
    label2.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];;
    [_bottomView addSubview:label2];
    
    
    _time = [[UILabel alloc]initWithFrame:CGRectMake(15, label2.bottom, SCREEM_WIDTH - 30, 40)];
    _time.textColor = RGB(0, 0, 0);
    [_bottomView addSubview:_time];
    
    
#pragma mark 工作时间
    
    UILabel *line3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 90, SCREEM_WIDTH, 10)];
    line3.backgroundColor = GRAYCOLOR;
    [_bottomView addSubview:line3];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(15, line3.bottom, SCREEM_WIDTH - 30, 40)];
    label3.text = @"工作地址";
    label3.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];;
    [_bottomView addSubview:label3];
    
    
    UIImageView* mapImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, label3.bottom , SCREEM_WIDTH, 100)];
    mapImage.image = [UIImage imageNamed:@"map_iamge.jpg"];
    [_bottomView addSubview:mapImage];
    
    
    _address = [[UILabel alloc]initWithFrame:CGRectMake(15, label3.bottom, SCREEM_WIDTH - 30, 100)];
    _address.numberOfLines = 0;
    [_bottomView addSubview:_address];
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, label3.bottom , SCREEM_WIDTH, 100)];
    [_bottomView addSubview:btn];
    
    
    
#pragma mark 职位推荐
    
    UILabel *line4 = [[UILabel alloc]initWithFrame:CGRectMake(0, label3.bottom + 100, SCREEM_WIDTH, 10)];
    line4.backgroundColor = GRAYCOLOR;
    [_bottomView addSubview:line4];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(15, line4.bottom, SCREEM_WIDTH - 30, 40)];
    label4.text = @"职位推荐";
    label4.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [_bottomView addSubview:label4];
    
    
    
    _bottomView.frame = CGRectMake(0, 0, SCREEM_WIDTH, label4.bottom);
    
    UILabel *line5 = [[UILabel alloc]initWithFrame:CGRectMake(0, _bottomView.height, SCREEM_WIDTH, 0.5)];
    line5.backgroundColor = GRAY200;
    [_bottomView addSubview:line5];

    [btn addTarget:self action:@selector(tap22Action) forControlEvents:UIControlEventTouchUpInside];
    
}



- (void)tap22Action {
    
    NSLog(@"map");
    
    if(_mapBlock != nil){
        _mapBlock();
    }
}





- (void)dataWithModel:(ParkTimeModel*)model  {
    
    _label.text = model.title;
    
    _price.text = model.price;
    
    _time.text = model.date;
    
    _address.text = model.address;
    
    _mark.text = [NSString stringWithFormat:@"日结 | 其他 | %@",model.nums];
    
    _detail.text = model.detail;
    
    [_detail sizeToFit];
    
    _bottomView.frame = CGRectMake(0, _detail.bottom+10, SCREEM_WIDTH, _bottomView.height);
    
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, _bottomView.bottom);
}


@end
