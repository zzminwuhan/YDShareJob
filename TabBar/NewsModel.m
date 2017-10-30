//
//  NewsModel.m
//  YDShareJob
//
//  Created by 李加建 on 2017/10/19.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

- (instancetype)initWithObject:(AVObject*)object {
    
    self = [super initWithDict:nil];
    
    AVFile *file = [object objectForKey:@"image"];
    
    self.title = [object objectForKey:@"title"];
    self.detail = [object objectForKey:@"detail"];
    
    if(file.url != nil){
        
        self.url = file.url;
    }
    else {
        self.url = @"";
    }

    
    return self;
}



+ (void)findObjects:(MDArrayResultBlock)resultBlock {
    
    AVQuery *query = [AVQuery queryWithClassName:@"news"];
    
    //    [query whereKey:@"ishot" equalTo:@"1"];
    
    [query whereKey:@"bid" equalTo:BUNDLEID];
    
    [query orderByDescending:@"updatedAt"];
    
    query.limit = 3;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray * _Nullable objects, NSError * _Nullable error) {
        
        NSMutableArray *models = [NSMutableArray array];
        
        for(int i=0;i<objects.count;i++){
            
            AVObject *obj = objects[i];
            NewsModel *model = [[NewsModel alloc]initWithObject:obj];
            [models addObject:model];
            
        }
        
        resultBlock(models,error);
        
    }];
    
}



@end
