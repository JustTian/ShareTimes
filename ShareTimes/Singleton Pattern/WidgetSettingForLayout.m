//
//  WidgetSettingForLayout.m
//  FirstProject
//
//  Created by 传晟 on 14-5-3.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "WidgetSettingForLayout.h"
static WidgetSettingForLayout *wsfLayout = nil;
@implementation WidgetSettingForLayout
+(WidgetSettingForLayout *)sharAllMableAttribute{
    @synchronized(self){
        if (wsfLayout == nil) {
            wsfLayout = [[WidgetSettingForLayout alloc] init];
            
        }
    }
    
    return wsfLayout;
}
- (id)init {
    self = [super init];
    if (self) {
//        _mainColor = [UIColor colorWithRed:0.35f green:0.51f blue:0.91f alpha:1.00f];
        _mainColor = [UIColor redColor];
        _backgroundColor = [UIColor whiteColor];
        _textFieldPlaceHolderColor = [UIColor colorWithRed:0.80f green:0.80f blue:0.80f alpha:1.00f];
        _secondColor = [UIColor colorWithRed:0.94f green:0.94f blue:0.94f alpha:1.00f];
        _font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        _iconImageColor = [UIColor whiteColor];
    }
    return self;
}

- (void)navigationBarApperance {
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    
    NSDictionary *_titleTextAttributes = @{UITextAttributeTextColor: [UIColor blackColor],
                                           UITextAttributeTextShadowColor : [UIColor clearColor],
                                           UITextAttributeFont : [_font fontWithSize:20.0f]};
    
    [[UINavigationBar appearance] setTitleTextAttributes:_titleTextAttributes];
    // remove shadow
    [[UINavigationBar appearance]setShadowImage:[UIImage imageWithColor:_textFieldPlaceHolderColor]];
}

@end
