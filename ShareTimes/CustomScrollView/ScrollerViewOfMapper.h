//
//  ScrollerViewOfMapper.h
//  FirstProject
//
//  Created by 传晟 on 14-5-8.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScrollerViewOfMapper : NSObject
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

@property(nonatomic,strong) NSString *cornerRadies;
@property(nonatomic,strong) NSString *bonces;
@property(nonatomic,strong) NSString *showHSI;
@property(nonatomic,strong) NSString *showVSI;
@property(nonatomic,strong) NSString *widthOfSubView;
@property(nonatomic,strong) NSString *heightOfSubView;
@property(nonatomic,strong) NSString *numOfEvreyRow;
//@property(nonatomic,strong) NSString *

//用于记录这个容器控件的自控件的相关数据字典
@property(nonatomic,strong) NSDictionary *subDictionary;

+(ScrollerViewOfMapper *)modelObjectWithDictionary:(NSDictionary *)dictionary;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)dictionaryRepresentation;
@end
