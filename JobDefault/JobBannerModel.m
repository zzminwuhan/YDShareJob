//
//  JobBannerModel.m
//  YDShareJob
//
//  Created by 李加建 on 2017/10/17.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "JobBannerModel.h"

@implementation JobBannerModel



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
    
    [query whereKey:@"type" equalTo:@"1"];
    [query whereKey:@"bid" equalTo:BUNDLEID];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            AVObject *obj = objects[i];
            JobBannerModel *model = [[JobBannerModel alloc]initWithObject:obj];
            [models addObject:model];
        }
        
        resultBlock(models,error);
        
    }];
    
}



@end
