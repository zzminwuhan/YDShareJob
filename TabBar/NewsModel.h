//
//  NewsModel.h
//  YDShareJob
//
//  Created by 李加建 on 2017/10/19.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

@interface NewsModel : BaseModel

@property (nonatomic ,strong)NSString *title;
@property (nonatomic ,strong)NSString *detail;
@property (nonatomic ,strong)NSString *url;



+ (void)findObjects:(MDArrayResultBlock)resultBlock ;

@end
