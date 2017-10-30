//
//  Home2TableViewCell.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/14.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "Home2TableViewCell.h"

#import <UIButton+WebCache.h>

#import <UIImageView+WebCache.h>

@interface Home2TableViewCell ()

@property (nonatomic ,strong)UIImageView *imgView;
@property (nonatomic ,strong)UILabel *title;
@property (nonatomic ,strong)UILabel *price;
@property (nonatomic ,strong)UILabel *date;

@property (nonatomic ,strong)UIImageView *imgHot;

@property (nonatomic ,strong)UIButton *btn;

@property (nonatomic ,strong)UILabel *work;
@property (nonatomic ,strong)UILabel *address;

@end

@implementation Home2TableViewCell

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
    
    [self creatView];
    
    return self;
}



- (void)creatView {
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, 90);
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 60, 60)];
    _imgView.clipsToBounds = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_imgView];

//    _imgView.image = [UIImage imageNamed:@"jobs"];
//    _imgView.layer.masksToBounds = YES;
//    _imgView.layer.cornerRadius = 8;
//    _imgView.backgroundColor = RGB(53, 209, 169);
    
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 15, 60, 60)];
//    [btn setImage:[UIImage imageNamed:@"jobs"] forState:UIControlStateNormal];
//    
//    btn.layer.masksToBounds = YES;
//    btn.layer.cornerRadius = btn.height/2;
//    btn.backgroundColor = RGBA(245, 236, 220, 0.5); ;//RGB(243, 156, 18);
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
//    [self.contentView addSubview:btn];
//    btn.userInteractionEnabled = NO;
//    
//    _btn = btn;
    
    
    _imgHot = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 40, 0, 30, 30)];
    _imgHot.image = [UIImage imageNamed:@"hot"];
    [self.contentView addSubview:_imgHot];
    
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(80, 15, SCREEM_WIDTH - 120, 20)];
    _title.font = FONT15;
    _title.textColor = RGB(50, 50, 50);
    [self.contentView addSubview:_title];
    
    _price = [[UILabel alloc]initWithFrame:CGRectMake(80, 55, SCREEM_WIDTH - 100, 20)];
    _price.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_price];
    _price.font = FONT14;
    _price.textColor = RGB(231, 76, 60);
    
    _work = [[UILabel alloc]initWithFrame:CGRectMake(80, 35, 60, 20)];
    _work.textColor = [UIColor whiteColor];
    _work.textAlignment = NSTextAlignmentCenter;
    _work.backgroundColor = RGB(245, 94, 54);
    _work.font = FONT14;
    [self.contentView addSubview:_work];
    
    _address = [[UILabel alloc]initWithFrame:CGRectMake(160, 35, SCREEM_WIDTH - 180, 20)];
    _address.textColor = RGB(100, 100, 100);
    _address.textAlignment = NSTextAlignmentLeft;
//    _address.backgroundColor = [UIColor redColor];
    _address.font = FONT14;
    [self.contentView addSubview:_address];
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(80, 55, SCREEM_WIDTH - 120, 20)];
    
    [self.contentView addSubview:_date];
    _date.font = FONT(13);
    _date.textColor = RGB(150, 150, 150);
    
    
}


- (void)dataWithModel:(ParkTimeModel*)model {
    
    _title.text = model.title;
    _price.text = model.price;
    _date.text = model.date;
    
    CGSize size = [_title.text sizeWithAttributes:@{NSFontAttributeName:_title.font}];
    
    _work.text = model.style;
    _work.frame = CGRectMake(80, 35, 60, 20);
    [_work sizeToFit];
    _work.frame = CGRectMake(80, 35, _work.width, 20);
    
    _address.frame =  CGRectMake(_work.right+10, 35, SCREEM_WIDTH - _work.right - 10, 20);
    _address.text = model.address;
    
    CGFloat y = 85 + size.width;
    
    if(y > (SCREEM_WIDTH - 40)){
        y = SCREEM_WIDTH - 30;
    }
    
    _imgHot.frame = CGRectMake(y, 15, 20, 20);
    
//    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.img_url]];
    
    _imgHot.hidden = ![model.hot boolValue];
    
    AVFile *file = [model.job objectForKey:@"image"];
    
    [file getThumbnail:YES width:400 height:400 withBlock:^(UIImage * _Nullable image, NSError * _Nullable error) {
        
        _imgView.image = image;
    }];
}


@end
