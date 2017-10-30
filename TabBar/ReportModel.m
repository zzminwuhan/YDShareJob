//
//  ReportModel.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/13.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "ReportModel.h"

@implementation ReportModel



- (instancetype)initWithObject:(AVObject*)object {
    
    self = [super init];
    
    NSString *Id = [object objectForKey:@"objectId"];
    
    self.Id = Id;
    
    self.status = [NSString stringWithFormat:@"%@" ,[object objectForKey:@"status"]];
    
    AVObject *job = [object objectForKey:@"job_id"];
    
    job = [job fetchIfNeededWithKeys:job.allKeys error:nil];
    
    self.jobModel = [[ParkTimeModel alloc]initWithObject:job];
    
    return self;
}






+ (void)isReportWithJob:(AVObject*)job  block:(ReportBlock)goBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:@"jobaction"];
    
    AVUser *user_id = [AVUser currentUser];
    
    [query whereKey:@"type" equalTo:@"2"];
    [query whereKey:@"user_id" equalTo:user_id];
    [query whereKey:@"job_id" equalTo:job];
    
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSLog(@"%@",objects);
        BOOL isOk = NO;
        if(objects.count > 0){
            isOk = YES;
        }
        
        //是否已经收藏
        
        goBlock(isOk);
        
    }];
}


+ (void)addReportWithJob:(AVObject*)job  block:(ReportBlock)goBlock {
    
    AVObject *obj = [[AVObject alloc] initWithClassName:@"jobaction"];// 构建对象
    
    AVUser *user_id = [AVUser currentUser];
    
    [obj setObject:@"2" forKey:@"type"];
    [obj setObject:user_id forKey:@"user_id"];
    [obj setObject:job forKey:@"job_id"];
    
    [obj saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        if(succeeded == YES){
            
            goBlock(NO);
        }
        else {
            
        }
        
    }];
}




+ (void)delReport:(NSString*)reportId  block:(ReportBlock)goBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:@"jobaction"];
    
    [query getObjectInBackgroundWithId:reportId block:^(AVObject * _Nullable object, NSError * _Nullable error) {
        
        [object deleteInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            
            goBlock(NO);
        }];
    }];
}


// 获取收藏列表
+ (void)findObjects:(MDArrayResultBlock)resultBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:@"jobaction"];
    
    [query whereKey:@"type" equalTo:@"2"];
    
    AVUser *user_id = [AVUser currentUser];
    
    [query whereKey:@"user_id" equalTo:user_id];
    
    [query orderByDescending:@"createdAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            //收藏模型
            AVObject *obj = objects[i];
            
            ReportModel *model = [[ReportModel alloc]initWithObject:obj];
            
            [models addObject:model];
            
        }
        
        resultBlock(models,error);
        
    }];
    
}







@end
