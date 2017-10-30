//
//  Home1_2CollectionViewCell.m
//  YDShareJob
//
//  Created by 李加建 on 2017/10/23.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "Home1_2CollectionViewCell.h"


@interface Home1_2CollectionViewCell ()

@property (nonatomic ,strong)UIImageView *imgView;
@property (nonatomic ,strong)UILabel *title;
@property (nonatomic ,strong)UILabel *price;
@property (nonatomic ,strong)UILabel *date;

@end


@implementation Home1_2CollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
//    self.layer.borderWidth = 1;
//    self.layer.borderColor = RGB(200, 200, 200).CGColor;
    self.backgroundColor = [UIColor whiteColor];
    
    [self creatView];
    
    
    return self;
    
}



- (void)creatView {
    
    _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.width)];
    
    _imgView.clipsToBounds = YES;
    _imgView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_imgView];
    
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(5, self.width, self.width - 10, 20)];
    _title.font = FONT15;
    _title.numberOfLines = 2;
    _title.textColor = RGB(50, 50, 50);
    [self.contentView addSubview:_title];
    
    _price = [[UILabel alloc]initWithFrame:CGRectMake(5, self.width+40, self.width - 10, 20)];
    _price.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_price];
    _price.font = FONT14;
    _price.textColor = RGB(231, 76, 60);
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(5, self.width + 40, self.width - 10, 20)];
    
    [self.contentView addSubview:_date];
    _date.font = FONT(13);
    _date.textColor = RGB(150, 150, 150);
    _date.textAlignment = NSTextAlignmentRight;
    
}


- (void)dataWithModel:(ParkTimeModel*)model {
    
    _title.text = model.title;
    _price.text = model.price;
    _date.text = model.style;
    
    _title.frame = CGRectMake(5, self.width, self.width - 10, 20);
    [_title sizeToFit];
    
//    [_imgView sd_setImageWithURL:[NSURL URLWithString:model.img_url]];
    
    
    AVFile *file = [model.job objectForKey:@"image"];

    
    [file getThumbnail:YES width:400 height:400 withBlock:^(UIImage * _Nullable image, NSError * _Nullable error) {
        
        _imgView.image = image;
    }];

}



@end
