//
//  STLabelsModel.h
//  DongJie
//
//  Created by yuyue on 2017/8/11.
//  Copyright © 2017年 incredibleRon. All rights reserved.
//

#import "BaseModel.h"

@interface STLabelsModel : BaseModel

@property (nonatomic ,strong)NSString * type_id;
@property (nonatomic ,strong)NSString * type_title;
@property (nonatomic ,strong)NSString * type_dd;

@property (nonatomic ,assign)BOOL isSel;


+ (STLabelsModel*)userdefaults ;

@end
