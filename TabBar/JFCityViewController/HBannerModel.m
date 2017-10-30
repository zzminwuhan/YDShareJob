//
//  HBannerModel.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "HBannerModel.h"

#import <AVOSCloud/AVOSCloud.h>

@implementation HBannerModel









- (instancetype)initWithObject:(AVObject*)object {
    
    self = [super initWithDict:nil];

    self.type = [object objectForKey:@"type"];
    self.url = [object objectForKey:@"url"];
    
    AVFile *file = [object objectForKey:@"image"];
    
    if(file.url != nil){
        
        self.img_url = file.url;
    }
    else {
        self.img_url = @"";
    }
    
    return self;
}



+ (void)findObjects:(MDArrayResultBlock)resultBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:@"banner"];
    
//    [query whereKey:@"type" equalTo:@"1"];
    [query whereKey:@"bid" equalTo:BUNDLEID];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
       
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            AVObject *obj = objects[i];
            HBannerModel *model = [[HBannerModel alloc]initWithObject:obj];
            [models addObject:model];
        }
        
        resultBlock(models,error);
        
    }];

}




+ (void)findType:(NSString*)type Objects:(MDArrayResultBlock)resultBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:@"banner"];
    
    [query whereKey:@"type" equalTo:type];
    
    [query whereKey:@"bid" equalTo:BUNDLEID];
    
    query.limit = 2;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            AVObject *obj = objects[i];
            HBannerModel *model = [[HBannerModel alloc]initWithObject:obj];
            [models addObject:model];
        }
        
        resultBlock(models,error);
        
    }];
    
}




@end
