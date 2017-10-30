//
//  WalletTableViewCell.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/14.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "WalletTableViewCell.h"


@interface WalletTableViewCell ()

@property (nonatomic ,strong)UILabel *label1;
@property (nonatomic ,strong)UILabel *label2;
@property (nonatomic ,strong)UILabel *label3;

@end

@implementation WalletTableViewCell

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
    

    _label1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREEM_WIDTH - 30, 20)];
    [self.contentView addSubview:_label1];
    _label1.font = FONT14;
    _label1.textColor = RGB(50, 50, 50);
    
    _label2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 30, SCREEM_WIDTH - 30, 20)];
    _label2.textColor = RGB(150, 150, 150);
    _label2.font = FONT14;
    [self.contentView addSubview:_label2];
    
    _label3 = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, SCREEM_WIDTH - 30, 40)];
    _label3.textAlignment = NSTextAlignmentRight;
    _label3.font = [UIFont fontWithName:@"Helvetica" size:25];
    _label3.textColor = RGB(231, 76, 60);
    [self.contentView addSubview:_label3];
    
}


- (void)dataWithModel:(RewardPoints*)model {
    
    
    _label1.text = model.text;
    _label2.text = model.date;
    
    _label3.text = [NSString stringWithFormat:@"+%@",model.value];
    
}


@end
