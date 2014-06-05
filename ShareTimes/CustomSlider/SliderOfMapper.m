//
//  SliderOfMapper.m
//  FirstProject
//
//  Created by 传晟 on 14-5-7.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "SliderOfMapper.h"
NSString *const kSliderType = @"type";
NSString *const kSliderTag  = @"SkeyOfTag";

NSString *const kSliderColorRGBGreen = @"SkeyColorRGB_green";
NSString *const kSliderColorRGBRed = @"SkeyColorRGB_red";
NSString *const kSliderColorRGBBlue = @"SkeyColorRGB_blue";
NSString *const kSliderColorRGB_alpha = @"SkeyColor_alpha";

NSString *const kSliderCGRectX = @"SkeyCGRect_x";
NSString *const kSliderCGRectY = @"SkeyCGRect_y";
NSString *const kSliderCGRectWidth = @"SkeyCGRect_width";
NSString *const kSliderCGRectheight = @"SkeyCGRect_height";

NSString *const kSliderIsPicture = @"SkeyIsPicture";
NSString *const kSliderItems = @"SkeyItems";
NSString *const kSliderMiniValue = @"SkeyMiniValue";
NSString *const kSliderMaxiValue = @"SkeyMaxiValue";
NSString *const kSliderCurrentValue =@"SkeyValue";

NSString *const kSliderThumbImage = @"SkeyThumbImage";

@interface SliderOfMapper ()
@property(nonatomic,strong)CountString *countSting;
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;
@end

@implementation SliderOfMapper
+(SliderOfMapper *)modelObjectWithDictionary:(NSDictionary *)dictionary{
    SliderOfMapper *interface = [[SliderOfMapper alloc]initWithDictionary:dictionary];
    return interface;
}

//初始化加载  新的属性也在此添加
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self  = [super init];
    //    NSAttributedString
    //    NSShadowAttributeName
    if (self && [dictionary isKindOfClass:[NSDictionary class]]) {
        _countSting = [[CountString alloc]init];
        
        self.type = [self objectOrNilForKey:kSliderType fromDictionary:dictionary];
        self.tag = [self objectOrNilForKey:kSliderTag fromDictionary:dictionary];
        NSString *xString = [_countSting getStatement:[self objectOrNilForKey:kSliderCGRectX fromDictionary:dictionary]];
        CGFloat rect_x =[_countSting operatorString:xString];
        NSString *yString = [_countSting getStatement:[self objectOrNilForKey:kSliderCGRectY fromDictionary:dictionary]];
        CGFloat rect_y =[_countSting operatorString:yString];
        NSString *wString = [_countSting getStatement:[self objectOrNilForKey:kSliderCGRectWidth  fromDictionary:dictionary]];
        CGFloat rect_width =[_countSting operatorString:wString];
        NSString *hString = [_countSting getStatement:[self objectOrNilForKey:kSliderCGRectheight  fromDictionary:dictionary]];
        CGFloat rect_height =[_countSting operatorString:hString];
        self.xPointOfRect = [NSString stringWithFormat:@"%f",rect_x];
        self.yPointOfRect = [NSString stringWithFormat:@"%f",rect_y];
        self.widthOfRect = [NSString stringWithFormat:@"%f",rect_width];
        self.heightOfRect = [NSString stringWithFormat:@"%f",rect_height];
        
        
        CGFloat fRGBred = [_countSting operatorString:[self objectOrNilForKey:kSliderColorRGBRed fromDictionary:dictionary]];
        CGFloat fRGBgreen = [_countSting operatorString:[self objectOrNilForKey:kSliderColorRGBGreen fromDictionary:dictionary]];
        CGFloat fRGBblue = [_countSting operatorString:[self objectOrNilForKey:kSliderColorRGBBlue  fromDictionary:dictionary]];
        self.RGBRed = [NSString stringWithFormat:@"%f",fRGBred];
        self.RGBGreen = [NSString stringWithFormat:@"%f",fRGBgreen];
        self.RGBBlue = [NSString stringWithFormat:@"%f",fRGBblue];
        self.RGB_alpha = [self objectOrNilForKey:kSliderColorRGB_alpha fromDictionary:dictionary];
        
        self.isPicture = [self objectOrNilForKey:kSliderIsPicture fromDictionary:dictionary];
        self.items = [self objectOrNilForKey:kSliderItems fromDictionary:dictionary];
        self.miniValue = [self objectOrNilForKey:kSliderMiniValue fromDictionary:dictionary];
        self.maxiValue = [self objectOrNilForKey:kSliderMaxiValue fromDictionary:dictionary];
        self.currentValue = [self objectOrNilForKey:kSliderCurrentValue fromDictionary:dictionary];
        
        self.thumbImageName = [self objectOrNilForKey:kSliderThumbImage fromDictionary:dictionary];
        
//        NSDictionary *sDic = [self objectOrNilForKey:kSliderItems fromDictionary:dictionary];
//        NSMutableArray *mArray = [[NSMutableArray alloc]initWithCapacity:10];
//        for (int i = 0; i<[sDic.allKeys count]; i++) {
//            if ([[dictionary.allKeys objectAtIndex:i]isEqualToString:@"minimumValueInage"]) {
//                NSString *nameImage = [dictionary objectForKey:@"minimumValueInage"];
//                UIImage *image = [UIImage imageNamed:nameImage];
//                [mArray addObject:image];
//
//            }
//            if ([[dictionary.allKeys objectAtIndex:i]isEqualToString:@"maximumValueImage"]) {
//                NSString *nameImage = [dictionary objectForKey:@"maximumValueImage"];
//                UIImage *image = [UIImage imageNamed:nameImage];
//                [mArray addObject:image];
//            }
//        }
        
            
    }
    return self;
}
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.tag forKey:kSliderTag];
    [mutableDict setValue:self.type forKey:kSliderType];
    [mutableDict setValue:self.xPointOfRect forKey:kSliderCGRectX];
    [mutableDict setValue:self.yPointOfRect forKey:kSliderCGRectY];
    [mutableDict setValue:self.widthOfRect forKey:kSliderCGRectWidth];
    [mutableDict setValue:self.heightOfRect forKey:kSliderCGRectheight];
    [mutableDict setValue:self.RGBRed forKey:kSliderColorRGBRed];
    [mutableDict setValue:self.RGBGreen forKey:kSliderColorRGBGreen];
    [mutableDict setValue:self.RGBBlue forKey:kSliderColorRGBBlue];
    [mutableDict setValue:self.RGB_alpha forKey:kSliderColorRGB_alpha];
    [mutableDict setValue:self.thumbImageName forKey:kSliderThumbImage];
    
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