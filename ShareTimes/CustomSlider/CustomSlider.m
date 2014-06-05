//
//  CustomSlider.m
//  FirstProject
//
//  Created by 传晟 on 14-5-7.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "CustomSlider.h"
#import "SliderOfMapper.h"

@implementation CustomSlider
+(CustomSlider *)loadCustomLabelFromMode:(NSDictionary *)dictionary{
    SliderOfMapper *slderMapper = [[SliderOfMapper alloc]initWithDictionary:dictionary];
    
    CustomSlider *cSlider = [[CustomSlider alloc]init];
    CGRect frameRect = [cSlider rectFromModelJSON:slderMapper];
    cSlider.frame = frameRect;
    cSlider.backgroundColor = [UIColor colorWithRed:[slderMapper.RGBRed floatValue]
                                                green:[slderMapper.RGBGreen floatValue]
                                                 blue:[slderMapper.RGBBlue floatValue]
                                                alpha:[slderMapper.RGB_alpha floatValue]];
    cSlider.minimumValue = [slderMapper.miniValue floatValue];
    cSlider.maximumValue = [slderMapper.maxiValue floatValue];
    cSlider.value = [slderMapper.currentValue floatValue];
    cSlider.tag = [slderMapper.tag integerValue];
    
    NSDictionary *picDic = slderMapper.items;
    if ([cSlider boolFromJSON:[slderMapper.isPicture integerValue]]) {
        for (int i = 0; i<[picDic.allKeys count]; i++) {
            if ([[picDic.allKeys objectAtIndex:i]isEqualToString:@"minimumValueInage"]) {
                NSString *nameImage = [picDic objectForKey:@"minimumValueInage"];
                cSlider.minimumValueImage = [UIImage imageNamed:nameImage];
            }
            if ([[picDic.allKeys objectAtIndex:i]isEqualToString:@"maximumValueImage"]) {
                NSString *nameImage = [picDic objectForKey:@"maximumValueImage"];
                cSlider.maximumValueImage = [UIImage imageNamed:nameImage];
            }
        }
    }
    
    NSString *thumbNameString = slderMapper.thumbImageName;
    [cSlider setThumbImage:[UIImage imageNamed:thumbNameString] forState:UIControlStateNormal];
//    [cSlider setThumbTintColor:[UIColor blueColor]];
//    [cSlider setMinimumTrackImage:[UIImage imageNamed:@"4"] forState:UIControlStateNormal];
    return cSlider;
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
-(CGRect)rectFromModelJSON:(SliderOfMapper *)sliderOfMapper{
    CGRect table_rect;
    table_rect.origin.x = [sliderOfMapper.xPointOfRect floatValue];
    table_rect.origin.y = [sliderOfMapper.yPointOfRect floatValue];
    table_rect.size.width = [sliderOfMapper.widthOfRect floatValue];
    table_rect.size.height = [sliderOfMapper.heightOfRect floatValue];
    return table_rect;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
