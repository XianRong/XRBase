//
//  UIView+Extension.h
//  gudonghui
//
//  Created by 贤荣 on 15/7/14.
//  Copyright (c) 2015年 xianrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic, readonly) CGPoint middlePoint;
@end
