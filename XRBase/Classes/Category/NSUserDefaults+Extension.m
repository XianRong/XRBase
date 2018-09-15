//
//  NSUserDefaults+Extension.m
//  text
//
//  Created by 贤荣 on 15/8/6.
//  Copyright (c) 2015年 xianrong. All rights reserved.
//

#import "NSUserDefaults+Extension.h"
//  沙盒里的保存版本的key
#define kVersionInSandBox @"versionInSandBox"

@implementation NSUserDefaults (Extension)

+(NSString *)versionFromInfoPlist{
    
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
//    NSLog(@"%@",info);
    NSString *versionKey = (__bridge NSString *)kCFBundleVersionKey;
    NSString *currentVersion = info[versionKey];
    
    return currentVersion;
}


+(void)saveCurrentVersion{
    NSString * currentVersion = [self versionFromInfoPlist];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:currentVersion forKey:kVersionInSandBox];
    
}

+(NSString *)versionFromSandBox{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:kVersionInSandBox];
}





@end
