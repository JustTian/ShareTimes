//
//  CustomLabel.m
//  FirstProject
//
//  Created by 传晟 on 14-5-4.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "CustomLabel.h"
#import "LabelOfMapper.h"

@implementation CustomLabel

+(CustomLabel *)loadCustomLabelFromMode:(NSDictionary *)dictionary{
    LabelOfMapper *labMapper = [[LabelOfMapper alloc]initWithDictionary:dictionary];
    CustomLabel *cLabel = [[CustomLabel alloc]init];
    CGRect rectFrame = [cLabel rectFromModelJSON:labMapper];
    cLabel.frame = rectFrame;
    cLabel.backgroundColor = [UIColor colorWithRed:[labMapper.RGBRed floatValue]
                                             green:[labMapper.RGBGreen floatValue]
                                              blue:[labMapper.RGBBlue floatValue]
                                             alpha:[labMapper.RGB_alpha floatValue]];
    cLabel.text = labMapper.textString;
    cLabel.textColor = [cLabel colorFromJSONnum:[labMapper.textColor integerValue]];
    cLabel.textAlignment = [cLabel acheiveTextAlignmentFromJSONnum:[labMapper.labelAligment integerValue]];
    cLabel.numberOfLines = [labMapper.linesOfNum integerValue];
    cLabel.font = [UIFont fontWithName:labMapper.fontForLabel size:[labMapper.sizeForLabelText intValue]];
    cLabel.shadowColor = [cLabel colorFromJSONnum:[labMapper.shadowColor integerValue]];
    cLabel.shadowOffset = CGSizeMake([[labMapper.shadowOffSet objectAtIndex:0] floatValue], [[labMapper.shadowOffSet objectAtIndex:1] floatValue]);
    cLabel.layer.cornerRadius = [labMapper.radiesNum floatValue];
    cLabel.tag = [labMapper.tag integerValue];
    
    return cLabel;
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
-(CGRect)rectFromModelJSON:(LabelOfMapper *)labelOfMapper{
    CGRect table_rect;
    table_rect.origin.x = [labelOfMapper.xPointOfRect floatValue];
    table_rect.origin.y = [labelOfMapper.yPointOfRect floatValue];
    table_rect.size.width = [labelOfMapper.widthOfRect floatValue];
    table_rect.size.height = [labelOfMapper.heightOfRect floatValue];
    return table_rect;
}

@end
