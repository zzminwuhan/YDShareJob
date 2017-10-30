//
//  RewardPoints.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/14.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "RewardPoints.h"

@implementation RewardPoints




- (instancetype)initWithObject:(AVObject*)object {
    
    self = [super initWithDict:nil];
    
    self.owner = [object objectForKey:@"owner"];
    self.value = [object objectForKey:@"value"];
    self.text = [object objectForKey:@"title"];
    
    NSDate* date = [object objectForKey:@"updatedAt"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    self.date = [dateFormatter stringFromDate:date];

    
    return self;
}



+ (BOOL)isSameDay:(NSDate*)date1 date2:(NSDate*)date2
{
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}


+ (void)canAddRewardWithValue:(NSString*)value block:(RewardBlock)goBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:@"message"];
    
    AVUser *user = [AVUser currentUser];
    
    NSDate *date = [NSDate date];
    
    [query whereKey:@"user_id" equalTo:user];
    [query whereKey:@"title" equalTo:@"签到积分"];

    
    [query orderByDescending:@"updatedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        BOOL can = YES;
        if(objects.count > 0){
         
            AVObject *object = objects[0];
            NSDate *date1 = [object objectForKey:@"updatedAt"];
            
            can = ![RewardPoints isSameDay:date date2:date1];
            
        }
        
        goBlock(can);
        
    }];
    
}



+ (void)addRewardWithValue:(NSString*)value block:(RewardBlock)goBlock {
    
    AVObject *todoFolder = [[AVObject alloc] initWithClassName:@"message"];// 构建对象
    
    AVUser *user = [AVUser currentUser];
    
    [todoFolder setObject:user forKey:@"user_id"];// 设置名称
    [todoFolder setObject:value forKey:@"value"];// 设置优先级
    [todoFolder setObject:@"4" forKey:@"type"];// 设置优先级
    [todoFolder setObject:@"签到积分" forKey:@"title"];// 设置优先级

    [todoFolder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        goBlock(NO);
        
    }];
    
}



+ (void)findObjects:(MDArrayResultBlock)resultBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:@"message"];
    
    AVUser *user = [AVUser currentUser];
    
    [query whereKey:@"user_id" equalTo:user];
    [query whereKey:@"type" equalTo:@"4"];
    
    [query orderByDescending:@"updatedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            AVObject *obj = objects[i];
            RewardPoints *model = [[RewardPoints alloc]initWithObject:obj];
            [models addObject:model];
        }
        
        resultBlock(models,error);
        
    }];
    
}



@end
