//
//  TableOfMapper.m
//  shiyan4
//
//  Created by 传晟 on 14-4-24.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "TableOfMapper.h"
#import "CountString.h"

NSString * kType = @"type";
NSString * ktag  = @"TkeyOfTag";

NSString * kColorRGBGreen = @"TkeyColorRGB_green";
NSString * kColorRGBRed = @"TkeyColorRGB_red";
NSString * kColorRGBBlue = @"TkeyColorRGB_blue";
NSString * kColorRGB_alpha = @"TkeyColor_alpha";

NSString * kCGRectX = @"TkeyCGRect_x";
NSString * kCGRectY = @"TkeyCGRect_y";
NSString * kCGRectWidth = @"TkeyCGRect_width";
NSString * kCGRectheight = @"TkeyCGRect_height";

NSString * kTCStyle = @"TkeyTableViewStyle";
NSString * kIsCustomCell = @"TkeyIsCustomCell";

@interface TableOfMapper ()
@property(nonatomic,strong)CountString *countSting;
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;
@end

@implementation TableOfMapper
+(TableOfMapper *)modelObjectWithDictionary:(NSDictionary *)dictionary{
    TableOfMapper *interface = [[TableOfMapper alloc]initWithDictionary:dictionary];
    return interface;
}

//初始化加载  新的属性也在此添加
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self  = [super init];
    if (self && [dictionary isKindOfClass:[NSDictionary class]]) {
        _countSting = [[CountString alloc]init];
        
        self.type = [self objectOrNilForKey:kType fromDictionary:dictionary];
        self.tag = [self objectOrNilForKey:ktag fromDictionary:dictionary];
        NSString *xString = [_countSting getStatement:[self objectOrNilForKey:kCGRectX fromDictionary:dictionary]];
        CGFloat rect_x =[_countSting operatorString:xString];
        NSString *yString = [_countSting getStatement:[self objectOrNilForKey:kCGRectY fromDictionary:dictionary]];
        CGFloat rect_y =[_countSting operatorString:yString];
        NSString *wString = [_countSting getStatement:[self objectOrNilForKey:kCGRectWidth  fromDictionary:dictionary]];
        CGFloat rect_width =[_countSting operatorString:wString];
        NSString *hString = [_countSting getStatement:[self objectOrNilForKey:kCGRectheight  fromDictionary:dictionary]];
        CGFloat rect_height =[_countSting operatorString:hString];
        self.xPointOfRect = [NSString stringWithFormat:@"%f",rect_x];
        self.yPointOfRect = [NSString stringWithFormat:@"%f",rect_y];
        self.widthOfRect = [NSString stringWithFormat:@"%f",rect_width];
        self.heightOfRect = [NSString stringWithFormat:@"%f",rect_height];
        
        
        CGFloat fRGBred = [_countSting operatorString:[self objectOrNilForKey:kColorRGBRed fromDictionary:dictionary]];
        CGFloat fRGBgreen = [_countSting operatorString:[self objectOrNilForKey:kColorRGBGreen fromDictionary:dictionary]];
        CGFloat fRGBblue = [_countSting operatorString:[self objectOrNilForKey:kColorRGBBlue  fromDictionary:dictionary]];
        self.RGBRed = [NSString stringWithFormat:@"%f",fRGBred];
        self.RGBGreen = [NSString stringWithFormat:@"%f",fRGBgreen];
        self.RGBBlue = [NSString stringWithFormat:@"%f",fRGBblue];
        self.RGB_alpha = [self objectOrNilForKey:kColorRGB_alpha fromDictionary:dictionary];
        
        NSInteger wInteger = [[self objectOrNilForKey:kTCStyle fromDictionary:dictionary] integerValue];
        self.tableViewStyle =[self tableViewStyleFromJSON:wInteger];
        
        self.isCustomCell = [self objectOrNilForKey:kIsCustomCell fromDictionary:dictionary];
    }
    return self;
}
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.tag forKey:ktag];
    [mutableDict setValue:self.type forKey:kType];
    [mutableDict setValue:self.xPointOfRect forKey:kCGRectX];
    [mutableDict setValue:self.yPointOfRect forKey:kCGRectY];
    [mutableDict setValue:self.widthOfRect forKey:kCGRectWidth];
    [mutableDict setValue:self.heightOfRect forKey:kCGRectheight];
    [mutableDict setValue:self.RGBRed forKey:kColorRGBRed];
    [mutableDict setValue:self.RGBGreen forKey:kColorRGBGreen];
    [mutableDict setValue:self.RGBBlue forKey:kColorRGBBlue];
    [mutableDict setValue:self.RGB_alpha forKey:kColorRGB_alpha];
    [mutableDict setValue:[NSNumber numberWithInteger:self.tableViewStyle] forKey:kTCStyle];
    [mutableDict setObject:self.isCustomCell forKey:kIsCustomCell];
    
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
//解析json文件关于设置表视图的风格
-(UITableViewStyle)tableViewStyleFromJSON:(NSInteger)integer{
    UITableViewStyle TVStyle = UITableViewStylePlain;
    if (integer != 0) {
        TVStyle = UITableViewStyleGrouped;
    }
    return TVStyle;
}
@end
