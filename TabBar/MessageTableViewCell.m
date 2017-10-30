//
//  MessageTableViewCell.m
//  YDShareJob
//
//  Created by 李加建 on 2017/10/18.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "MessageTableViewCell.h"


@interface MessageTableViewCell ()

@property (nonatomic ,strong)UILabel *title;
@property (nonatomic ,strong)UILabel *deltal;
@property (nonatomic ,strong)UILabel *date;

@property (nonatomic ,strong)UIImageView *imgView;

@end


@implementation MessageTableViewCell

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
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 40, 40)];
    
    _imgView.image = [UIImage imageNamed:@"message"];
    [self.contentView addSubview:_imgView];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, SCREEM_WIDTH - 80, 20)];
    _title.numberOfLines = 0;
    _title.font = FONT15;
    _deltal.textColor = RGB(50, 50, 50);
    [self.contentView addSubview:_title];
    
    
    _deltal = [[UILabel alloc]initWithFrame:CGRectMake(60, 30, SCREEM_WIDTH - 80, 20)];
    _deltal.numberOfLines = 0;
    _deltal.font = FONT14;
    _deltal.textColor = RGB(150, 150, 150);
    [self.contentView addSubview:_deltal];
    
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(60, 10, SCREEM_WIDTH - 80, 20)];
    _date.font = FONT14;
    _date.textColor = RGB(150, 150, 150);
    _date.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_date];
}



- (void)datdaWithModel:(MessageModel *)model {
    
    
    _title.frame = CGRectMake(60, 10, SCREEM_WIDTH - 80, 20);
    _title.text = model.title;
    [_title sizeToFit];
    
    _deltal.frame = CGRectMake(60, 30, SCREEM_WIDTH - 80, 20);
    _deltal.text = model.detail;
    [_deltal sizeToFit];
    
    _date.text = model.date;
    
    
    if(_deltal.bottom <= 50){
        _deltal.frame = CGRectMake(60, 30, SCREEM_WIDTH - 80, 20);
    }
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH , _deltal.bottom + 10);
    
}


@end
