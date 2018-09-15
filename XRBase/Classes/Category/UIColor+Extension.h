//
//  UIColor+Extension.h
//  YunHuaCe
//
//  Created by 贤荣 on 16/3/9.
//  Copyright © 2016年 Air. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ColorModel;
@interface UIColor (Extension)

+ (UIColor *) colorWithHexStrings: (NSString *)color withAlpha:(CGFloat)alpha;

+ (ColorModel *) RGBWithHexString: (NSString *)color withAlpha:(CGFloat)alpha;

+ (UIColor *) colorWithHexString: (NSString *)color;


@end
