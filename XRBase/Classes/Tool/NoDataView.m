//
//  NoDataView.m
//  HuitoneLive
//
//  Created by 贤荣 on 2017/8/11.
//  Copyright © 2017年 huitone. All rights reserved.
//

#import "NoDataView.h"

@interface NoDataView ()

@property (nonatomic,weak) UIImageView * nullImgV;


@end

@implementation NoDataView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    
        UIImageView * nullImgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"nodataDefaultImg"]];
        [self addSubview:nullImgV];
        self.nullImgV = nullImgV;
    
        UILabel * titleL = [[UILabel alloc]init];
        self.titleL = titleL;
        titleL.text = @"数据加载失败！";
        titleL.textAlignment = NSTextAlignmentCenter;
        titleL.font = [UIFont systemFontOfSize:15];
        titleL.textColor = [UIColor lightGrayColor];
        [self addSubview:titleL];
        
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat imgW = 214;
    CGFloat imgH = 207;
    self.nullImgV.frame = CGRectMake((self.frame.size.width-imgW)/2,(self.frame.size.height-imgH)/2, imgW, imgH);
    self.titleL.frame = CGRectMake(5, (self.frame.size.height+imgH)/2 +10, self.frame.size.width-10, 30);
}



@end
