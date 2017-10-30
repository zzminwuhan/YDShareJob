//
//  JobDetailHeadView.m
//  YDShareJob
//
//  Created by 李加建 on 2017/10/17.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "JobDetailHeadView.h"

@interface JobDetailHeadView ()

@property (nonatomic ,strong)UILabel *title;
@property (nonatomic ,strong)UILabel *price;

@property (nonatomic ,strong)UILabel *date;

@property (nonatomic ,strong)UIButton *btn1;
@property (nonatomic ,strong)UIButton *btn2;
@property (nonatomic ,strong)UIButton *btn3;

@property (nonatomic ,strong)UILabel *typeLbl;
@property (nonatomic ,strong)UILabel *bmnumLbl;


@property (nonatomic ,strong)UITextView * textView ;

@property (nonatomic ,strong)UIView * bottomView ;

@property (nonatomic ,strong)UILabel *lblAddress;
@property (nonatomic ,strong)UILabel *lblName;
@property (nonatomic ,strong)UILabel *lblPhone;

@property (nonatomic ,strong)UIButton *joinBtn;

@property (nonatomic ,strong)UIImageView *mapImage;

@property (nonatomic ,strong)UILabel *label;


@end

@implementation JobDetailHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/





- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self creatView];
    [self creatBodyView];
    
    //    rgb(26, 188, 156)  #1ABC9C
    
    return self;
}




- (void)creatView {
    
    UILabel *line1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREEM_WIDTH, 10)];
    line1.backgroundColor = GRAYCOLOR;
    [self addSubview:line1];
    
    _title = [[UILabel alloc]initWithFrame:CGRectMake(15, line1.bottom+10, SCREEM_WIDTH - 110, 35)];
    _title.numberOfLines = 2;
    _title.font = FONT15;
    _title.textColor = [UIColor blackColor];
    [self addSubview:_title];
    
    
    _price = [[UILabel alloc]initWithFrame:CGRectMake(SCREEM_WIDTH - 90, line1.bottom+10, 90, 35)];
    _price.font = FONT14;
    _price.textColor = [UIColor whiteColor];
    _price.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_price];
    _price.backgroundColor = RGB(255, 121, 21);
    
    CGFloat cc = _price.height /2;
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_price.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerBottomLeft cornerRadii:CGSizeMake(cc, cc)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    maskLayer.frame =_price.bounds;
    maskLayer.path = maskPath.CGPath;
    _price.layer.mask = maskLayer;
    
    
    //    UIButton * tipBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, _price.bottom, SCREEM_WIDTH, 40)];
    //
    //    [self addSubview:tipBtn];
    //    tipBtn.userInteractionEnabled = NO;
    //
    //    [tipBtn setImage:[UIImage imageNamed:@"btn_baozhang"] forState:UIControlStateNormal];
    //    [tipBtn setTitle:@"工资已预付到学生港平台，结算有保障！" forState:UIControlStateNormal];
    //    tipBtn.titleLabel.font = FONT12;
    //    [tipBtn setTitleColor:RGB(170, 170, 170) forState:UIControlStateNormal];
    //    [tipBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    //    [tipBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    //    tipBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    
    
    CGFloat www = (SCREEM_WIDTH *0.9)/3;
    
    _btn1 = [[UIButton alloc]initWithFrame:CGRectMake(0, _price.bottom, www+20, 40)];
    _btn1.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    [_btn1 setImage:[UIImage imageNamed:@"youzhi"] forState:UIControlStateNormal];
    _btn1.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self setBtnType:_btn1];
    
    [_btn1 setTitleColor:RGB(230, 126, 34) forState:UIControlStateNormal];
    [_btn1 setTitle:@"优质岗位" forState:UIControlStateNormal];
    _btn1.titleLabel.font = FONT14;
    
    _btn2 = [[UIButton alloc]initWithFrame:CGRectMake(www, _price.bottom, www+20, 40)];
    [_btn2 setImage:[UIImage imageNamed:@"baozhang"] forState:UIControlStateNormal];
    _btn2.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft ;
    
    [self setBtnType:_btn2];
    
    [_btn2 setTitleColor:RGB(26, 188, 156) forState:UIControlStateNormal];
    [_btn2 setTitle:@"工资保障" forState:UIControlStateNormal];
    _btn2.titleLabel.font = FONT14;
    
    _btn3 = [[UIButton alloc]initWithFrame:CGRectMake(www*2, _price.bottom, www, 40)];
    [_btn3 setImage:[UIImage imageNamed:@"task_viewnum"] forState:UIControlStateNormal];
    _btn3.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter ;
    
    [self setBtnType:_btn3];
    
    
    
    _date = [[UILabel alloc]initWithFrame:CGRectMake(15, _btn3.bottom, SCREEM_WIDTH - 15, 25)];
    _date.textColor = RGB(150, 150, 150);
    _date.font = FONT14;
    [self addSubview:_date];
    
    UILabel *line2 = [[UILabel alloc]initWithFrame:CGRectMake(0, _btn3.bottom + 30, SCREEM_WIDTH, 0.5)];
    line2.backgroundColor = GRAYCOLOR;
    [self addSubview:line2];
    
    
    _mapImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, _date.bottom + 50, SCREEM_WIDTH, 60)];
    
    _mapImage.image = [UIImage imageNamed:@"map_iamge.jpg"];
    
    [self addSubview:_mapImage];
    
    
    _lblAddress = [[UILabel alloc]initWithFrame:CGRectMake(15, _date.bottom + 60, SCREEM_WIDTH - 30, 40)];
    
    [self addSubview:_lblAddress];
    
    
    UIButton *btn = [[UIButton alloc]initWithFrame:_mapImage.frame];
    
    [self addSubview:btn];
    
    //    btn.backgroundColor = [UIColor redColor];
    
    [btn addTarget:self action:@selector(tap22Action) forControlEvents:UIControlEventTouchUpInside];
    
}



- (void)tap22Action {
    
    NSLog(@"map");
    
//    if(_mapBlock != nil){
//        _mapBlock();
//    }
}


- (void)setBtnType:(UIButton*)btn {
    
    [self addSubview:btn];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 15, 0, 0)];
    btn.userInteractionEnabled = NO;
    [btn setTitleColor:RGB(150, 150, 150) forState:UIControlStateNormal];
    btn.titleLabel.font = FONT14;
    
}


#pragma mark - 高度变化
- (void)creatBodyView {
    
    _typeLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 0+10, SCREEM_WIDTH - 30, 40)];
    
    [self addSubview:_typeLbl];
    
    _bmnumLbl = [[UILabel alloc]initWithFrame:CGRectMake(15, 0+10, SCREEM_WIDTH - 30,40)];
    _bmnumLbl.textAlignment = NSTextAlignmentRight;
    [self addSubview:_bmnumLbl];
    
    
    _textView = [[UITextView alloc]initWithFrame:CGRectMake(0, _mapImage.bottom, SCREEM_WIDTH, 40)];
    _textView.editable = NO;
    [self addSubview:_textView];
    
    
    _label = [[UILabel alloc]initWithFrame:CGRectMake(15, _textView.bottom , SCREEM_WIDTH - 30, 20)];
    

    
}






- (void)dataWithModel:(JobDefaultModel*)model {
    
#pragma mark 标题 价格
    _title.text = model.title;
    _price.text = model.price;
    
    
#pragma mark 兼职类型  招聘人数 工作内容
    _typeLbl.frame = CGRectMake(15, _date.bottom+10, SCREEM_WIDTH - 30,40);
    _bmnumLbl.frame = CGRectMake(15, _date.bottom+10, SCREEM_WIDTH - 30,40);
    
    //    NSString *bmren = [NSString stringWithFormat:@"%@人",model.renshu];
    _typeLbl.attributedText = [self show2Title:@"兼职类型：" text:model.style];
    _bmnumLbl.attributedText = [self show2Title:@"招聘人数：" text:model.nums];
    
    _date.attributedText = [self show2Title:@"兼职时间：" text:model.date];
    
    
    _textView.frame = CGRectMake(0, _mapImage.bottom, SCREEM_WIDTH, 20);
    _textView.attributedText = [self showTitle:@"工作描述：" Content:model.detail];
    [_textView sizeToFit];
    _textView.frame = CGRectMake(0, _mapImage.bottom, SCREEM_WIDTH, _textView.height + 5);
    
#pragma mark 详细地址  联系人 联系电话
    
    _bottomView.frame = CGRectMake(0, _textView.bottom, SCREEM_WIDTH, _bottomView.height);
    
    _lblAddress.attributedText = [self show2Title:@"详细地址：" text:model.address];
    //    _lblName.attributedText = [self show2Title:@"联系人：" text:@"1313"];
    //    _lblPhone.attributedText = [self show2Title:@"联系电话：" text:@"1313"];
    
    
    _label.frame = CGRectMake(15, _textView.bottom, SCREEM_WIDTH - 30, 20);
    
    self.frame = CGRectMake(0, 0, SCREEM_WIDTH, _textView.bottom  + 30);
    
    NSString *joinstr = [NSString stringWithFormat:@"%@人",@"13"];
    [_joinBtn setTitle:joinstr forState:UIControlStateNormal];
    
    UIButton *btn = _joinBtn ;
    
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, -btn.imageView.frame.size.width, 0, btn.imageView.frame.size.width)];
    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, btn.titleLabel.bounds.size.width, 0, -btn.titleLabel.bounds.size.width)];
    
    
}


- (NSAttributedString *)show2Title:(NSString *)title text:(NSString*)text {
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:GRAY100,NSFontAttributeName:FONT14};
    
    NSDictionary *attributes2 = @{NSForegroundColorAttributeName:GRAY50,NSFontAttributeName:FONT14};
    
    NSAttributedString * attri1 =[[NSAttributedString alloc]initWithString:title attributes:attributes];
    
    NSAttributedString * attri2 =[[NSAttributedString alloc]initWithString:text attributes:attributes2];
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] init];
    
    [attriString appendAttributedString:attri1];
    [attriString appendAttributedString:attri2];
    
    return attriString ;
    
}


- (NSAttributedString*)showTitle:(NSString *)title Content:(NSString*)content {
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 5;// 字体的行间距
    paragraphStyle.firstLineHeadIndent = 20.f;//首行缩进
    paragraphStyle.alignment = NSTextAlignmentJustified;//（两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;//结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
    paragraphStyle.headIndent = 10;//整体缩进(首行除外)
    paragraphStyle.tailIndent = SCREEM_WIDTH - 20;//
    
    NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle2.lineSpacing = 5;// 字体的行间距
    paragraphStyle2.firstLineHeadIndent = 10.f;//首行缩进
    paragraphStyle2.alignment = NSTextAlignmentJustified;//（两端对齐的）文本对齐方式：（左，中，右，两端对齐，自然）
    paragraphStyle2.lineBreakMode = NSLineBreakByCharWrapping;//结尾部分的内容以……方式省略 ( "...wxyz" ,"abcd..." ,"ab...yz")
    paragraphStyle2.headIndent = 10;//整体缩进(首行除外)
    paragraphStyle2.tailIndent = SCREEM_WIDTH - 15;//
    
    NSDictionary *attributes = @{NSForegroundColorAttributeName:GRAY100,NSFontAttributeName:FONT14,NSParagraphStyleAttributeName:paragraphStyle};
    
    NSDictionary *attributes2 = @{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName:FONT14,NSParagraphStyleAttributeName:paragraphStyle2};
    
    NSString *attstr = [NSString stringWithFormat:@"%@\n%@",title,content];
    
    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:attstr];
    
    
    [attriString setAttributes:attributes range:NSMakeRange(0, attriString.length)];
    [attriString setAttributes:attributes2 range:NSMakeRange(0, title.length)];
    
    
    return attriString ;
    
}



@end
