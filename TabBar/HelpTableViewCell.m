//
//  HelpTableViewCell.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/13.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HelpTableViewCell.h"

@interface HelpTableViewCell ()

@property (nonatomic ,strong)UILabel *title;
@property (nonatomic ,strong)UILabel *deltal;

@end

@implementation HelpTableViewCell

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
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, 60);
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREEM_WIDTH - 30, 20)];
    _title.numberOfLines = 0;
    _title.font = FONT15;
    _deltal.textColor = RGB(50, 50, 50);
    [self.contentView addSubview:_title];
    
    
    _deltal = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, SCREEM_WIDTH - 30, 20)];
    _deltal.numberOfLines = 0;
    _deltal.font = FONT14;
    _deltal.textColor = RGB(150, 150, 150);
    [self.contentView addSubview:_deltal];
}



- (void)datdaWithModel:(MessageModel*)model {
    
    
    _title.frame = CGRectMake(15, 10, SCREEM_WIDTH - 30, 20);
    _title.text = model.title;
    [_title sizeToFit];
    
    
    _deltal.frame = CGRectMake(15, _title.bottom+10, SCREEM_WIDTH - 30, 20);
    _deltal.text = model.detail;
    [_deltal sizeToFit];
    
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH , _deltal.bottom + 15);
    
}

@end
