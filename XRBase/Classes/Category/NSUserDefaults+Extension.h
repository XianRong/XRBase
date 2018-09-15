//
//  NSUserDefaults+Extension.h
//  text
//
//  Created by 贤荣 on 15/8/6.
//  Copyright (c) 2015年 xianrong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (Extension)

/**
 *  从项目info plist 里获取当前版本号
 */
+(NSString *)versionFromInfoPlist;


/**
 *  保存当前版本号到沙盒
 */
+(void)saveCurrentVersion;


/**
 *  获取沙盒里的版本号
 */
+(NSString *)versionFromSandBox;




@end
