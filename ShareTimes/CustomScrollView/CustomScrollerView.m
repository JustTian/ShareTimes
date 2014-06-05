//
//  CustomScrollerView.m
//  FirstProject
//
//  Created by 传晟 on 14-5-8.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "CustomScrollerView.h"
#import "ScrollerViewOfMapper.h"
#import "wDynamicLayout.h"

@implementation CustomScrollerView
+(CustomScrollerView *)loadCustomScrollViewFromMode:(NSDictionary *)dictionary{
    ScrollerViewOfMapper *sViewMapper = [[ScrollerViewOfMapper alloc]initWithDictionary:dictionary];
    
    CustomScrollerView *wScrollerView = [[CustomScrollerView alloc]init];
    CGRect frameRect = [wScrollerView rectFromModelJSON:sViewMapper];
    wScrollerView.frame  = frameRect;
    wScrollerView.backgroundColor = [UIColor colorWithRed:[sViewMapper.RGBRed floatValue]
                                            green:[sViewMapper.RGBGreen floatValue]
                                             blue:[sViewMapper.RGBBlue floatValue]
                                            alpha:[sViewMapper.RGB_alpha floatValue]];
//    wScrollerView.backgroundColor = [UIColor redColor];
    //加载其嵌套的控件
//    NSLog(@"subDictionary : %@",sViewMapper);
    wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
    if (wScrollerView) {
        [dynamicLayout loadItemsForGroup:sViewMapper.subDictionary AndBaseView:wScrollerView];
    }
    wScrollerView.layer.cornerRadius = [sViewMapper.cornerRadies floatValue];
    
    //设置lscrollView是否弹跳
    wScrollerView.bounces = [self boolFromJSON:[sViewMapper.bonces integerValue]];
    
    //设置lscrollView 水平和垂直方向是否显示指示器
    wScrollerView.showsHorizontalScrollIndicator = [self boolFromJSON:[sViewMapper.showHSI integerValue]];//水平方向
    wScrollerView.showsVerticalScrollIndicator = [self boolFromJSON:[sViewMapper.showVSI integerValue]];//垂直方向

    //设置滑动控制器的容量
    wScrollerView.numOfViews = [sViewMapper.subDictionary.allKeys count];
    CGFloat size_w = [sViewMapper.widthOfSubView floatValue];
    CGFloat size_h = [sViewMapper.heightOfSubView floatValue];
    NSInteger num1 = [sViewMapper.numOfEvreyRow integerValue];
    wScrollerView.contentSize = CGSizeMake(size_w *num1, size_h *(wScrollerView.numOfViews / num1));
    
    wScrollerView.tag = [sViewMapper.tag integerValue];

    return wScrollerView;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark 辅助方法
-(CGRect)rectFromModelJSON:(ScrollerViewOfMapper *)sViewOfMapper{
    CGRect table_rect;
    table_rect.origin.x = [sViewOfMapper.xPointOfRect floatValue];
    table_rect.origin.y = [sViewOfMapper.yPointOfRect floatValue];
    table_rect.size.width = [sViewOfMapper.widthOfRect floatValue];
    table_rect.size.height = [sViewOfMapper.heightOfRect floatValue];
    return table_rect;
}
@end
