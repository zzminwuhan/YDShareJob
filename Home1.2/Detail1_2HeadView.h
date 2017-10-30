//
//  Detail1_2HeadView.h
//  YDShareJob
//
//  Created by 李加建 on 2017/10/23.
//  Copyright © 2017年 jack. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ParkTimeModel.h"

@interface Detail1_2HeadView : UIView

@property (nonatomic ,copy)void (^mapBlock)();

- (void)dataWithModel:(ParkTimeModel*)model ;

@end
