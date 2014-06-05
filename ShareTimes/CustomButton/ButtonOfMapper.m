//
//  ButtonOfMapper.m
//  FirstProject
//
//  Created by 传晟 on 14-4-29.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "ButtonOfMapper.h"


NSString *const kButtonType = @"type";
NSString *const kButtontag  = @"BkeyOfTag";

NSString *const kButtonColorRGBGreen = @"BkeyColorRGB_green";
NSString *const kButtonColorRGBRed = @"BkeyColorRGB_red";
NSString *const kButtonColorRGBBlue = @"BkeyColorRGB_blue";
NSString *const kButtonColorRGB_alpha = @"BkeyColor_alpha";

NSString *const kButtonCGRectX = @"BkeyCGRect_x";
NSString *const kButtonCGRectY = @"BkeyCGRect_y";
NSString *const kButtonCGRectWidth = @"BkeyCGRect_width";
NSString *const kButtonCGRectheight = @"BkeyCGRect_height";

NSString *const kButtonNumOfType = @"BkeyNumOfType";
NSString *const kButtonRadies = @"BkeyNumOfRadius";
NSString *const kButtonIsImage = @"BkeyIsImage";
NSString *const kButtonImageName = @"BkeyOfImageName";
NSString *const kButtonLabelText = @"BkeyNameOfText";
NSString *const kButtonClick = @"BkeyOfClick";
NSString *const kButtonAlignment = @"BkeyAlignment";
NSString *const kButtonTextFont = @"BkeyFont";
NSString *const kButtonTextSize = @"BkeyTextSize";
@interface ButtonOfMapper ()
@property(nonatomic,strong)CountString *countSting;
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;
@end

@implementation ButtonOfMapper
+(ButtonOfMapper *)modelObjectWithDictionary:(NSDictionary *)dictionary{
    ButtonOfMapper *interface = [[ButtonOfMapper alloc]initWithDictionary:dictionary];
    return interface;
}

//初始化加载  新的属性也在此添加
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self  = [super init];
    if (self && [dictionary isKindOfClass:[NSDictionary class]]) {
        _countSting = [[CountString alloc]init];
        
        self.type = [self objectOrNilForKey:kButtonType fromDictionary:dictionary];
        self.tag = [self objectOrNilForKey:kButtontag fromDictionary:dictionary];
        NSString *xString = [_countSting getStatement:[self objectOrNilForKey:kButtonCGRectX fromDictionary:dictionary]];
        CGFloat rect_x =[_countSting operatorString:xString];
        NSString *yString = [_countSting getStatement:[self objectOrNilForKey:kButtonCGRectY fromDictionary:dictionary]];
        CGFloat rect_y =[_countSting operatorString:yString];
        NSString *wString = [_countSting getStatement:[self objectOrNilForKey:kButtonCGRectWidth  fromDictionary:dictionary]];
        CGFloat rect_width =[_countSting operatorString:wString];
        NSString *hString = [_countSting getStatement:[self objectOrNilForKey:kButtonCGRectheight  fromDictionary:dictionary]];
        CGFloat rect_height =[_countSting operatorString:hString];
        self.xPointOfRect = [NSString stringWithFormat:@"%f",rect_x];
        self.yPointOfRect = [NSString stringWithFormat:@"%f",rect_y];
        self.widthOfRect = [NSString stringWithFormat:@"%f",rect_width];
        self.heightOfRect = [NSString stringWithFormat:@"%f",rect_height];
        
        
        CGFloat fRGBred = [_countSting operatorString:[self objectOrNilForKey:kButtonColorRGBRed fromDictionary:dictionary]];
        CGFloat fRGBgreen = [_countSting operatorString:[self objectOrNilForKey:kButtonColorRGBGreen fromDictionary:dictionary]];
        CGFloat fRGBblue = [_countSting operatorString:[self objectOrNilForKey:kButtonColorRGBBlue  fromDictionary:dictionary]];
        self.RGBRed = [NSString stringWithFormat:@"%f",fRGBred];
        self.RGBGreen = [NSString stringWithFormat:@"%f",fRGBgreen];
        self.RGBBlue = [NSString stringWithFormat:@"%f",fRGBblue];
        self.RGB_alpha = [self objectOrNilForKey:kButtonColorRGB_alpha fromDictionary:dictionary];
        
        self.numOfType = [self objectOrNilForKey:kButtonNumOfType fromDictionary:dictionary];
        self.numOfRadies = [self objectOrNilForKey:kButtonRadies fromDictionary:dictionary];
        self.nameOfText = [self objectOrNilForKey:kButtonLabelText fromDictionary:dictionary];
        self.textFont = [self objectOrNilForKey:kButtonTextFont fromDictionary:dictionary];
        self.textSize = [self objectOrNilForKey:kButtonTextSize fromDictionary:dictionary];
        self.alignmentType = [self objectOrNilForKey:kButtonAlignment fromDictionary:dictionary];
        self.isImage = [self objectOrNilForKey:kButtonIsImage fromDictionary:dictionary];
        self.imageName = [self objectOrNilForKey:kButtonImageName fromDictionary:dictionary];
        self.clickNum = [self objectOrNilForKey:kButtonClick fromDictionary:dictionary];
    
    }
    return self;
}
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.tag forKey:kButtontag];
    [mutableDict setValue:self.type forKey:kButtonType];
    [mutableDict setValue:self.xPointOfRect forKey:kButtonCGRectX];
    [mutableDict setValue:self.yPointOfRect forKey:kButtonCGRectY];
    [mutableDict setValue:self.widthOfRect forKey:kButtonCGRectWidth];
    [mutableDict setValue:self.heightOfRect forKey:kButtonCGRectheight];
    [mutableDict setValue:self.RGBRed forKey:kButtonColorRGBRed];
    [mutableDict setValue:self.RGBGreen forKey:kButtonColorRGBGreen];
    [mutableDict setValue:self.RGBBlue forKey:kButtonColorRGBBlue];
    [mutableDict setValue:self.RGB_alpha forKey:kButtonColorRGB_alpha];
    [mutableDict setValue:self.numOfType forKey:kButtonNumOfType];
    [mutableDict setValue:self.numOfRadies forKey:kButtonRadies];
    [mutableDict setValue:self.nameOfText forKey:kButtonLabelText];
    [mutableDict setValue:self.textFont forKey:kButtonTextFont];
    [mutableDict setValue:self.alignmentType forKey:kButtonAlignment];
    [mutableDict setValue:self.isImage forKey:kButtonIsImage];
    [mutableDict setValue:self.imageName forKey:kButtonImageName];
    [mutableDict setValue:self.clickNum forKey:kButtonClick];
    [mutableDict setValue:self.textSize forKeyPath:kButtonTextSize];
    
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