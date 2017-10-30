//
//  STLabelsModel.m
//  DongJie
//
//  Created by yuyue on 2017/8/11.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "STLabelsModel.h"

@implementation STLabelsModel




- (instancetype)initWithDict:(NSDictionary *)dict {
    
    self = [super  initWithDict:dict];
    
    self.type_id = DictStr(dict, @"id");
    self.type_title = DictStr(dict, @"title");
    self.isSel = NO;
    
    return self;
}



+ (STLabelsModel*)userdefaults {
    
    STLabelsModel *model = [STLabelsModel new];
    model.type_title = @"自定义";
    model.isSel = YES;
    
    return model;
}



@end
