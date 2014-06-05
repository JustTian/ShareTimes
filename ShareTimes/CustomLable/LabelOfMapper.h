//
//  LabelOfMapper.h
//  FirstProject
//
//  Created by 传晟 on 14-5-4.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LabelOfMapper : NSObject
@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSString *tag;
//定制背景颜色
@property(nonatomic,strong) NSString *RGBGreen;
@property(nonatomic,strong) NSString *RGBBlue;
@property(nonatomic,strong) NSString *RGBRed;
@property(nonatomic,strong) NSString *RGB_alpha;
//定制控件的frame
@property(nonatomic,strong) NSString *heightOfRect;
@property(nonatomic,strong) NSString *widthOfRect;
@property(nonatomic,strong) NSString *xPointOfRect;
@property(nonatomic,strong) NSString *yPointOfRect;
//label的文字显示内容
@property(nonatomic,strong) NSString *textString;
//label的文字对齐方式
@property(nonatomic,strong) NSString *labelAligment;
//label的字体颜色
@property(nonatomic,strong) NSString *textColor;
//标签的字体
@property(nonatomic,strong) NSString *fontForLabel;
//标签的字体大小
@property(nonatomic,strong) NSString *sizeForLabelText;
//标签的字体容纳行数
@property(nonatomic,strong) NSString *linesOfNum;
//标签的阴影颜色
@property(nonatomic,strong) NSString *shadowColor;
//label的阴影偏移量设置
@property(nonatomic,strong) NSArray *shadowOffSet;
//标签的圆角设置
@property(nonatomic,strong) NSString *radiesNum;
+(LabelOfMapper *)modelObjectWithDictionary:(NSDictionary *)dictionary;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)dictionaryRepresentation;

@end
