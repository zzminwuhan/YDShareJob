//
//  JobBannerModel.h
//  YDShareJob
//
//  Created by 李加建 on 2017/10/17.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

@interface JobBannerModel : BaseModel

@property (nonatomic ,strong)NSString *type;
@property (nonatomic ,strong)NSString *img_url;
@property (nonatomic ,strong)NSString *url;



+ (void)findObjects:(MDArrayResultBlock)resultBlock ;

@end
