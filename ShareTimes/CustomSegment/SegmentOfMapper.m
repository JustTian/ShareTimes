//
//  SegmentOfMapper.m
//  FirstProject
//
//  Created by 传晟 on 14-5-6.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "SegmentOfMapper.h"
NSString *const kSegmentType = @"type";
NSString *const kSegmentTag  = @"SkeyOfTag";

NSString *const kSegmentColorRGBGreen = @"SkeyColorRGB_green";
NSString *const kSegmentColorRGBRed = @"SkeyColorRGB_red";
NSString *const kSegmentColorRGBBlue = @"SkeyColorRGB_blue";
NSString *const kSegmentColorRGB_alpha = @"SkeyColor_alpha";

NSString *const kSegmentCGRectX = @"SkeyCGRect_x";
NSString *const kSegmentCGRectY = @"SkeyCGRect_y";
NSString *const kSegmentCGRectWidth = @"SkeyCGRect_width";
NSString *const kSegmentCGRectheight = @"SkeyCGRect_height";

NSString *const kSegmentIspicture = @"SkeyIsPicture";
NSString *const kSegmentItems = @"SkeyItems";
NSString *const kSegmentSelectIndex = @"SkeySelectNum";

@interface SegmentOfMapper ()
@property(nonatomic,strong)CountString *countSting;
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;
@end
@implementation SegmentOfMapper
+(SegmentOfMapper *)modelObjectWithDictionary:(NSDictionary *)dictionary{
    SegmentOfMapper *interface = [[SegmentOfMapper alloc]initWithDictionary:dictionary];
    return interface;
}

//初始化加载  新的属性也在此添加
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self  = [super init];
    //    NSAttributedString
    //    NSShadowAttributeName
    if (self && [dictionary isKindOfClass:[NSDictionary class]]) {
        _countSting = [[CountString alloc]init];
        
        self.type = [self objectOrNilForKey:kSegmentType fromDictionary:dictionary];
        self.tag = [self objectOrNilForKey:kSegmentTag fromDictionary:dictionary];
        NSString *xString = [_countSting getStatement:[self objectOrNilForKey:kSegmentCGRectX fromDictionary:dictionary]];
        CGFloat rect_x =[_countSting operatorString:xString];
        NSString *yString = [_countSting getStatement:[self objectOrNilForKey:kSegmentCGRectY fromDictionary:dictionary]];
        CGFloat rect_y =[_countSting operatorString:yString];
        NSString *wString = [_countSting getStatement:[self objectOrNilForKey:kSegmentCGRectWidth  fromDictionary:dictionary]];
        CGFloat rect_width =[_countSting operatorString:wString];
        NSString *hString = [_countSting getStatement:[self objectOrNilForKey:kSegmentCGRectheight  fromDictionary:dictionary]];
        CGFloat rect_height =[_countSting operatorString:hString];
        self.xPointOfRect = [NSString stringWithFormat:@"%f",rect_x];
        self.yPointOfRect = [NSString stringWithFormat:@"%f",rect_y];
        self.widthOfRect = [NSString stringWithFormat:@"%f",rect_width];
        self.heightOfRect = [NSString stringWithFormat:@"%f",rect_height];
        
        
        CGFloat fRGBred = [_countSting operatorString:[self objectOrNilForKey:kSegmentColorRGBRed fromDictionary:dictionary]];
        CGFloat fRGBgreen = [_countSting operatorString:[self objectOrNilForKey:kSegmentColorRGBGreen fromDictionary:dictionary]];
        CGFloat fRGBblue = [_countSting operatorString:[self objectOrNilForKey:kSegmentColorRGBBlue  fromDictionary:dictionary]];
        self.RGBRed = [NSString stringWithFormat:@"%f",fRGBred];
        self.RGBGreen = [NSString stringWithFormat:@"%f",fRGBgreen];
        self.RGBBlue = [NSString stringWithFormat:@"%f",fRGBblue];
        self.RGB_alpha = [self objectOrNilForKey:kSegmentColorRGB_alpha fromDictionary:dictionary];
        //这个属性可以不用设置
        self.isPicture = [self objectOrNilForKey:kSegmentIspicture fromDictionary:dictionary];
        NSDictionary *itemDic = [self objectOrNilForKey:kSegmentItems fromDictionary:dictionary];
        NSArray *items = [[NSArray alloc]init];
        if ([[self objectOrNilForKey:kSegmentIspicture fromDictionary:dictionary] intValue]) {
            items = [self imageOfArrayOfTitleFormJSON:itemDic andString:@"segment"];
        }else{
            items = [self titleOfArrayOfTitleFormJSON:itemDic];
            
        }
        self.items = items;
        self.selectIndex = [self objectOrNilForKey:kSegmentSelectIndex fromDictionary:dictionary];
        
    }
    return self;
}
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.tag forKey:kSegmentTag];
    [mutableDict setValue:self.type forKey:kSegmentType];
    [mutableDict setValue:self.xPointOfRect forKey:kSegmentCGRectX];
    [mutableDict setValue:self.yPointOfRect forKey:kSegmentCGRectY];
    [mutableDict setValue:self.widthOfRect forKey:kSegmentCGRectWidth];
    [mutableDict setValue:self.heightOfRect forKey:kSegmentCGRectheight];
    [mutableDict setValue:self.RGBRed forKey:kSegmentColorRGBRed];
    [mutableDict setValue:self.RGBGreen forKey:kSegmentColorRGBGreen];
    [mutableDict setValue:self.RGBBlue forKey:kSegmentColorRGBBlue];
    [mutableDict setValue:self.RGB_alpha forKey:kSegmentColorRGB_alpha];
    
    [mutableDict setValue:self.isPicture forKey:kSegmentIspicture];
    [mutableDict setValue:self.items forKey:kSegmentItems];
    [mutableDict setValue:self.selectIndex forKey:kSegmentSelectIndex];
    
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
#pragma mark parse segment about items
-(NSArray *)titleOfArrayOfTitleFormJSON:(NSDictionary *)dictionary{
    NSMutableArray *jArray = [[NSMutableArray alloc]initWithCapacity:10];
    for (int i = 0; i<dictionary.allKeys.count; i++) {
        NSString *string = [dictionary objectForKey:[NSString stringWithFormat:@"segment_%d",i]];
        [jArray addObject:string];
    }
    return jArray;
}
-(NSArray *)imageOfArrayOfTitleFormJSON:(NSDictionary *)dictionary andString:(NSString *)string{
    NSMutableArray *jArray = [[NSMutableArray alloc]initWithCapacity:10];
    for (int i = 0; i<dictionary.allKeys.count; i++) {
        NSString *strings = [dictionary objectForKey:[NSString stringWithFormat:@"%@_%d",string,i]];
        UIImage *image = [UIImage imageNamed:strings];
        if (image) {
             [jArray addObject:image];
        }
       
    }
    return jArray;
}

@end
