//
//  TextFieldOfMapper.m
//  FirstProject
//
//  Created by 传晟 on 14-5-7.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "TextFieldOfMapper.h"
//此处注意不能定制相同的名称 ｜const后的name
NSString *const kTextFieldType = @"type";
NSString *const kTextFieldtag  = @"TkeyOfTag";

NSString *const kTextFieldColorRGBGreen = @"TkeyColorRGB_green";
NSString *const kTextFieldColorRGBRed = @"TkeyColorRGB_red";
NSString *const kTextFieldColorRGBBlue = @"TkeyColorRGB_blue";
NSString *const kTextFieldColorRGB_alpha = @"TkeyColor_alpha";

NSString *const kTextFieldCGRectX = @"TkeyCGRect_x";
NSString *const kTextFieldCGRectY = @"TkeyCGRect_y";
NSString *const kTextFieldCGRectWidth = @"TkeyCGRect_width";
NSString *const kTextFieldCGRectheight = @"TkeyCGRect_height";

NSString *const kTextFieldPlaceHolder = @"TkeyPlaceholder";
NSString *const kTextFieldAligement = @"TkeyAlignment";
NSString *const kTextFieldTextColor =@"TkeyTextColor";
NSString *const kTextFieldFont = @"TkeyFont";
NSString *const kTextFieldFontSize =@"TkeyFontSize";

@interface TextFieldOfMapper ()
@property(nonatomic,strong)CountString *countSting;
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;
@end

@implementation TextFieldOfMapper
+(TextFieldOfMapper *)modelObjectWithDictionary:(NSDictionary *)dictionary{
    TextFieldOfMapper *interface = [[TextFieldOfMapper alloc]initWithDictionary:dictionary];
    return interface;
}

//初始化加载  新的属性也在此添加
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self  = [super init];
    //    NSAttributedString
    //    NSShadowAttributeName
    if (self && [dictionary isKindOfClass:[NSDictionary class]]) {
        _countSting = [[CountString alloc]init];
        
        self.type = [self objectOrNilForKey:kTextFieldType fromDictionary:dictionary];
        self.tag = [self objectOrNilForKey:kTextFieldtag fromDictionary:dictionary];
        NSString *xString = [_countSting getStatement:[self objectOrNilForKey:kTextFieldCGRectX fromDictionary:dictionary]];
        CGFloat rect_x =[_countSting operatorString:xString];
        NSString *yString = [_countSting getStatement:[self objectOrNilForKey:kTextFieldCGRectY fromDictionary:dictionary]];
        CGFloat rect_y =[_countSting operatorString:yString];
        NSString *wString = [_countSting getStatement:[self objectOrNilForKey:kTextFieldCGRectWidth  fromDictionary:dictionary]];
        CGFloat rect_width =[_countSting operatorString:wString];
        NSString *hString = [_countSting getStatement:[self objectOrNilForKey:kTextFieldCGRectheight  fromDictionary:dictionary]];
        CGFloat rect_height =[_countSting operatorString:hString];
        self.xPointOfRect = [NSString stringWithFormat:@"%f",rect_x];
        self.yPointOfRect = [NSString stringWithFormat:@"%f",rect_y];
        self.widthOfRect = [NSString stringWithFormat:@"%f",rect_width];
        self.heightOfRect = [NSString stringWithFormat:@"%f",rect_height];
        
        
        CGFloat fRGBred = [_countSting operatorString:[self objectOrNilForKey:kTextFieldColorRGBRed fromDictionary:dictionary]];
        CGFloat fRGBgreen = [_countSting operatorString:[self objectOrNilForKey:kTextFieldColorRGBGreen fromDictionary:dictionary]];
        CGFloat fRGBblue = [_countSting operatorString:[self objectOrNilForKey:kTextFieldColorRGBBlue  fromDictionary:dictionary]];
        self.RGBRed = [NSString stringWithFormat:@"%f",fRGBred];
        self.RGBGreen = [NSString stringWithFormat:@"%f",fRGBgreen];
        self.RGBBlue = [NSString stringWithFormat:@"%f",fRGBblue];
        self.RGB_alpha = [self objectOrNilForKey:kTextFieldColorRGB_alpha fromDictionary:dictionary];
        
        self.placeHolder = [self objectOrNilForKey:kTextFieldPlaceHolder fromDictionary:dictionary];
        self.aligement = [self objectOrNilForKey:kTextFieldAligement fromDictionary:dictionary];
        self.textColor = [self objectOrNilForKey:kTextFieldTextColor fromDictionary:dictionary];
        self.font = [self objectOrNilForKey:kTextFieldFont fromDictionary:dictionary];
        self.fontSize = [self objectOrNilForKey:kTextFieldFontSize fromDictionary:dictionary];
        
    }
    return self;
}
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.tag forKey:kTextFieldtag];
    [mutableDict setValue:self.type forKey:kTextFieldType];
    [mutableDict setValue:self.xPointOfRect forKey:kTextFieldCGRectX];
    [mutableDict setValue:self.yPointOfRect forKey:kTextFieldCGRectY];
    [mutableDict setValue:self.widthOfRect forKey:kTextFieldCGRectWidth];
    [mutableDict setValue:self.heightOfRect forKey:kTextFieldCGRectheight];
    [mutableDict setValue:self.RGBRed forKey:kTextFieldColorRGBRed];
    [mutableDict setValue:self.RGBGreen forKey:kTextFieldColorRGBGreen];
    [mutableDict setValue:self.RGBBlue forKey:kTextFieldColorRGBBlue];
    [mutableDict setValue:self.RGB_alpha forKey:kTextFieldColorRGB_alpha];
    
    [mutableDict setValue:self.placeHolder forKey:kTextFieldPlaceHolder];
    [mutableDict setValue:self.aligement forKey:kTextFieldAligement];
    [mutableDict setValue:self.textColor forKey:kTextFieldTextColor];
    [mutableDict setValue:self.font forKey:kTextFieldFont];
    [mutableDict setValue:self.fontSize forKey:kTextFieldFontSize];
    
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