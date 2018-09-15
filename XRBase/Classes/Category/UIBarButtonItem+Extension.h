//
//  UIBarButtonItem+Extension.h
//  gudonghui
//
//  Created by 贤荣 on 15/7/14.
//  Copyright (c) 2015年 xianrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 *  自定义图片样式的UIBarButtonItem
 *
 *  @param nmlImg 普通状态的图片
 *  @param hltImg 高亮状态的图片
 *  @param target 按钮target
 *  @param action 按钮点击触发方法
 *
 *  @return 固定样式导航条Item
 */
+(instancetype)barBtnItemWithNmlImg:(NSString*)nmlImg hltImg:(NSString*)hltImg target:(id)target action:(SEL)action;

/**
 *  自定义图片样式的UIBarButtonItem
 *
 *  @param nmlImgName 普通状态的图片
 *  @param hltImgName 高亮状态的图片
 *  @param size 自定义item大小
 *  @param target 按钮target
 *  @param action 按钮点击触发方法
 *
 *  @return 固定样式导航条Item
 */
+(instancetype)barBtnItemWithNmlImg:(NSString*)nmlImgName hltImg:(NSString*)hltImgName customItemSize:(CGSize)size target:(id)target action:(SEL)action;

/**
 *  自定义文字样式的UIBarButtonItem
 *
 *  @param title  按钮标题
 *  @param target 按钮target
 *  @param action 按钮点击触发方法
 *
 *  @return 固定样式导航条Item
 */
+(instancetype)barBtnItemWithTitle:(NSString*)title target:(id)target action:(SEL)action;



/**
 *  自定义导航条返回UIBarButtonItem的样式
 *
 *  @param title  按钮标题
 *  @param target 按钮target
 *  @param action 按钮点击触发方法
 *
 *  @return 固定样式导航条Item
 */
+(instancetype)backItemWithTitle:(NSString*)title target:(id)target action:(SEL)action;







@end
