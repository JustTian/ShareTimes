//
//  customButton.m
//  AutoLoodViewDemo
//
//  Created by 传晟 on 14-3-12.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "customButton.h"
#import "ButtonOfMapper.h"
#import "NSObject+moreMethords.h"

@implementation customButton
+ (customButton *)loadButtonWithModer:(NSDictionary *)dictionary{
    ButtonOfMapper *buttonOfMapper = [[ButtonOfMapper alloc]initWithDictionary:dictionary];
    UIButtonType butType = [buttonOfMapper buttonTypeFromMapper:buttonOfMapper.numOfType];//控件类型
    customButton *button = [customButton buttonWithType:butType];
    CGRect wRect = [button rectFromModelJSON:buttonOfMapper];
    button.frame = wRect;//控件大小
    
    button.backgroundColor = [UIColor colorWithRed:[buttonOfMapper.RGBRed floatValue]
                                             green:[buttonOfMapper.RGBGreen floatValue]
                                              blue:[buttonOfMapper.RGBBlue floatValue]
                                             alpha:[buttonOfMapper.RGB_alpha floatValue]];
    
    button.tag = [buttonOfMapper.tag integerValue];//设置控件的tag值
    button.layer.cornerRadius = [buttonOfMapper.numOfRadies floatValue];//设置控件的圆角情况
    if ([button boolFromJSON:[buttonOfMapper.isImage integerValue]]) {
        [button setBackgroundImage:[button imageFromJSON:buttonOfMapper.imageName] forState:UIControlStateNormal];
    }
    [button setTitle:buttonOfMapper.nameOfText forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:buttonOfMapper.textFont size:[buttonOfMapper.textSize intValue]];
    
    button.clickOfType = [buttonOfMapper.clickNum integerValue];
    button.myblock = ^(customButton *button){
        NSLog(@"customButton 的初始响应设定");
    };
    return button;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addTarget:self action:@selector(clickAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)clickAction{
    _myblock (self);
}

#pragma mark 辅助方法
-(CGRect)rectFromModelJSON:(ButtonOfMapper *)buttonOfMapper{
    CGRect table_rect;
    table_rect.origin.x = [buttonOfMapper.xPointOfRect floatValue];
    table_rect.origin.y = [buttonOfMapper.yPointOfRect floatValue];
    table_rect.size.width = [buttonOfMapper.widthOfRect floatValue];
    table_rect.size.height = [buttonOfMapper.heightOfRect floatValue];
    return table_rect;
}
//UIButtonTypeCustom = 0,                         // no button type
//UIButtonTypeSystem NS_ENUM_AVAILABLE_IOS(7_0),  // standard system button
//
//UIButtonTypeDetailDisclosure,
//UIButtonTypeInfoLight,
//UIButtonTypeInfoDark,
//UIButtonTypeContactAdd,
//
//UIButtonTypeRoundedRect = UIButtonTypeSystem,
@end
