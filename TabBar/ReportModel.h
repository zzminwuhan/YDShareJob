//
//  ReportModel.h
//  QKParkTime
//
//  Created by 李加建 on 2017/9/13.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

#import "MessageModel.h"

#import "ParkTimeModel.h"

typedef void(^ReportBlock)(BOOL isOK);

@interface ReportModel : BaseModel


@property (nonatomic ,strong)ParkTimeModel *jobModel;

@property (nonatomic ,strong)NSString *Id;
@property (nonatomic ,strong)NSString *type;

@property (nonatomic ,strong)NSString *status;


+ (void)isReportWithJob:(AVObject*)job  block:(ReportBlock)goBlock ;

+ (void)addReportWithJob:(AVObject*)job  block:(ReportBlock)goBlock ;

+ (void)delReport:(NSString*)reportId  block:(ReportBlock)goBlock;

+ (void)findObjects:(MDArrayResultBlock)resultBlock  ;

@end
