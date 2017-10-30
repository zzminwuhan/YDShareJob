//
//  CollectModel.h
//  QKParkTime
//
//  Created by 李加建 on 2017/9/13.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

#import "ParkTimeModel.h"


typedef void(^IsCollcetBlock)(BOOL isColl);
typedef void(^CollectAction)(void);

@interface CollectModel : BaseModel

@property (nonatomic ,strong)ParkTimeModel *jobModel;

@property (nonatomic ,strong)NSString *Id;



+ (void)addCollectWithJob:(AVObject*)job block:(CollectAction)goBlock  ;

// 取消收藏
+ (void)delCollectId:(NSString*)collId  block:(CollectAction)goBlock ;
// 详情取消收藏
+ (void)delWithJob:(AVObject*)job block:(CollectAction)goBlock ;;

+ (void)isCollectWithJob:(AVObject*)job  block:(IsCollcetBlock)block ;

+ (void)findObjects:(MDArrayResultBlock)resultBlock ;

@end
