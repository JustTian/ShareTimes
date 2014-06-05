//
//  ButtonOfMapper.h
//  FirstProject
//
//  Created by 传晟 on 14-4-29.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ButtonOfMapper;
@interface ButtonOfMapper : NSObject

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
//定制控件的类型
@property(nonatomic,strong) NSString *numOfType;
//定制控件的圆角情况
@property(nonatomic,strong) NSString *numOfRadies;
//定制控件的背景颜色
@property(nonatomic,strong) NSString *imageName;
//控件的背景是否用图片展示
@property(nonatomic,strong) NSString *isImage;
//定制控件的标题名称
@property(nonatomic,strong) NSString *nameOfText;
//按钮的响应事件控制
@property(nonatomic,strong) NSString *clickNum;
//按钮标题文字的对齐方式
@property(nonatomic,strong) NSString *alignmentType;
//按钮的标题文字的字体设置
@property(nonatomic,strong) NSString *textFont;
//按钮的标题文字的字体大小设置
@property(nonatomic,strong) NSString *textSize;

+(ButtonOfMapper *)modelObjectWithDictionary:(NSDictionary *)dictionary;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)dictionaryRepresentation;


@end
