//
//  STLabelsCollectionViewCell.h
//  DongJie
//
//  Created by yuyue on 2017/8/11.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "STLabelsModel.h"

@interface STLabelsCollectionViewCell : UICollectionViewCell

@property (nonatomic ,copy)ActionBlock btnBlock ;

@property (nonatomic ,copy)ActionBlock delBtnBlock ;

- (void)dataWithModel:(STLabelsModel*)model  ;

@end
