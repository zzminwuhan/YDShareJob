//
//  DetailHeadView.h
//  QKParkTime
//
//  Created by 李加建 on 2017/9/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ParkTimeModel.h"

@interface DetailHeadView : UIView

@property (nonatomic ,copy)void (^mapBlock)();

- (void)dataWithModel:(ParkTimeModel*)model;

@end
