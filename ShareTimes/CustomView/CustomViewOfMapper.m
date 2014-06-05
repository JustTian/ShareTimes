//
//  CustomViewOfMapper.m
//  FirstProject
//
//  Created by 传晟 on 14-5-3.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "CustomViewOfMapper.h"
//此处注意不能定制相同的名称 ｜const后的name
NSString *const kCViewType = @"type";
NSString *const kCViewtag  = @"CkeyOfTag";

NSString *const kCViewColorRGBGreen = @"CkeyColorRGB_green";
NSString *const kCViewColorRGBRed = @"CkeyColorRGB_red";
NSString *const kCViewColorRGBBlue = @"CkeyColorRGB_blue";
NSString *const kCViewColorRGB_alpha = @"CkeyColor_alpha";

NSString *const kCViewCGRectX = @"CkeyCGRect_x";
NSString *const kCViewCGRectY = @"CkeyCGRect_y";
NSString *const kCViewCGRectWidth = @"CkeyCGRect_width";
NSString *const kCViewCGRectheight = @"CkeyCGRect_height";

NSString *const kCViewCornerRadies = @"CkeyRadies";

NSString *const kCViewSubDictionay = @"subItems";

@interface CustomViewOfMapper ()
@property(nonatomic,strong)CountString *countSting;
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;
@end

@implementation CustomViewOfMapper
+(CustomViewOfMapper *)modelObjectWithDictionary:(NSDictionary *)dictionary{
    CustomViewOfMapper *interface = [[CustomViewOfMapper alloc]initWithDictionary:dictionary];
    return interface;
}

//初始化加载  新的属性也在此添加
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self  = [super init];
//    NSAttributedString
//    NSShadowAttributeName
    if (self && [dictionary isKindOfClass:[NSDictionary class]]) {
        _countSting = [[CountString alloc]init];
        
        self.type = [self objectOrNilForKey:kCViewType fromDictionary:dictionary];
        self.tag = [self objectOrNilForKey:kCViewtag fromDictionary:dictionary];
        NSString *xString = [_countSting getStatement:[self objectOrNilForKey:kCViewCGRectX fromDictionary:dictionary]];
        CGFloat rect_x =[_countSting operatorString:xString];
        NSString *yString = [_countSting getStatement:[self objectOrNilForKey:kCViewCGRectY fromDictionary:dictionary]];
        CGFloat rect_y =[_countSting operatorString:yString];
        NSString *wString = [_countSting getStatement:[self objectOrNilForKey:kCViewCGRectWidth  fromDictionary:dictionary]];
        CGFloat rect_width =[_countSting operatorString:wString];
        NSString *hString = [_countSting getStatement:[self objectOrNilForKey:kCViewCGRectheight  fromDictionary:dictionary]];
        CGFloat rect_height =[_countSting operatorString:hString];
        self.xPointOfRect = [NSString stringWithFormat:@"%f",rect_x];
        self.yPointOfRect = [NSString stringWithFormat:@"%f",rect_y];
        self.widthOfRect = [NSString stringWithFormat:@"%f",rect_width];
        self.heightOfRect = [NSString stringWithFormat:@"%f",rect_height];
        
        
        CGFloat fRGBred = [_countSting operatorString:[self objectOrNilForKey:kCViewColorRGBRed fromDictionary:dictionary]];
        CGFloat fRGBgreen = [_countSting operatorString:[self objectOrNilForKey:kCViewColorRGBGreen fromDictionary:dictionary]];
        CGFloat fRGBblue = [_countSting operatorString:[self objectOrNilForKey:kCViewColorRGBBlue  fromDictionary:dictionary]];
        self.RGBRed = [NSString stringWithFormat:@"%f",fRGBred];
        self.RGBGreen = [NSString stringWithFormat:@"%f",fRGBgreen];
        self.RGBBlue = [NSString stringWithFormat:@"%f",fRGBblue];
        self.RGB_alpha = [self objectOrNilForKey:kCViewColorRGB_alpha fromDictionary:dictionary];
        self.cornerRadies = [self objectOrNilForKey:kCViewCornerRadies fromDictionary:dictionary];
        
        self.subDictionary = [self objectOrNilForKey:kCViewSubDictionay fromDictionary:dictionary];
        
    }
    return self;
}
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.tag forKey:kCViewtag];
    [mutableDict setValue:self.type forKey:kCViewType];
    [mutableDict setValue:self.xPointOfRect forKey:kCViewCGRectX];
    [mutableDict setValue:self.yPointOfRect forKey:kCViewCGRectY];
    [mutableDict setValue:self.widthOfRect forKey:kCViewCGRectWidth];
    [mutableDict setValue:self.heightOfRect forKey:kCViewCGRectheight];
    [mutableDict setValue:self.RGBRed forKey:kCViewColorRGBRed];
    [mutableDict setValue:self.RGBGreen forKey:kCViewColorRGBGreen];
    [mutableDict setValue:self.RGBBlue forKey:kCViewColorRGBBlue];
    [mutableDict setValue:self.RGB_alpha forKey:kCViewColorRGB_alpha];
    
    [mutableDict setValue:self.cornerRadies forKeyPath:kCViewCornerRadies];
    
    [mutableDict setValue:self.subDictionary forKeyPath:kCViewSubDictionay];
    
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
