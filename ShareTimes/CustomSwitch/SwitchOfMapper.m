//
//  SwitchOfMapper.m
//  FirstProject
//
//  Created by 传晟 on 14-5-7.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "SwitchOfMapper.h"
NSString *const kSwitchType = @"type";
NSString *const kSwitchtag  = @"SkeyOfTag";

NSString *const kSwitchColorRGBGreen = @"SkeyColorRGB_green";
NSString *const kSwitchColorRGBRed = @"SkeyColorRGB_red";
NSString *const kSwitchColorRGBBlue = @"SkeyColorRGB_blue";
NSString *const kSwitchColorRGB_alpha = @"SkeyColor_alpha";

NSString *const kSwitchCGRectX = @"SkeyCGRect_x";
NSString *const kSwitchCGRectY = @"SkeyCGRect_y";
NSString *const kSwitchCGRectWidth = @"SkeyCGRect_width";
NSString *const kSwitchCGRectheight = @"SkeyCGRect_height";

NSString *const kSwitchIsOn = @"SkeyIsOn";
NSString *const kSwitchIsRound =@"SkeyIsRound";
NSString *const kSwitchInactiveColor =@"SkeyInactiveColor";
NSString *const kSwitchActiveColor =@"SkeyActiveColor";
NSString *const kSwitchOnColor =@"SkeyOncolor";
NSString *const kSwitchBorderColor =@"SkeyBorderColor";
NSString *const kSwitchShadowColor =@"SkeyShadowColor";
NSString *const kSwitchIsImage = @"SkeyIsImage";
NSString *const kSwitchOnImage =@"SkeyOnImage";
NSString *const kSwitchOffImage =@"SkeyOffImage";

@interface SwitchOfMapper ()
@property(nonatomic,strong)CountString *countSting;
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;
@end

@implementation SwitchOfMapper
+(SwitchOfMapper *)modelObjectWithDictionary:(NSDictionary *)dictionary{
    SwitchOfMapper *interface = [[SwitchOfMapper alloc]initWithDictionary:dictionary];
    return interface;
}

//初始化加载  新的属性也在此添加
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self  = [super init];
    //    NSAttributedString
    //    NSShadowAttributeName
    if (self && [dictionary isKindOfClass:[NSDictionary class]]) {
        _countSting = [[CountString alloc]init];
        
        self.type = [self objectOrNilForKey:kSwitchType fromDictionary:dictionary];
        self.tag = [self objectOrNilForKey:kSwitchtag fromDictionary:dictionary];
        NSString *xString = [_countSting getStatement:[self objectOrNilForKey:kSwitchCGRectX fromDictionary:dictionary]];
        CGFloat rect_x =[_countSting operatorString:xString];
        NSString *yString = [_countSting getStatement:[self objectOrNilForKey:kSwitchCGRectY fromDictionary:dictionary]];
        CGFloat rect_y =[_countSting operatorString:yString];
        NSString *wString = [_countSting getStatement:[self objectOrNilForKey:kSwitchCGRectWidth  fromDictionary:dictionary]];
        CGFloat rect_width =[_countSting operatorString:wString];
        NSString *hString = [_countSting getStatement:[self objectOrNilForKey:kSwitchCGRectheight  fromDictionary:dictionary]];
        CGFloat rect_height =[_countSting operatorString:hString];
        self.xPointOfRect = [NSString stringWithFormat:@"%f",rect_x];
        self.yPointOfRect = [NSString stringWithFormat:@"%f",rect_y];
        self.widthOfRect = [NSString stringWithFormat:@"%f",rect_width];
        self.heightOfRect = [NSString stringWithFormat:@"%f",rect_height];
        
        
        CGFloat fRGBred = [_countSting operatorString:[self objectOrNilForKey:kSwitchColorRGBRed fromDictionary:dictionary]];
        CGFloat fRGBgreen = [_countSting operatorString:[self objectOrNilForKey:kSwitchColorRGBGreen fromDictionary:dictionary]];
        CGFloat fRGBblue = [_countSting operatorString:[self objectOrNilForKey:kSwitchColorRGBBlue  fromDictionary:dictionary]];
        self.RGBRed = [NSString stringWithFormat:@"%f",fRGBred];
        self.RGBGreen = [NSString stringWithFormat:@"%f",fRGBgreen];
        self.RGBBlue = [NSString stringWithFormat:@"%f",fRGBblue];
        self.RGB_alpha = [self objectOrNilForKey:kSwitchColorRGB_alpha fromDictionary:dictionary];
        
        self.isOn = [self objectOrNilForKey:kSwitchIsOn fromDictionary:dictionary];
        self.isRound = [self objectOrNilForKey:kSwitchIsRound fromDictionary:dictionary];
        self.inactiveColor = [self objectOrNilForKey:kSwitchInactiveColor fromDictionary:dictionary];
        self.activeColor = [self objectOrNilForKey:kSwitchActiveColor fromDictionary:dictionary];
        self.onColor = [self objectOrNilForKey:kSwitchOnColor fromDictionary:dictionary];
        self.borderColor = [self objectOrNilForKey:kSwitchBorderColor fromDictionary:dictionary];
        self.shadowColor = [self objectOrNilForKey:kSwitchShadowColor fromDictionary:dictionary];
        self.isImage = [self objectOrNilForKey:kSwitchIsImage fromDictionary:dictionary];
        self.onImage = [self objectOrNilForKey:kSwitchOnImage fromDictionary:dictionary];
        self.offImage = [self objectOrNilForKey:kSwitchOffImage fromDictionary:dictionary];
        
    }
    return self;
}
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.tag forKey:kSwitchtag];
    [mutableDict setValue:self.type forKey:kSwitchType];
    [mutableDict setValue:self.xPointOfRect forKey:kSwitchCGRectX];
    [mutableDict setValue:self.yPointOfRect forKey:kSwitchCGRectY];
    [mutableDict setValue:self.widthOfRect forKey:kSwitchCGRectWidth];
    [mutableDict setValue:self.heightOfRect forKey:kSwitchCGRectheight];
    [mutableDict setValue:self.RGBRed forKey:kSwitchColorRGBRed];
    [mutableDict setValue:self.RGBGreen forKey:kSwitchColorRGBGreen];
    [mutableDict setValue:self.RGBBlue forKey:kSwitchColorRGBBlue];
    [mutableDict setValue:self.RGB_alpha forKey:kSwitchColorRGB_alpha];
    
    [mutableDict setValue:self.isOn forKey:kSwitchIsOn];
    [mutableDict setValue:self.isRound forKey:kSwitchIsRound];
    [mutableDict setValue:self.inactiveColor forKey:kSwitchInactiveColor];
    [mutableDict setValue:self.activeColor forKey:kSwitchActiveColor];
    [mutableDict setValue:self.onColor forKey:kSwitchOnColor];
    [mutableDict setValue:self.borderColor forKey:kSwitchBorderColor];
    [mutableDict setValue:self.shadowColor forKey:kSwitchShadowColor];
    [mutableDict setValue:self.isImage forKey:kSwitchIsImage];
    [mutableDict setValue:self.onImage forKey:kSwitchOnImage];
    [mutableDict setValue:self.offImage forKey:kSwitchOffImage];
    
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
