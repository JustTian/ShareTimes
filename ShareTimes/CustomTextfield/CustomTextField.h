//
//  CustomTextField.h
//  FirstProject
//
//  Created by 传晟 on 14-5-7.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WidgetSettingForLayout.h"

@interface CustomTextField : UITextField
@property (strong, readonly) UIColor *mainColor;

+(CustomTextField *)loadCustomLabelFromMode:(NSDictionary *)dictionary;

@end
