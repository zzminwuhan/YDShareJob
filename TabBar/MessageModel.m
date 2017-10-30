//
//  MessageModel.m
//  YDShareJob
//
//  Created by 李加建 on 2017/10/18.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "MessageModel.h"

@implementation MessageModel


- (instancetype)initWithObject:(AVObject*)object  {
    
    self = [super init];
    
    NSString *title = [object objectForKey:@"title"];
    NSString *detail = [object objectForKey:@"detail"];
    NSString *date = [object objectForKey:@"date"];
    
    self.title = title;
    self.detail = detail;
    self.date = date;
    
    
    return self;
}



+ (void)addMsg:(NSString*)title detail:(NSString*)detail block:(ActionBlock)goBlock {
    
    AVObject *todoFolder = [[AVObject alloc] initWithClassName:@"message"];// 构建对象
    [todoFolder setObject:title forKey:@"title"];// 设置名称
    [todoFolder setObject:detail forKey:@"detail"];// 设置优先级
    [todoFolder setObject:@"2" forKey:@"type"];// 设置优先级
    
    AVUser *user_id = [AVUser currentUser];
    
    [todoFolder setObject:user_id forKey:@"user_id"];// 设置优先级
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    
    [todoFolder setObject:strDate forKey:@"date"];// 设置优先级
    
    [todoFolder saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        
        goBlock();
        
    }];
    
}


#pragma mark - 注释
// 1.系统消息 2.用户消息 3.帮助信息 4.签到信息

// 获取消息列表
+ (void)findObjects:(MDArrayResultBlock)resultBlock {
    
    AVQuery *startDateQuery = [AVQuery queryWithClassName:@"message"];
    
    [startDateQuery whereKey:@"user_id" equalTo:[AVUser currentUser]];
    
    [startDateQuery whereKey:@"type" equalTo:@"2"];
    
    AVQuery *endDateQuery = [AVQuery queryWithClassName:@"message"];
    
    [endDateQuery whereKey:@"type" equalTo:@"1"];
    
//    AVQuery *query = [AVQuery andQueryWithSubqueries:[NSArray arrayWithObjects:startDateQuery,endDateQuery,nil]];
    
    AVQuery *query = [AVQuery orQueryWithSubqueries:@[startDateQuery,endDateQuery]];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            //收藏模型
            AVObject *obj = objects[i];
            
            MessageModel *model = [[MessageModel alloc]initWithObject:obj];
            
            [models addObject:model];
            
            
        }
        
        resultBlock(models,error);
        
    }];
    
}


// 获取帮助列表
+ (void)findHelpObjects:(MDArrayResultBlock)resultBlock {
    

    
    AVQuery *query = [AVQuery queryWithClassName:@"message"];
    
    [query whereKey:@"type" equalTo:@"3"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            //收藏模型
            AVObject *obj = objects[i];
            
            MessageModel *model = [[MessageModel alloc]initWithObject:obj];
            
            [models addObject:model];
            
        }
        
        resultBlock(models,error);
        
    }];
    
}




@end
