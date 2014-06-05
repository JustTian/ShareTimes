//
//  CpageControl.m
//  FirstProject
//
//  Created by 传晟 on 14-5-6.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "CpageControl.h"
#import "PageControlOfMapper.h"

@implementation CpageControl
+(CpageControl *)loadCustomLabelFromMode:(NSDictionary *)dictionary{
    PageControlOfMapper *pageCMapper = [[PageControlOfMapper alloc]initWithDictionary:dictionary];
    CpageControl *CPView = [[CpageControl alloc]init];
    CGRect frameRect = [CPView rectFromModelJSON:pageCMapper];
    CPView.frame = frameRect;
    CPView.alpha = [pageCMapper.alpha floatValue];
    CPView.numberOfPages = [pageCMapper.numOfPages integerValue];
    CPView.currentPage = [pageCMapper.currentPage integerValue];
    
    UIColor *ITcolor = [CPView colorFromJSONnum:[pageCMapper.ITcolor integerValue]];
    CPView.pageIndicatorTintColor = ITcolor;
    
    UIColor *currentITcolor = [CPView colorFromJSONnum:[pageCMapper.currentITcolor  integerValue]];
    CPView.currentPageIndicatorTintColor = currentITcolor;
    
    UIColor *backColor = [CPView colorFromJSONnum:[pageCMapper.backGColor integerValue]];
    CPView.backgroundColor = backColor;
    
    CPView.tag = [pageCMapper.tag integerValue];
    return CPView;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

#pragma mark 辅助方法
-(CGRect)rectFromModelJSON:(PageControlOfMapper *)pageViewOfMapper{
    CGRect table_rect;
    table_rect.origin.x = [pageViewOfMapper.xPointOfRect floatValue];
    table_rect.origin.y = [pageViewOfMapper.yPointOfRect floatValue];
    table_rect.size.width = [pageViewOfMapper.widthOfRect floatValue];
    table_rect.size.height = [pageViewOfMapper.heightOfRect floatValue];
    return table_rect;
}

@end
