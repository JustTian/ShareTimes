//
//  LabelOfMapper.m
//  FirstProject
//
//  Created by 传晟 on 14-5-4.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "LabelOfMapper.h"
//此处注意不能定制相同的名称 ｜const后的name
NSString *const kLabelType = @"type";
NSString *const kLabeltag  = @"LkeyOfTag";

NSString *const kLabelColorRGBGreen = @"LkeyColorRGB_green";
NSString *const kLabelColorRGBRed = @"LkeyColorRGB_red";
NSString *const kLabelColorRGBBlue = @"LkeyColorRGB_blue";
NSString *const kLabelColorRGB_alpha = @"LkeyColor_alpha";

NSString *const kLabelCGRectX = @"LkeyCGRect_x";
NSString *const kLabelCGRectY = @"LkeyCGRect_y";
NSString *const kLabelCGRectWidth = @"LkeyCGRect_width";
NSString *const kLabelCGRectheight = @"LkeyCGRect_height";

NSString *const kLabelString = @"LkeyText";
NSString *const kLabelAligment = @"LkeyAlignment";
NSString *const kLabelTextColor = @"LkeyTextColor";
NSString *const kLabelFont = @"LkeyFont";
NSString *const kLabelLines = @"LkeyLines";
NSString *const kLabelShadowColor = @"LkeyShadowColor";
NSString *const kLabelShadowOffSet =@"LkeyShadowOffSet";
NSString *const kLabelSize = @"LkeySize";
NSString *const kLabelRadies = @"LkeyRadies";

@interface LabelOfMapper ()
@property(nonatomic,strong)CountString *countSting;
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;
@end

@implementation LabelOfMapper
+(LabelOfMapper *)modelObjectWithDictionary:(NSDictionary *)dictionary{
    LabelOfMapper *interface = [[LabelOfMapper alloc]initWithDictionary:dictionary];
    return interface;
}

//初始化加载  新的属性也在此添加
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self  = [super init];
    //    NSAttributedString
    //    NSShadowAttributeName
    if (self && [dictionary isKindOfClass:[NSDictionary class]]) {
        _countSting = [[CountString alloc]init];
        
        self.type = [self objectOrNilForKey:kLabelType fromDictionary:dictionary];
        self.tag = [self objectOrNilForKey:kLabeltag fromDictionary:dictionary];
        NSString *xString = [_countSting getStatement:[self objectOrNilForKey:kLabelCGRectX fromDictionary:dictionary]];
        CGFloat rect_x =[_countSting operatorString:xString];
        NSString *yString = [_countSting getStatement:[self objectOrNilForKey:kLabelCGRectY fromDictionary:dictionary]];
        CGFloat rect_y =[_countSting operatorString:yString];
        NSString *wString = [_countSting getStatement:[self objectOrNilForKey:kLabelCGRectWidth  fromDictionary:dictionary]];
        CGFloat rect_width =[_countSting operatorString:wString];
        NSString *hString = [_countSting getStatement:[self objectOrNilForKey:kLabelCGRectheight  fromDictionary:dictionary]];
        CGFloat rect_height =[_countSting operatorString:hString];
        self.xPointOfRect = [NSString stringWithFormat:@"%f",rect_x];
        self.yPointOfRect = [NSString stringWithFormat:@"%f",rect_y];
        self.widthOfRect = [NSString stringWithFormat:@"%f",rect_width];
        self.heightOfRect = [NSString stringWithFormat:@"%f",rect_height];
        
        
        CGFloat fRGBred = [_countSting operatorString:[self objectOrNilForKey:kLabelColorRGBRed fromDictionary:dictionary]];
        CGFloat fRGBgreen = [_countSting operatorString:[self objectOrNilForKey:kLabelColorRGBGreen fromDictionary:dictionary]];
        CGFloat fRGBblue = [_countSting operatorString:[self objectOrNilForKey:kLabelColorRGBBlue  fromDictionary:dictionary]];
        self.RGBRed = [NSString stringWithFormat:@"%f",fRGBred];
        self.RGBGreen = [NSString stringWithFormat:@"%f",fRGBgreen];
        self.RGBBlue = [NSString stringWithFormat:@"%f",fRGBblue];
        self.RGB_alpha = [self objectOrNilForKey:kLabelColorRGB_alpha fromDictionary:dictionary];
        
        self.textString = [self objectOrNilForKey:kLabelString fromDictionary:dictionary];
        self.textColor = [self objectOrNilForKey:kLabelTextColor fromDictionary:dictionary];
        self.labelAligment = [self objectOrNilForKey:kLabelAligment fromDictionary:dictionary];
        self.fontForLabel = [self objectOrNilForKey:kLabelFont fromDictionary:dictionary];
        self.linesOfNum = [self objectOrNilForKey:kLabelLines fromDictionary:dictionary];
        self.shadowColor = [self objectOrNilForKey:kLabelShadowColor fromDictionary:dictionary];
        self.shadowOffSet = [self objectOrNilForKey:kLabelShadowOffSet fromDictionary:dictionary];
        self.sizeForLabelText = [self objectOrNilForKey:kLabelSize fromDictionary:dictionary];
        self.radiesNum = [self objectOrNilForKey:kLabelRadies fromDictionary:dictionary];
        
    }
    return self;
}
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.tag forKey:kLabeltag];
    [mutableDict setValue:self.type forKey:kLabelType];
    [mutableDict setValue:self.xPointOfRect forKey:kLabelCGRectX];
    [mutableDict setValue:self.yPointOfRect forKey:kLabelCGRectY];
    [mutableDict setValue:self.widthOfRect forKey:kLabelCGRectWidth];
    [mutableDict setValue:self.heightOfRect forKey:kLabelCGRectheight];
    [mutableDict setValue:self.RGBRed forKey:kLabelColorRGBRed];
    [mutableDict setValue:self.RGBGreen forKey:kLabelColorRGBGreen];
    [mutableDict setValue:self.RGBBlue forKey:kLabelColorRGBBlue];
    [mutableDict setValue:self.RGB_alpha forKey:kLabelColorRGB_alpha];
    
    [mutableDict setValue:self.textString forKey:kLabelString];
    [mutableDict setValue:self.textColor forKey:kLabelTextColor];
    [mutableDict setValue:self.fontForLabel forKey:kLabelFont];
    [mutableDict setValue:self.linesOfNum forKey:kLabelLines];
    [mutableDict setValue:self.labelAligment forKey:kLabelAligment];
    [mutableDict setValue:self.shadowColor forKey:kLabelShadowColor];
    [mutableDict setValue:self.shadowOffSet forKey:kLabelShadowOffSet];
    [mutableDict setValue:self.sizeForLabelText forKey:kLabelSize];
    [mutableDict setValue:self.radiesNum forKey:kLabelRadies];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}


//添加对输出为字符串的描述
- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end
