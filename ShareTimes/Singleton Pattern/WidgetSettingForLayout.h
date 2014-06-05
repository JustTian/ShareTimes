//
//  WidgetSettingForLayout.h
//  FirstProject
//
//  Created by 传晟 on 14-5-3.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+Additions.h"

@interface WidgetSettingForLayout : NSObject
@property (strong, readwrite) UIColor *mainColor;
@property (strong, readwrite) UIColor *secondColor;
@property (strong, readwrite) UIColor *backgroundColor;

@property (strong, readwrite) UIColor *iconImageColor;
@property (strong, readwrite) UIColor *textFieldPlaceHolderColor;
@property (strong, readwrite) UIFont *font;

- (void)navigationBarApperance;

+(WidgetSettingForLayout *)sharAllMableAttribute;
@end
