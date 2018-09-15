//
//  SelectTitle.m
//  app
//
//  Created by 贤荣 on 15/9/19.
//  Copyright © 2015年 linaicai. All rights reserved.
//

#import "SelectTitle.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width//屏幕宽
#define VIEW_HEIGHT(view) (view).bounds.size.height
#define VIEW_WIDTH(view) (view).bounds.size.width
#define kSelectTitleHeight 41
//颜色RGB值和透明度
#define kColorRGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

@interface SelectTitle()
{
    UIScrollView *scrContent;
    UIView *viewLine;
    UILabel *lblCurrent;
}
@end

@implementation SelectTitle

+(SelectTitle *)defaultView
{
    return [[SelectTitle alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kSelectTitleHeight)];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.sColor = [UIColor orangeColor];
        self.dColor = [UIColor blackColor];
        scrContent = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrContent.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrContent];

    }
    return self;
}

#pragma mark -  初始化标题视图
-(void)initWithTitles:(NSArray *)array
{
    for (UIView *view in scrContent.subviews) {
        [view removeFromSuperview];
    }
    
    if (array.count > 0) {
        NSInteger rSize = MIN(5, array.count);
        float bWidth = VIEW_WIDTH(self) / rSize,bHeight = VIEW_HEIGHT(scrContent);
        float left = 0;
        float w = 0.0;
        for (int i = 0; i < array.count; i++) {
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(left, 0, bWidth, bHeight)];
            lbl.tag = i;
            lbl.textAlignment = NSTextAlignmentCenter;
            lbl.textColor = self.dColor;
            if (self.titleFontNum) {
                lbl.font = [UIFont systemFontOfSize:self.titleFontNum];
            }else{
                lbl.font = [UIFont systemFontOfSize:18];
            }
            lbl.backgroundColor = [UIColor clearColor];
            lbl.text = array[i];
            [scrContent addSubview:lbl];
            left += bWidth;
            lbl.userInteractionEnabled = YES;
            [lbl addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(mClicklbl:)]];
            if (i == 0) {
                lblCurrent = lbl;
            }
            w = VIEW_WIDTH(lbl);
        }
        CGSize s;
        s.width = left;
        s.height = 0;
        scrContent.contentSize = s;
        float lH = 2;
        
        viewLine = [[UIView alloc] initWithFrame:CGRectMake(0, VIEW_HEIGHT(self) - 8, w, lH)];
        viewLine.backgroundColor = self.sColor;
        [scrContent addSubview:viewLine];
        [self mSelectlbl:lblCurrent];
        
    }
}

#pragma mark - 点击标题，切换对应的分页
-(void)mClicklbl:(UITapGestureRecognizer *)t
{
    if ([_delegate respondsToSelector:@selector(selectIndex:)]) {
        [_delegate selectIndex:t.view.tag];
    }
    [self mSelectlbl:(UILabel *)t.view];
}

#pragma mark - 滚动分页，选择对应的标题
-(void)setIndex:(int)index{
    _index = index;
    
    [self mSelectlbl:scrContent.subviews[index]];
}


#pragma mark - 当前选择的标题
-(void)mSelectlbl:(UILabel *)lbl
{
    lblCurrent.textColor = self.dColor;
    lbl.textColor = self.sColor;
    lblCurrent = lbl;
    
//    根据字体尺寸来确定下划线的宽度
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = lbl.font;
    float lWidth = [lbl.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size.width;
    
    CGPoint center = CGPointMake(lbl.center.x, viewLine.center.y);
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frm = self->viewLine.frame;
        frm.size.width = lWidth;
        self->viewLine.frame = frm;
        self->viewLine.center = center;
    }];
}

@end;
