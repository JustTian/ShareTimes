//
//  TextViewOfMapper.m
//  ShareTimes
//
//  Created by 传晟 on 14-6-22.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "TextViewOfMapper.h"
NSString *const kTextViewType = @"type";
NSString *const kTextViewtag  = @"TkeyOfTag";

NSString *const kTextViewColorRGBGreen = @"TkeyColorRGB_green";
NSString *const kTextViewColorRGBRed = @"TkeyColorRGB_red";
NSString *const kTextViewColorRGBBlue = @"TkeyColorRGB_blue";
NSString *const kTextViewColorRGB_alpha = @"TkeyColor_alpha";

NSString *const kTextViewCGRectX = @"TkeyCGRect_x";
NSString *const kTextViewCGRectY = @"TkeyCGRect_y";
NSString *const kTextViewCGRectWidth = @"TkeyCGRect_width";
NSString *const kTextViewCGRectheight = @"TkeyCGRect_height";

NSString *const kTextViewPlaceHolder = @"TkeyPlaceholder";
NSString *const kTextViewAligement = @"TkeyAlignment";
NSString *const kTextViewTextColor =@"TkeyTextColor";
NSString *const kTextViewFont = @"TkeyFont";
NSString *const kTextViewFontSize =@"TkeyFontSize";

@interface TextViewOfMapper ()
@property(nonatomic,strong)CountString *countSting;
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;
@end

@implementation TextViewOfMapper
+(TextViewOfMapper *)modelObjectWithDictionary:(NSDictionary *)dictionary{
    TextViewOfMapper *interface = [[TextViewOfMapper alloc]initWithDictionary:dictionary];
    return interface;
}

//初始化加载  新的属性也在此添加
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self  = [super init];
    //    NSAttributedString
    //    NSShadowAttributeName
    if (self && [dictionary isKindOfClass:[NSDictionary class]]) {
        _countSting = [[CountString alloc]init];
        
        self.type = [self objectOrNilForKey:kTextViewType fromDictionary:dictionary];
        self.tag = [self objectOrNilForKey:kTextViewtag fromDictionary:dictionary];
        NSString *xString = [_countSting getStatement:[self objectOrNilForKey:kTextViewCGRectX fromDictionary:dictionary]];
        CGFloat rect_x =[_countSting operatorString:xString];
        NSString *yString = [_countSting getStatement:[self objectOrNilForKey:kTextViewCGRectY fromDictionary:dictionary]];
        CGFloat rect_y =[_countSting operatorString:yString];
        NSString *wString = [_countSting getStatement:[self objectOrNilForKey:kTextViewCGRectWidth  fromDictionary:dictionary]];
        CGFloat rect_width =[_countSting operatorString:wString];
        NSString *hString = [_countSting getStatement:[self objectOrNilForKey:kTextViewCGRectheight  fromDictionary:dictionary]];
        CGFloat rect_height =[_countSting operatorString:hString];
        self.xPointOfRect = [NSString stringWithFormat:@"%f",rect_x];
        self.yPointOfRect = [NSString stringWithFormat:@"%f",rect_y];
        self.widthOfRect = [NSString stringWithFormat:@"%f",rect_width];
        self.heightOfRect = [NSString stringWithFormat:@"%f",rect_height];
        
        
        CGFloat fRGBred = [_countSting operatorString:[self objectOrNilForKey:kTextViewColorRGBRed fromDictionary:dictionary]];
        CGFloat fRGBgreen = [_countSting operatorString:[self objectOrNilForKey:kTextViewColorRGBGreen fromDictionary:dictionary]];
        CGFloat fRGBblue = [_countSting operatorString:[self objectOrNilForKey:kTextViewColorRGBBlue  fromDictionary:dictionary]];
        self.RGBRed = [NSString stringWithFormat:@"%f",fRGBred];
        self.RGBGreen = [NSString stringWithFormat:@"%f",fRGBgreen];
        self.RGBBlue = [NSString stringWithFormat:@"%f",fRGBblue];
        self.RGB_alpha = [self objectOrNilForKey:kTextViewColorRGB_alpha fromDictionary:dictionary];
        
        self.placeHolder = [self objectOrNilForKey:kTextViewPlaceHolder fromDictionary:dictionary];
        self.aligement = [self objectOrNilForKey:kTextViewAligement fromDictionary:dictionary];
        self.textColor = [self objectOrNilForKey:kTextViewTextColor fromDictionary:dictionary];
        self.font = [self objectOrNilForKey:kTextViewFont fromDictionary:dictionary];
        self.fontSize = [self objectOrNilForKey:kTextViewFontSize fromDictionary:dictionary];
        
    }
    return self;
}
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.tag forKey:kTextViewtag];
    [mutableDict setValue:self.type forKey:kTextViewType];
    [mutableDict setValue:self.xPointOfRect forKey:kTextViewCGRectX];
    [mutableDict setValue:self.yPointOfRect forKey:kTextViewCGRectY];
    [mutableDict setValue:self.widthOfRect forKey:kTextViewCGRectWidth];
    [mutableDict setValue:self.heightOfRect forKey:kTextViewCGRectheight];
    [mutableDict setValue:self.RGBRed forKey:kTextViewColorRGBRed];
    [mutableDict setValue:self.RGBGreen forKey:kTextViewColorRGBGreen];
    [mutableDict setValue:self.RGBBlue forKey:kTextViewColorRGBBlue];
    [mutableDict setValue:self.RGB_alpha forKey:kTextViewColorRGB_alpha];
    
    [mutableDict setValue:self.placeHolder forKey:kTextViewPlaceHolder];
    [mutableDict setValue:self.aligement forKey:kTextViewAligement];
    [mutableDict setValue:self.textColor forKey:kTextViewTextColor];
    [mutableDict setValue:self.font forKey:kTextViewFont];
    [mutableDict setValue:self.fontSize forKey:kTextViewFontSize];
    
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
