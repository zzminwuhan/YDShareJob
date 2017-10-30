//
//  ReportTableViewCell.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/13.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "ReportTableViewCell.h"

@interface ReportTableViewCell ()

@property (nonatomic ,strong)UIImageView *imgView;
@property (nonatomic ,strong)UILabel *title;
@property (nonatomic ,strong)UILabel *price;
@property (nonatomic ,strong)UILabel *date;

@property (nonatomic ,strong)UIView *statusView;

@property (nonatomic ,strong)NSMutableArray *btnsArray;

@end

@implementation ReportTableViewCell

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
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 15, 60, 60)];
    _imgView.clipsToBounds = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_imgView];
    //
    //    _imgView.image = [UIImage imageNamed:@"jobs"];
    //    _imgView.layer.masksToBounds = YES;
    //    _imgView.layer.cornerRadius = 8;
    //    _imgView.backgroundColor = RGB(53, 209, 169);
    //
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 15, 60, 60)];
//    [btn setImage:[UIImage imageNamed:@"jobs"] forState:UIControlStateNormal];
//    
//    btn.layer.masksToBounds = YES;
//    btn.layer.cornerRadius = 8;
//    btn.backgroundColor = RGB(53, 209, 169);
//    [btn setImageEdgeInsets:UIEdgeInsetsMake(12, 12, 12, 12)];
//    [self.contentView addSubview:btn];
//    btn.userInteractionEnabled = NO;
    
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(100, 15, SCREEM_WIDTH - 110, 20)];
    _title.font = FONT15;
    _title.textColor = RGB(50, 50, 50);
    [self.contentView addSubview:_title];
    
    _price = [[UILabel alloc]initWithFrame:CGRectMake(100, 35, SCREEM_WIDTH - 110, 20)];
    
    [self.contentView addSubview:_price];
    _price.font = FONT14;
    _price.textColor = RGB(231, 76, 60);
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(100, 55, SCREEM_WIDTH - 110, 20)];
    
    [self.contentView addSubview:_date];
    _date.font = FONT12;
    _date.textColor = RGB(150, 150, 150);
    
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, 180);
    
    [self initStatusView];
}



- (void)initStatusView {
    
    
    _statusView = [[UIView alloc]initWithFrame:CGRectMake(15, 85, SCREEM_WIDTH - 30, 80)];
    
    [self.contentView addSubview:_statusView];
    
    NSArray *array = @[@"已申请",@"简历被查看",@"已录用",@"已完成"];
    _btnsArray = [NSMutableArray array];
    
    for(int i=0;i<array.count;i++){
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 20*i, _statusView.width, 20)];
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn setTitleColor:RGB(50, 50, 50) forState:UIControlStateNormal];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 5, 0, 0)];
        btn.titleLabel.font = FONT14;
        [btn setImage:[UIImage imageNamed:@"mark_n"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"mark_s"] forState:UIControlStateSelected];
        [_statusView addSubview:btn];
        btn.userInteractionEnabled = NO;
        
        [_btnsArray addObject:btn];
    }
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(_statusView.width - 90, 45, 90, 30)];
    [btn setTitle:@"取消申请" forState:UIControlStateNormal];
    [btn setTitleColor:RGB(52, 152, 219) forState:UIControlStateNormal];
    [btn setTitleColor:RGB(200, 200, 200) forState:UIControlStateSelected];
    btn.titleLabel.font = FONT15;

    [_statusView addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(_statusView.width - 90, 5, 100, 30)];
    [btn1 setTitle:@"举报" forState:UIControlStateNormal];
    [btn1 setTitleColor:RGB(52, 152, 219) forState:UIControlStateNormal];

    [_statusView addSubview:btn1];
    btn1.titleLabel.font = FONT15;
    
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [btn1 addTarget:self action:@selector(btn1Action) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnAction {
    
    if(_goBlock1 != nil){
        _goBlock1();
    }
}

- (void)btn1Action {
    
    if(_goBlock2 != nil){
        _goBlock2();
    }
}



- (void)dataWithModel:(ReportModel*)model {
    
    _title.text = model.jobModel.title;
    _price.text = model.jobModel.price;
    _date.text = model.jobModel.date;
    
    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.jobModel.img_url]];
    
    NSInteger tag = [model.status integerValue];
    
    for(int i=0;i<_btnsArray.count;i++){
        
        UIButton *btn = _btnsArray[i];
        
        if(i<=tag){
            btn.selected = YES;
        }
        else {
            btn.selected = NO;
        }
    }
}



@end
