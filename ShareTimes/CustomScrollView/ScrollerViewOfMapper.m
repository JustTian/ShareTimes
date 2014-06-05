//
//  ScrollerViewOfMapper.m
//  FirstProject
//
//  Created by 传晟 on 14-5-8.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "ScrollerViewOfMapper.h"
//此处注意不能定制相同的名称 ｜const后的name
NSString *const kSViewType = @"type";
NSString *const kSViewtag  = @"SkeyOfTag";

NSString *const kSViewColorRGBGreen = @"SkeyColorRGB_green";
NSString *const kSViewColorRGBRed = @"SkeyColorRGB_red";
NSString *const kSViewColorRGBBlue = @"SkeyColorRGB_blue";
NSString *const kSViewColorRGB_alpha = @"SkeyColor_alpha";

NSString *const kSViewCGRectX = @"SkeyCGRect_x";
NSString *const kSViewCGRectY = @"SkeyCGRect_y";
NSString *const kSViewCGRectWidth = @"SkeyCGRect_width";
NSString *const kSViewCGRectheight = @"SkeyCGRect_height";

NSString *const kSViewCornerRadies = @"SkeyRadies";
NSString *const kSViewBouces = @"SkeyBounces";
NSString *const kSViewShowsHSI = @"SkeyShowsHSI";
NSString *const kSViewShowsVSI = @"SkeyShowsVSI";
NSString *const kSViewSubViewWiedth = @"SkeySubView_width";
NSString *const kSViewSubViewHeight =@"SkeySubView_height";
NSString *const kSViewNumRow = @"SkeyEveryRow_num";
//NSString *

NSString *const kSViewSubDictionay = @"subItems";

@interface ScrollerViewOfMapper ()
@property(nonatomic,strong)CountString *countSting;
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;
@end

@implementation ScrollerViewOfMapper
+(ScrollerViewOfMapper *)modelObjectWithDictionary:(NSDictionary *)dictionary{
    ScrollerViewOfMapper *interface = [[ScrollerViewOfMapper alloc]initWithDictionary:dictionary];
    return interface;
}

//初始化加载  新的属性也在此添加
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self  = [super init];
    //    NSAttributedString
    //    NSShadowAttributeName
    if (self && [dictionary isKindOfClass:[NSDictionary class]]) {
        _countSting = [[CountString alloc]init];
        
        self.type = [self objectOrNilForKey:kSViewType fromDictionary:dictionary];
        self.tag = [self objectOrNilForKey:kSViewtag fromDictionary:dictionary];
        NSString *xString = [_countSting getStatement:[self objectOrNilForKey:kSViewCGRectX fromDictionary:dictionary]];
        CGFloat rect_x =[_countSting operatorString:xString];
        NSString *yString = [_countSting getStatement:[self objectOrNilForKey:kSViewCGRectY fromDictionary:dictionary]];
        CGFloat rect_y =[_countSting operatorString:yString];
        NSString *wString = [_countSting getStatement:[self objectOrNilForKey:kSViewCGRectWidth  fromDictionary:dictionary]];
        CGFloat rect_width =[_countSting operatorString:wString];
        NSString *hString = [_countSting getStatement:[self objectOrNilForKey:kSViewCGRectheight  fromDictionary:dictionary]];
        CGFloat rect_height =[_countSting operatorString:hString];
        self.xPointOfRect = [NSString stringWithFormat:@"%f",rect_x];
        self.yPointOfRect = [NSString stringWithFormat:@"%f",rect_y];
        self.widthOfRect = [NSString stringWithFormat:@"%f",rect_width];
        self.heightOfRect = [NSString stringWithFormat:@"%f",rect_height];
        
        
        CGFloat fRGBred = [_countSting operatorString:[self objectOrNilForKey:kSViewColorRGBRed fromDictionary:dictionary]];
        CGFloat fRGBgreen = [_countSting operatorString:[self objectOrNilForKey:kSViewColorRGBGreen fromDictionary:dictionary]];
        CGFloat fRGBblue = [_countSting operatorString:[self objectOrNilForKey:kSViewColorRGBBlue  fromDictionary:dictionary]];
        self.RGBRed = [NSString stringWithFormat:@"%f",fRGBred];
        self.RGBGreen = [NSString stringWithFormat:@"%f",fRGBgreen];
        self.RGBBlue = [NSString stringWithFormat:@"%f",fRGBblue];
        self.RGB_alpha = [self objectOrNilForKey:kSViewColorRGB_alpha fromDictionary:dictionary];
        self.cornerRadies = [self objectOrNilForKey:kSViewCornerRadies fromDictionary:dictionary];
        self.bonces =[self objectOrNilForKey:kSViewBouces fromDictionary:dictionary];
        self.showHSI  = [self objectOrNilForKey:kSViewShowsHSI fromDictionary:dictionary];
        self.showVSI = [self objectOrNilForKey:kSViewShowsVSI fromDictionary:dictionary];
        self.widthOfSubView = [self objectOrNilForKey:kSViewSubViewWiedth fromDictionary:dictionary];
        self.heightOfSubView = [self objectOrNilForKey:kSViewSubViewHeight fromDictionary:dictionary];
        self.numOfEvreyRow = [self objectOrNilForKey:kSViewNumRow fromDictionary:dictionary];
        
        self.subDictionary = [self objectOrNilForKey:kSViewSubDictionay fromDictionary:dictionary];
        
    }
    return self;
}
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.tag forKey:kSViewtag];
    [mutableDict setValue:self.type forKey:kSViewType];
    [mutableDict setValue:self.xPointOfRect forKey:kSViewCGRectX];
    [mutableDict setValue:self.yPointOfRect forKey:kSViewCGRectY];
    [mutableDict setValue:self.widthOfRect forKey:kSViewCGRectWidth];
    [mutableDict setValue:self.heightOfRect forKey:kSViewCGRectheight];
    [mutableDict setValue:self.RGBRed forKey:kSViewColorRGBRed];
    [mutableDict setValue:self.RGBGreen forKey:kSViewColorRGBGreen];
    [mutableDict setValue:self.RGBBlue forKey:kSViewColorRGBBlue];
    [mutableDict setValue:self.RGB_alpha forKey:kSViewColorRGB_alpha];
    
    [mutableDict setValue:self.bonces forKeyPath:kSViewBouces];
    [mutableDict setValue:self.showHSI forKeyPath:kSViewShowsHSI];
    [mutableDict setValue:self.showVSI forKeyPath:kSViewShowsVSI];
    [mutableDict setValue:self.widthOfSubView forKeyPath:kSViewSubViewWiedth];
    [mutableDict setValue:self.heightOfSubView forKeyPath:kSViewSubViewHeight];
    [mutableDict setValue:self.numOfEvreyRow forKeyPath:kSViewNumRow];
    
    [mutableDict setValue:self.cornerRadies forKeyPath:kSViewCornerRadies];
    
    [mutableDict setValue:self.subDictionary forKeyPath:kSViewSubDictionay];
    
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
