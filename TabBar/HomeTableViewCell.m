//
//  HomeTableViewCell.m
//  YDShareJob
//
//  Created by 李加建 on 2017/10/19.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HomeTableViewCell.h"


#import <UIImageView+WebCache.h>

@interface HomeTableViewCell ()

@property (nonatomic ,strong)UIImageView *imgView;
@property (nonatomic ,strong)UILabel *title;
@property (nonatomic ,strong)UILabel *price;
@property (nonatomic ,strong)UILabel *date;


@property (nonatomic ,strong)UIButton *btn;

@property (nonatomic ,strong)UILabel *work;
@property (nonatomic ,strong)UILabel *work2;
@property (nonatomic ,strong)UILabel *address;

@property (nonatomic ,strong)UIView* bottomView;


@end

@implementation HomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.selectionStyle = NO;
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_HEIGHT);
    
    [self creatView];
    
    return self;
}



- (void)creatView {
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, SCREEM_WIDTH*(2/3.f))];
    _imgView.clipsToBounds = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_imgView];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(15, _imgView.bottom+10, SCREEM_WIDTH - 30, 20)];
    _title.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    _title.textColor = RGB(50, 50, 50);
    [self.contentView addSubview:_title];

    
    
    _price = [[UILabel alloc]initWithFrame:CGRectMake(15, _title.bottom+10, SCREEM_WIDTH - 30, 20)];
    _price.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_price];
    _price.font = FONT18;
    _price.textColor = RGB(231, 76, 60);
    

    
    
    UILabel *line = [[UILabel alloc]initWithFrame:CGRectMake(0, _price.bottom +10, SCREEM_WIDTH, 5)];
    line.backgroundColor = RGB(240, 240, 240);
    [self.contentView addSubview:line];
    
    CGFloat www = 90;
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(15, line.bottom, www, 40)];
    btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    [btn1 setImage:[UIImage imageNamed:@"youzhi"] forState:UIControlStateNormal];
    btn1.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self setBtnType:btn1];
    
    [btn1 setTitleColor:RGB(230, 126, 34) forState:UIControlStateNormal];
    [btn1 setTitle:@"优质岗位" forState:UIControlStateNormal];
    btn1.titleLabel.font = FONT14;
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(www+15, line.bottom, www, 40)];
    [btn2 setImage:[UIImage imageNamed:@"baozhang"] forState:UIControlStateNormal];
    btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    
    [self setBtnType:btn2];
    
    btn2.titleLabel.font = FONT14;
    
    [btn2 setTitleColor:RGB(26, 188, 156) forState:UIControlStateNormal];
    [btn2 setTitle:@"工资保障" forState:UIControlStateNormal];
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(15, line.bottom+50+40, SCREEM_WIDTH - 30, 20)];
    [self.contentView addSubview:_date];
    _date.textAlignment = NSTextAlignmentLeft;
    _date.font = FONT(13);
    _date.textColor = RGB(150, 150, 150);
    
    
    _work = [[UILabel alloc]initWithFrame:CGRectMake(15, line.bottom+10+40, SCREEM_WIDTH - 30, 20)];
    [self.contentView addSubview:_work];
    _work.textAlignment = NSTextAlignmentLeft;
    _work.font = FONT(13);
    _work.textColor = RGB(150, 150, 150);
    
    _work2 = [[UILabel alloc]initWithFrame:CGRectMake(15, line.bottom+30+40, SCREEM_WIDTH - 30, 20)];
    [self.contentView addSubview:_work2];
    _work2.textAlignment = NSTextAlignmentLeft;
    _work2.font = FONT(13);
    _work2.textColor = RGB(150, 150, 150);
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, _date.bottom +10, SCREEM_WIDTH, 5)];
    line2.backgroundColor = RGB(240, 240, 240);
    [self.contentView addSubview:line2];
    
    _address = [[UILabel alloc]initWithFrame:CGRectMake(15, line2.bottom+10, SCREEM_WIDTH - 30, 20)];
    [self.contentView addSubview:_address];
    _address.textAlignment = NSTextAlignmentLeft;
    _address.font = FONT(13);
    _address.textColor = RGB(150, 150, 150);
    
 
    [self initBottomView];
}


- (void)setBtnType:(UIButton*)btn {
    
    [self.contentView addSubview:btn];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 3, 0, 0)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -3)];
    btn.userInteractionEnabled = NO;
    [btn setTitleColor:RGB(150, 150, 150) forState:UIControlStateNormal];
    btn.titleLabel.font = FONT14;
    
}




- (void)initBottomView {
    
    _bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEM_HEIGHT - 50, SCREEM_WIDTH, 50)];
    _bottomView.backgroundColor = RGB(240, 240, 240);
    
    [self.contentView addSubview:_bottomView];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(15, 7, (self.width - 45)*0.6, 36)];
    
    [btn setTitle:@"马上加入" forState:UIControlStateNormal];
    //    [btn2 setTitle:@"已加入" forState:UIControlStateSelected];
    //    [btn2 setTitle:@"" forState:UIControlStateHighlighted];
    btn.layer.cornerRadius = 2;
    btn.layer.masksToBounds = YES;
    btn.titleLabel.font = FONT14;
    
    //    [btn2 setTitleColor:RGB(200, 200, 200) forState:UIControlStateSelected];
    [btn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
    
    btn.backgroundColor = RGB(52, 152, 219);
    [_bottomView addSubview:btn];
    
    
//    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(15, 7, 70, 36)];
//    
//    btn1.layer.masksToBounds = YES;
//    btn1.layer.cornerRadius = 2;
//    btn1.layer.borderWidth = 1;
//    btn1.layer.borderColor = RGB(52, 152, 219).CGColor;
//    [btn1 setTitleColor:RGB(52, 152, 219) forState:UIControlStateNormal];
//    [btn1 setTitle:@"分享" forState:UIControlStateNormal];
//    btn1.titleLabel.font = FONT12;
//    [_bottomView addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake((self.width - 45)*0.6+30, 7, (self.width - 45)*0.4, 36)];
    
    btn2.layer.masksToBounds = YES;
    btn2.layer.cornerRadius = 2;
    btn2.layer.borderWidth = 1;
    btn2.layer.borderColor = RGB(52, 152, 219).CGColor;
    [btn2 setTitleColor:RGB(52, 152, 219) forState:UIControlStateNormal];
    [btn2 setTitle:@"查看详情" forState:UIControlStateNormal];
    btn2.titleLabel.font = FONT12;
    [_bottomView addSubview:btn2];
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [btn2 addTarget:self action:@selector(btn2Action) forControlEvents:UIControlEventTouchUpInside];
}


- (void)btnAction {
    
    if(_goBlock != nil){
        _goBlock();
    }
}

- (void)btn2Action {
    
    if(_goBlock2 != nil){
        _goBlock2();
    }
}


- (void)dataWithModel:(ParkTimeModel*)model  {
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.img_url] placeholderImage:[UIImage imageNamed:@"image_default"]];
    
    _title.text = model.title;
    _price.text = model.price;
    _work.text = [NSString stringWithFormat:@"工作方式：%@",model.style];
    _work2.text = [NSString stringWithFormat:@"招聘人数：%@",model.nums];
    _date.text = [NSString stringWithFormat:@"工作时间：%@",model.date];
    
    _address.text = [NSString stringWithFormat:@"详情地址：%@",model.address];
}

@end
