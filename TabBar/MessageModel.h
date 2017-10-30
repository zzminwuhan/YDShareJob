//
//  MessageModel.h
//  YDShareJob
//
//  Created by 李加建 on 2017/10/18.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel

@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *detail;
@property (nonatomic ,strong)NSString *date;


- (instancetype)initWithObject:(AVObject*)object ;

+ (void)addMsg:(NSString*)title detail:(NSString*)detail block:(ActionBlock)goBlock ;

+ (void)findObjects:(MDArrayResultBlock)resultBlock ;

//帮助中心
+ (void)findHelpObjects:(MDArrayResultBlock)resultBlock ;

@end
