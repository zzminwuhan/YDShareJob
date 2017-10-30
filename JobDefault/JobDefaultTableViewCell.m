//
//  JobDefaultTableViewCell.m
//  YDShareJob
//
//  Created by 李加建 on 2017/10/17.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "JobDefaultTableViewCell.h"

#import <UIImageView+WebCache.h>

@interface JobDefaultTableViewCell ()

@property (nonatomic ,strong)UIImageView *imgView;
@property (nonatomic ,strong)UILabel *title;
@property (nonatomic ,strong)UILabel *price;
@property (nonatomic ,strong)UILabel *date;

@property (nonatomic ,strong)UIImageView *imgHot;

@property (nonatomic ,strong)UIButton *btn;


@end

@implementation JobDefaultTableViewCell

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
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, 80);
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 60, 60)];

    [self.contentView addSubview:_imgView];

    _imgView.image = [UIImage imageNamed:@"jobs"];
    _imgView.layer.masksToBounds = YES;
//    _imgView.layer.cornerRadius = _imgView.height/2;
//    _imgView.clipsToBounds = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    _imgView.backgroundColor = [UIColor clearColor];//RGB(240, 240, 240);
    
    _imgHot = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 40, 0, 30, 30)];
    _imgHot.image = [UIImage imageNamed:@"hot"];
    [self.contentView addSubview:_imgHot];
    
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(90, 15, SCREEM_WIDTH - 110, 20)];
    _title.font = FONT15;
    _title.textColor = RGB(50, 50, 50);
    [self.contentView addSubview:_title];
    
    _price = [[UILabel alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 110, 45, 100, 20)];
    _price.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_price];
    _price.font = FONT14;
    _price.textColor = [UIColor redColor];
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(90, 45, SCREEM_WIDTH - 110, 20)];
    
    [self.contentView addSubview:_date];
    _date.font = FONT12;
    _date.textColor = RGB(150, 150, 150);
    
    
}





- (void)dataWithModel:(JobDefaultModel*)model {
    
    _title.text = model.title;
    _price.text = model.price;
    _date.text = model.date;
    
    CGSize size = [_title.text sizeWithAttributes:@{NSFontAttributeName:_title.font}];
    
    _imgHot.frame = CGRectMake(100 + size.width, 15, 20, 20);
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.img_url] placeholderImage:[UIImage imageNamed:@""]];
    
    _imgHot.hidden = ![model.hot boolValue];
}

@end
