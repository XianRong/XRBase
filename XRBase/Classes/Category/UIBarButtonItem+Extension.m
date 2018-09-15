//
//  UIBarButtonItem+Extension.m
//  weibo
//
//  Created by 贤荣 on 15/7/14.
//  Copyright (c) 2015年 xianrong. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"
#define titleFont [UIFont systemFontOfSize:13]

@implementation UIBarButtonItem (Extension)

+(instancetype)barBtnItemWithNmlImg:(NSString*)nmlImgName hltImg:(NSString*)hltImgName target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *nmlImg = [UIImage imageNamed:nmlImgName];
    
    btn.contentMode = UIViewContentModeCenter;
    
    [btn setImage:nmlImg forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hltImgName] forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    btn.bounds = CGRectMake(0, 0,nmlImg.size.width, nmlImg.size.height);
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+(instancetype)barBtnItemWithNmlImg:(NSString*)nmlImgName hltImg:(NSString*)hltImgName customItemSize:(CGSize)size target:(id)target action:(SEL)action{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *nmlImg = [UIImage imageNamed:nmlImgName];
    
    btn.contentMode = UIViewContentModeCenter;
    
    [btn setImage:nmlImg forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:hltImgName] forState:UIControlStateHighlighted];
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
  
    btn.bounds = CGRectMake(0, 0,size.width,size.height);
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}


+(instancetype)barBtnItemWithTitle:(NSString *)title target:(id)target action:(SEL)action{
//    文字最大尺寸
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
//    计算文字实际尺寸
    CGSize titleSize = [title boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleFont} context:nil].size;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:title forState:UIControlStateNormal];
    
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    设置不可以状态下的字体颜色
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    
    btn.titleLabel.font = titleFont;
    btn.bounds = CGRectMake(0, 0, titleSize.width, titleSize.height);
    
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

+(instancetype)backItemWithTitle:(NSString *)title target:(id)target action:(SEL)action{
    
    UIImage *nmlImg = [UIImage imageNamed:@"ico_nav_leftArrow"];
    UIImage *hltImg = [UIImage imageNamed:@"ico_nav_leftArrow"];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [backBtn setImage:nmlImg forState:UIControlStateNormal];
    [backBtn setImage:hltImg forState:UIControlStateHighlighted];
    
    [backBtn setTitle:title forState:UIControlStateNormal];
    backBtn.titleLabel.font = titleFont;
    
    [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    CGSize maxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    CGSize titleSize = [title boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:titleFont} context:nil].size;
    
//    以图片高度为按钮高度，以图片宽度、文字宽度之和作为按钮宽度
    backBtn.bounds = CGRectMake(0, 0, nmlImg.size.width + titleSize.width, nmlImg.size.height);
    
    [backBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc]initWithCustomView:backBtn];
}

@end
