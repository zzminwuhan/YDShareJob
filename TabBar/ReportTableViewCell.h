//
//  ReportTableViewCell.h
//  QKParkTime
//
//  Created by 李加建 on 2017/9/13.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ParkTimeModel.h"

#import "ReportModel.h"

@interface ReportTableViewCell : UITableViewCell

@property (nonatomic ,copy) void (^goBlock1)();
@property (nonatomic ,copy) void (^goBlock2)();

- (void)dataWithModel:(ReportModel*)model ; 

@end
