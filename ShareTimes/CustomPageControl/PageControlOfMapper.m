//
//  PageControlOfMapper.m
//  FirstProject
//
//  Created by 传晟 on 14-5-6.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "PageControlOfMapper.h"
NSString *const kPageViewType = @"type";
NSString *const kPageViewtag  = @"PkeyOfTag";

NSString *const kPageViewColorRGBGreen = @"PkeyColorRGB_green";
NSString *const kPageViewColorRGBRed = @"PkeyColorRGB_red";
NSString *const kPageViewColorRGBBlue = @"PkeyColorRGB_blue";
NSString *const kPageViewColorRGB_alpha = @"PkeyColor_alpha";

NSString *const kPageViewCGRectX = @"PkeyCGRect_x";
NSString *const kPageViewCGRectY = @"PkeyCGRect_y";
NSString *const kPageViewCGRectWidth = @"PkeyCGRect_width";
NSString *const kPageViewCGRectheight = @"PkeyCGRect_height";

NSString *const kPageViewNumPages = @"PkeyNumOfPages";
NSString *const kPageViewCurrentPage = @"PkeyCurrentPage";
NSString *const kPageViewITcolor = @"PkeyITColor";
NSString *const kPageViewCITcolor = @"PkeyCurrentITColor";
NSString *const kPageViewBackGcolor = @"PkeyBackColor";
NSString *const kPageViewAlpha = @"PkeyAlpha";

@interface PageControlOfMapper ()
@property(nonatomic,strong)CountString *countSting;
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;
@end

@implementation PageControlOfMapper
+(PageControlOfMapper *)modelObjectWithDictionary:(NSDictionary *)dictionary{
    PageControlOfMapper *interface = [[PageControlOfMapper alloc]initWithDictionary:dictionary];
    return interface;
}

//初始化加载  新的属性也在此添加
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self  = [super init];
    //    NSAttributedString
    //    NSShadowAttributeName
    if (self && [dictionary isKindOfClass:[NSDictionary class]]) {
        _countSting = [[CountString alloc]init];
        
        self.type = [self objectOrNilForKey:kPageViewType fromDictionary:dictionary];
        self.tag = [self objectOrNilForKey:kPageViewtag fromDictionary:dictionary];
        NSString *xString = [_countSting getStatement:[self objectOrNilForKey:kPageViewCGRectX fromDictionary:dictionary]];
        CGFloat rect_x =[_countSting operatorString:xString];
        NSString *yString = [_countSting getStatement:[self objectOrNilForKey:kPageViewCGRectY fromDictionary:dictionary]];
        CGFloat rect_y =[_countSting operatorString:yString];
        NSString *wString = [_countSting getStatement:[self objectOrNilForKey:kPageViewCGRectWidth  fromDictionary:dictionary]];
        CGFloat rect_width =[_countSting operatorString:wString];
        NSString *hString = [_countSting getStatement:[self objectOrNilForKey:kPageViewCGRectheight  fromDictionary:dictionary]];
        CGFloat rect_height =[_countSting operatorString:hString];
        self.xPointOfRect = [NSString stringWithFormat:@"%f",rect_x];
        self.yPointOfRect = [NSString stringWithFormat:@"%f",rect_y];
        self.widthOfRect = [NSString stringWithFormat:@"%f",rect_width];
        self.heightOfRect = [NSString stringWithFormat:@"%f",rect_height];
        
        
        CGFloat fRGBred = [_countSting operatorString:[self objectOrNilForKey:kPageViewColorRGBRed fromDictionary:dictionary]];
        CGFloat fRGBgreen = [_countSting operatorString:[self objectOrNilForKey:kPageViewColorRGBGreen fromDictionary:dictionary]];
        CGFloat fRGBblue = [_countSting operatorString:[self objectOrNilForKey:kPageViewColorRGBBlue  fromDictionary:dictionary]];
        self.RGBRed = [NSString stringWithFormat:@"%f",fRGBred];
        self.RGBGreen = [NSString stringWithFormat:@"%f",fRGBgreen];
        self.RGBBlue = [NSString stringWithFormat:@"%f",fRGBblue];
        self.RGB_alpha = [self objectOrNilForKey:kPageViewColorRGB_alpha fromDictionary:dictionary];
        
        self.numOfPages = [self objectOrNilForKey:kPageViewNumPages fromDictionary:dictionary];
        self.currentPage = [self objectOrNilForKey:kPageViewCurrentPage fromDictionary:dictionary];
        self.ITcolor = [self objectOrNilForKey:kPageViewITcolor fromDictionary:dictionary];
        self.currentITcolor = [self objectOrNilForKey:kPageViewCITcolor fromDictionary:dictionary];
        self.backGColor = [self objectOrNilForKey:kPageViewBackGcolor fromDictionary:dictionary];
        self.alpha = [self objectOrNilForKey:kPageViewAlpha fromDictionary:dictionary];
        
    }
    return self;
}
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.tag forKey:kPageViewtag];
    [mutableDict setValue:self.type forKey:kPageViewType];
    [mutableDict setValue:self.xPointOfRect forKey:kPageViewCGRectX];
    [mutableDict setValue:self.yPointOfRect forKey:kPageViewCGRectY];
    [mutableDict setValue:self.widthOfRect forKey:kPageViewCGRectWidth];
    [mutableDict setValue:self.heightOfRect forKey:kPageViewCGRectheight];
    [mutableDict setValue:self.RGBRed forKey:kPageViewColorRGBRed];
    [mutableDict setValue:self.RGBGreen forKey:kPageViewColorRGBGreen];
    [mutableDict setValue:self.RGBBlue forKey:kPageViewColorRGBBlue];
    [mutableDict setValue:self.RGB_alpha forKey:kPageViewColorRGB_alpha];
    
    [mutableDict setValue:self.numOfPages forKeyPath:kPageViewNumPages];
    [mutableDict setValue:self.currentPage forKeyPath:kPageViewCurrentPage];
    [mutableDict setValue:self.ITcolor forKeyPath:kPageViewITcolor];
    [mutableDict setValue:self.currentITcolor forKeyPath:kPageViewCITcolor];
    [mutableDict setValue:self.backGColor forKeyPath:kPageViewBackGcolor];
    [mutableDict setValue:self.alpha forKeyPath:kPageViewAlpha];
    
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
}@end
