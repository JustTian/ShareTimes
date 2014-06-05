//
//  CustomSegmetnControl.m
//  FirstProject
//
//  Created by 传晟 on 14-5-6.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "CustomSegmetnControl.h"
#import "SegmentOfMapper.h"

@implementation CustomSegmetnControl
+(CustomSegmetnControl *)loadCustomLabelFromMode:(NSDictionary *)dictionary{
    SegmentOfMapper *segmentMapper = [[SegmentOfMapper alloc]initWithDictionary:dictionary];
    CustomSegmetnControl *cSControl = [[CustomSegmetnControl alloc]initWithItems:segmentMapper.items];
    CGRect frameRect = [cSControl rectFromModelJSON:segmentMapper];
    cSControl.frame = frameRect;
    cSControl.backgroundColor = [UIColor colorWithRed:[segmentMapper.RGBRed floatValue]
                                             green:[segmentMapper.RGBGreen floatValue]
                                              blue:[segmentMapper.RGBBlue floatValue]
                                             alpha:[segmentMapper.RGB_alpha floatValue]];
    cSControl.tag = [segmentMapper.tag integerValue];
    cSControl.selectedSegmentIndex = [segmentMapper.selectIndex integerValue];

    return cSControl;
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
-(CGRect)rectFromModelJSON:(SegmentOfMapper *)segmentOfMapper{
    CGRect table_rect;
    table_rect.origin.x = [segmentOfMapper.xPointOfRect floatValue];
    table_rect.origin.y = [segmentOfMapper.yPointOfRect floatValue];
    table_rect.size.width = [segmentOfMapper.widthOfRect floatValue];
    table_rect.size.height = [segmentOfMapper.heightOfRect floatValue];
    return table_rect;
}


@end
