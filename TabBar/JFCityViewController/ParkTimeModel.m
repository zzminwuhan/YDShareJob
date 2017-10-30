//
//  ParkTimeModel.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "ParkTimeModel.h"

#import <AVOSCloud/AVOSCloud.h>



static NSString * jobKey = @"job";

@implementation ParkTimeModel


- (instancetype)initWithObject:(AVObject*)object {
    
    self = [super initWithDict:nil];
    
    self.job = object;
    
    self.Id = [object objectForKey:@"objectId"];
    self.type = [object objectForKey:@"type"];
    self.title = [object objectForKey:@"title"];
    self.price = [object objectForKey:@"price"];
    self.date = [object objectForKey:@"date"];
    
    self.detail = [object objectForKey:@"detail"];
    self.nums = [object objectForKey:@"nums"];
    self.address = [object objectForKey:@"address"];
    self.lat = [object objectForKey:@"lat"];
    self.lng = [object objectForKey:@"lng"];
    
    self.style = [object objectForKey:@"style"];
    self.hot = [object objectForKey:@"ishot"];
    
    AVFile *file = [object objectForKey:@"image"];
    
    self.url = [object objectForKey:@"url"];
    self.bid = [object objectForKey:@"bid"];
    
    if(file.url != nil){
        
        self.img_url = file.url;
    }
    else {
        self.img_url = @"";
    }
    

    
    
    return self;
}





+ (void)findObjects:(MDArrayResultBlock)resultBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:jobKey];
    
//    [query whereKey:@"type" equalTo:@"1"];
    
    [query whereKey:@"bid" equalTo:BUNDLEID];
    
    [query orderByDescending:@"updatedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
        
            
            AVObject *obj = objects[i];
            ParkTimeModel *model = [[ParkTimeModel alloc]initWithObject:obj];
            [models addObject:model];
            
        }
        
        resultBlock(models,error);
        
    }];
    
}


+ (void)findObjects:(NSString*)type success:(MDArrayResultBlock)resultBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:jobKey];
    
    [query whereKey:@"bid" equalTo:BUNDLEID];
    
    [query whereKey:@"type" containsString:type];
    
    [query orderByDescending:@"updatedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            
            AVObject *obj = objects[i];
            ParkTimeModel *model = [[ParkTimeModel alloc]initWithObject:obj];
            [models addObject:model];
            
        }
        
        resultBlock(models,error);
        
    }];
    
}



- (void)findObjectId:(NSString*)Id success:(MDArrayResultBlock)resultBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:jobKey];
    
    [query whereKey:@"objectId" equalTo:Id];
    
    [query getObjectInBackgroundWithId:Id block:^(AVObject * _Nullable object, NSError * _Nullable error) {
        
        [self deltailWithObject:object];
        
        resultBlock(nil,error);
        
    }];
    
    
}



- (void)deltailWithObject:(AVObject*)object {
    
    
//    self.Id = [object objectForKey:@"objectId"];
    self.type = [object objectForKey:@"type"];
    self.title = [object objectForKey:@"title"];
    self.price = [object objectForKey:@"price"];
    self.date = [object objectForKey:@"date"];
    
    self.detail = [object objectForKey:@"detail"];
    self.nums = [object objectForKey:@"nums"];
    self.address = [object objectForKey:@"address"];
    self.lat = [object objectForKey:@"lat"];
    self.lng = [object objectForKey:@"lng"];
    
    self.style = [object objectForKey:@"style"];
    
    self.url = [object objectForKey:@"url"];
    self.bid = [object objectForKey:@"bid"];
    
    AVFile *file = [object objectForKey:@"image"];
    
    if(file.url != nil){
        
        self.img_url = file.url;
    }
    else {
        self.img_url = @"";
    }
    
    
}



+ (void)findKeyword:(NSString *)keyword Objects:(MDArrayResultBlock)resultBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:jobKey];
    
    if(keyword.length > 0){
        
        [query whereKey:@"title" containsString:keyword];
    }
    
    [query whereKey:@"bid" equalTo:BUNDLEID];
    
    [query orderByDescending:@"updatedAt"];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            
            AVObject *obj = objects[i];
            ParkTimeModel *model = [[ParkTimeModel alloc]initWithObject:obj];
            [models addObject:model];
            
        }
        
        resultBlock(models,error);
        
    }];
    
}


+ (void)findNewObjects:(MDArrayResultBlock)resultBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:jobKey];
    
    //    [query whereKey:@"type" equalTo:@"1"];
    [query whereKey:@"bid" equalTo:BUNDLEID];
    
    [query orderByDescending:@"updatedAt"];
    query.limit = 10;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            
            AVObject *obj = objects[i];
            ParkTimeModel *model = [[ParkTimeModel alloc]initWithObject:obj];
            [models addObject:model];
            
        }
        
        resultBlock(models,error);
        
    }];
    
}


+ (void)findHotObjects:(MDArrayResultBlock)resultBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:jobKey];
    
    [query whereKey:@"ishot" equalTo:@"1"];
    
    [query whereKey:@"bid" equalTo:BUNDLEID];
    
    [query orderByDescending:@"updatedAt"];
    
    query.limit = 3;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            AVObject *obj = objects[i];
            ParkTimeModel *model = [[ParkTimeModel alloc]initWithObject:obj];
            [models addObject:model];
            
        }
        
        resultBlock(models,error);
        
    }];
    
}




@end
