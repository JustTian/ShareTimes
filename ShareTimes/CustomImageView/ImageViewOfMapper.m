//
//  ImageViewOfMapper.m
//  FirstProject
//
//  Created by 传晟 on 14-5-6.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "ImageViewOfMapper.h"
//此处注意不能定制相同的名称 ｜const后的name
NSString *const kIViewType = @"type";
NSString *const kIViewtag  = @"IkeyOfTag";

NSString *const kIViewColorRGBGreen = @"IkeyColorRGB_green";
NSString *const kIViewColorRGBRed = @"IkeyColorRGB_red";
NSString *const kIViewColorRGBBlue = @"IkeyColorRGB_blue";
NSString *const kIViewColorRGB_alpha = @"IkeyColor_alpha";

NSString *const kIViewCGRectX = @"IkeyCGRect_x";
NSString *const kIViewCGRectY = @"IkeyCGRect_y";
NSString *const kIViewCGRectWidth = @"IkeyCGRect_width";
NSString *const kIViewCGRectheight = @"IkeyCGRect_height";

NSString *const kIViewBGColor = @"IkeyBackGroudColor";
NSString *const kIViewIsAnimation = @"IkeyIsAnimation";
NSString *const kIViewAnimationImages = @"IkeyAnimationImages";
NSString *const kIViewAnimationDuration = @"IkeyAnimationDuration";
NSString *const kIViewAnimationRepeatCount = @"IkeyAnimationRepeatCount";
NSString *const kIViewImageName = @"IkeyImage";
NSString *const kIViewImageURL = @"IkeyURLString";
NSString *const kIViewContentMode = @"IkeyContentMode";

@interface ImageViewOfMapper ()
@property(nonatomic,strong)CountString *countSting;
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;
@end

@implementation ImageViewOfMapper
+(ImageViewOfMapper*)modelObjectWithDictionary:(NSDictionary *)dictionary{
    ImageViewOfMapper *interface = [[ImageViewOfMapper alloc]initWithDictionary:dictionary];
    return interface;
}

//初始化加载  新的属性也在此添加
-(instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self  = [super init];
    //    NSAttributedString
    //    NSShadowAttributeName
    if (self && [dictionary isKindOfClass:[NSDictionary class]]) {
        _countSting = [[CountString alloc]init];
        
        self.type = [self objectOrNilForKey:kIViewType fromDictionary:dictionary];
        self.tag = [self objectOrNilForKey:kIViewtag fromDictionary:dictionary];
        NSString *xString = [_countSting getStatement:[self objectOrNilForKey:kIViewCGRectX fromDictionary:dictionary]];
        CGFloat rect_x =[_countSting operatorString:xString];
        NSString *yString = [_countSting getStatement:[self objectOrNilForKey:kIViewCGRectY fromDictionary:dictionary]];
        CGFloat rect_y =[_countSting operatorString:yString];
        NSString *wString = [_countSting getStatement:[self objectOrNilForKey:kIViewCGRectWidth  fromDictionary:dictionary]];
        CGFloat rect_width =[_countSting operatorString:wString];
        NSString *hString = [_countSting getStatement:[self objectOrNilForKey:kIViewCGRectheight  fromDictionary:dictionary]];
        CGFloat rect_height =[_countSting operatorString:hString];
        self.xPointOfRect = [NSString stringWithFormat:@"%f",rect_x];
        self.yPointOfRect = [NSString stringWithFormat:@"%f",rect_y];
        self.widthOfRect = [NSString stringWithFormat:@"%f",rect_width];
        self.heightOfRect = [NSString stringWithFormat:@"%f",rect_height];
        
        
        CGFloat fRGBred = [_countSting operatorString:[self objectOrNilForKey:kIViewColorRGBRed fromDictionary:dictionary]];
        CGFloat fRGBgreen = [_countSting operatorString:[self objectOrNilForKey:kIViewColorRGBGreen fromDictionary:dictionary]];
        CGFloat fRGBblue = [_countSting operatorString:[self objectOrNilForKey:kIViewColorRGBBlue  fromDictionary:dictionary]];
        self.RGBRed = [NSString stringWithFormat:@"%f",fRGBred];
        self.RGBGreen = [NSString stringWithFormat:@"%f",fRGBgreen];
        self.RGBBlue = [NSString stringWithFormat:@"%f",fRGBblue];
        self.RGB_alpha = [self objectOrNilForKey:kIViewColorRGB_alpha fromDictionary:dictionary];

        self.backGColor = [self objectOrNilForKey:kIViewBGColor fromDictionary:dictionary];
        self.isAnimation = [self objectOrNilForKey:kIViewIsAnimation fromDictionary:dictionary];
        self.animationDuration = [self objectOrNilForKey:kIViewAnimationDuration fromDictionary:dictionary];
        //取出字典里的图片放入数组中
        NSDictionary *lNdic = [self objectOrNilForKey:kIViewAnimationImages fromDictionary:dictionary];
        NSString *str = @"image";
        self.animationImages = [self imageOfArrayOfTitleFormJSON:lNdic andString:str];
        
        self.animationRepeateCount = [self objectOrNilForKey:kIViewAnimationRepeatCount fromDictionary:dictionary];
        self.ImageName = [self objectOrNilForKey:kIViewImageName fromDictionary:dictionary];
        self.imageURL = [self objectOrNilForKey:kIViewImageURL fromDictionary:dictionary];
        self.ContemMode = [self objectOrNilForKey:kIViewContentMode fromDictionary:dictionary];
        
    }
    return self;
}
- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.tag forKey:kIViewtag];
    [mutableDict setValue:self.type forKey:kIViewType];
    [mutableDict setValue:self.xPointOfRect forKey:kIViewCGRectX];
    [mutableDict setValue:self.yPointOfRect forKey:kIViewCGRectY];
    [mutableDict setValue:self.widthOfRect forKey:kIViewCGRectWidth];
    [mutableDict setValue:self.heightOfRect forKey:kIViewCGRectheight];
    [mutableDict setValue:self.RGBRed forKey:kIViewColorRGBRed];
    [mutableDict setValue:self.RGBGreen forKey:kIViewColorRGBGreen];
    [mutableDict setValue:self.RGBBlue forKey:kIViewColorRGBBlue];
    [mutableDict setValue:self.RGB_alpha forKey:kIViewColorRGB_alpha];
    
    [mutableDict setValue:self.backGColor forKey:kIViewBGColor];
    [mutableDict setValue:self.isAnimation forKey:kIViewIsAnimation];
    [mutableDict setValue:self.animationDuration forKey:kIViewAnimationDuration];
    [mutableDict setValue:self.animationImages forKey:kIViewAnimationImages];
    [mutableDict setValue:self.animationRepeateCount forKey:kIViewAnimationRepeatCount];
    [mutableDict setValue:self.ImageName forKey:kIViewImageName];
    [mutableDict setValue:self.imageURL forKey:kIViewImageURL];
    [mutableDict setValue:self.ContemMode forKey:kIViewContentMode];
    
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
//返回多个图片数组
-(NSArray *)imageOfArrayOfTitleFormJSON:(NSDictionary *)dictionary andString:(NSString *)string{
    NSMutableArray *jArray = [[NSMutableArray alloc]initWithCapacity:10];
    for (int i = 0; i<dictionary.allKeys.count; i++) {
        NSString *strings = [dictionary objectForKey:[NSString stringWithFormat:@"%@_%d",string,i]];
        UIImage *image = [UIImage imageNamed:strings];
        if (image) {
            [jArray addObject:image];
        }else{
            NSLog(@"图片没有导入！");
        }
        
    }
    return jArray;
}

@end
