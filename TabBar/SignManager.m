//
//  SignManager.m
//  QKParkTime
//
//  Created by 李加建 on 2017/9/14.
//  Copyright © 2017年 jack. All rights reserved.
//

#import "SignManager.h"

@implementation SignManager






+ (void)signup {
    
    
    if([SignManager isSignup] == YES){
        return;
    }
    
    NSString *current = [SignManager currentDate];
    
    NSArray *signArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"signArray"];
    
    NSMutableArray *array = [NSMutableArray array];
    
    [array addObjectsFromArray:signArray];
    
    [array addObject:current];
    
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"signArray"];
    
}


+ (BOOL)isSignup {
    
    NSString *current = [SignManager currentDate];
    
    NSArray *signArray = [[NSUserDefaults standardUserDefaults] objectForKey:@"signArray"];
    
    BOOL isSign = [signArray containsObject:current];
    
    return isSign;
}


+ (NSString *)currentDate {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:[NSDate date]];
    return strDate;
}






@end
