//
//  HBannerModel.h
//  QKParkTime
//
//  Created by 李加建 on 2017/9/11.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "BaseModel.h"

@interface HBannerModel : BaseModel

@property (nonatomic ,strong)NSString *type;
@property (nonatomic ,strong)NSString *img_url;
@property (nonatomic ,strong)NSString *url;



+ (void)findObjects:(MDArrayResultBlock)resultBlock ;


+ (void)findType:(NSString*)type Objects:(MDArrayResultBlock)resultBlock ;

@end
