//
//  FootBar.h
//  QKParkTime
//
//  Created by 李加建 on 2017/9/12.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FootBar : UIView

@property (nonatomic,strong)UIButton *collectBtn;
@property (nonatomic,strong)UIButton *reportBtn;

@property (nonatomic ,copy)void (^goBlock1)(); //收藏
@property (nonatomic ,copy)void (^goBlock2)(); //报名
@property (nonatomic ,copy)void (^goBlock3)(); //取消收藏


- (void)setReportBtnSel:(BOOL)isSel ;

@end
