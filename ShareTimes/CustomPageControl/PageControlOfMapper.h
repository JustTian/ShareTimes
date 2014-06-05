//
//  PageControlOfMapper.h
//  FirstProject
//
//  Created by 传晟 on 14-5-6.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PageControlOfMapper : NSObject
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

@property(nonatomic,strong) NSString *numOfPages;
@property(nonatomic,strong) NSString *currentPage;
@property(nonatomic,strong) NSString *ITcolor;
@property(nonatomic,strong) NSString *currentITcolor;
@property(nonatomic,strong) NSString *backGColor;
@property(nonatomic,strong) NSString *alpha;

+(PageControlOfMapper *)modelObjectWithDictionary:(NSDictionary *)dictionary;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)dictionaryRepresentation;

@end
