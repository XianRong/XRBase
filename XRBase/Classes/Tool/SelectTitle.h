//
//  SelectTitle.h
//  app
//
//  Created by 贤荣 on 15/9/19.
//  Copyright © 2015年 linaicai. All rights reserved.
//

/*

{
    SelectTitle * sltTitle;
   
}

//   创建标题按钮
sltTitle = [SelectTitle defaultView];
sltTitle.delegate = self;
[self.view addSubview:sltTitle];
[sltTitle initWithTitles:@[NSLocalizedString(, nil),NSLocalizedString(, nil),NSLocalizedString(, nil),NSLocalizedString(, nil),NSLocalizedString(, nil)]];

------------------------------------------------

#pragma mark - 点击相应的标题,切换分页视图
- (void)selectIndex:(NSInteger)index {
    
    NSLog(NSLocalizedString(, nil), index + 1);
    
    CGFloat offsetX = self.scrollView.w *index;
    [UIView animateWithDuration:1 animations:^{
        self.scrollView.contentOffset = CGPointMake(offsetX, 0);
        self.scrollView.scrollEnabled = NO;
    }];
}

#pragma mark - scrollView的代理方法
// 只要offset发生改变了就会调用这个方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    //    滚动分页，切换相对应的标题
    int slIndex = (scrollView.contentOffset.x + scrollView.w *0.5) / scrollView.w;
    sltTitle.index = slIndex;
}

*/

//--------------------外界引用-----------------------------


#import <UIKit/UIKit.h>

@protocol SelectTitleDelegate <NSObject>
@optional
//   选择下标
-(void)selectIndex:(NSInteger)index;

@end

@interface SelectTitle : UIView

@property(nonatomic,weak)id<SelectTitleDelegate> delegate;

// 记录分页的index
@property (nonatomic,assign) int index;

+(SelectTitle *)defaultView;

///初始化视图
-(void)initWithTitles:(NSArray *)array;

@property (nonatomic,strong) UIColor *dColor;//默认字体颜色
@property (nonatomic,strong) UIColor *sColor;// 选中字体颜色
@property (nonatomic,assign) NSInteger titleFontNum;// 标题字体字号


@end
