//
//  HomeTableViewCell.h
//  YDShareJob
//
//  Created by 李加建 on 2017/10/19.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ParkTimeModel.h"

@interface HomeTableViewCell : UITableViewCell

@property (nonatomic ,strong)ActionBlock goBlock;
@property (nonatomic ,strong)ActionBlock goBlock2;

- (void)dataWithModel:(ParkTimeModel*)model ;

@end
