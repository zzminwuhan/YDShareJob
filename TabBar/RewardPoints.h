//
//  RewardPoints.h
//  QKParkTime
//
//  Created by 李加建 on 2017/9/14.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

typedef void(^RewardBlock)(BOOL isOK);


@interface RewardPoints : BaseModel

@property (nonatomic ,strong)NSString *owner;
@property (nonatomic ,strong)NSString *value;
@property (nonatomic ,strong)NSString *date;
@property (nonatomic ,strong)NSString *text;


+ (void)addRewardWithValue:(NSString*)value block:(RewardBlock)goBlock ;

+ (void)findObjects:(MDArrayResultBlock)resultBlock  ;

// 是否已经签到
+ (void)canAddRewardWithValue:(NSString*)value block:(RewardBlock)goBlock  ;

@end
