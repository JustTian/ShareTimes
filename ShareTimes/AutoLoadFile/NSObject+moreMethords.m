//
//  NSObject+moreMethords.m
//  FirstProject
//
//  Created by 传晟 on 14-4-29.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "NSObject+moreMethords.h"
#import "HeaderForCustoms.h"

@implementation NSObject (moreMethords)

-(NSDictionary *)dictionaryFromJSONName:(NSString *)nameOfJSON{
    
//    NSString *patrString = [NSBundle mainBundle]pathForResource:<#(NSString *)#> ofType:<#(NSString *)#>
    
    NSString *lstring = [[NSBundle mainBundle] resourcePath];
    NSString *path = [lstring stringByAppendingPathComponent:nameOfJSON];
    NSData *ldata = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:ldata options:NSJSONReadingAllowFragments error:nil];

    return lDictionary;
}

-(UIColor *)colorFromJSONnum:(NSInteger)num{
    UIColor *Rcolor;
    switch (num) {
        case 0:
            Rcolor  = [UIColor blackColor];//黑色
            break;
        case 1:
            Rcolor  = [UIColor darkGrayColor];//暗灰色
            break;
        case 2:
            Rcolor  = [UIColor lightGrayColor];//淡灰色
            break;
        case 3:
            Rcolor  = [UIColor whiteColor];//白色
            break;
        case 4:
            Rcolor  = [UIColor grayColor];//灰色
            break;
        case 5:
            Rcolor  = [UIColor redColor];//红色
            break;
        case 6:
            Rcolor  = [UIColor greenColor];//绿色
            break;
        case 7:
            Rcolor  = [UIColor blueColor];//蓝色
            break;
        case 8:
            Rcolor  = [UIColor cyanColor];//清亮色、蓝绿色
            break;
        case 9:
            Rcolor  = [UIColor yellowColor];//黄色
            break;
        case 10:
            Rcolor  = [UIColor magentaColor];//洋红色、品红色
            break;
        case 11:
            Rcolor  = [UIColor orangeColor];//橙色
            break;
        case 12:
            Rcolor  = [UIColor purpleColor];//紫色
            break;
        case 13:
            Rcolor  = [UIColor brownColor];//棕色
            break;
        case 14:
            Rcolor  = [UIColor clearColor];//空白颜色
            break;
            
        default:
            Rcolor  = [UIColor clearColor];
            break;
    }
    return Rcolor;
}

-(NSTextAlignment) acheiveTextAlignmentFromJSONnum:(NSInteger)num{
    NSTextAlignment textAlignment;
    switch (num) {
        case 1:
            textAlignment = NSTextAlignmentCenter;
            break;
        case 2:
            textAlignment = NSTextAlignmentRight;
            break;
        case 3:
            textAlignment = NSTextAlignmentJustified;
            break;
        case 4:
            textAlignment = NSTextAlignmentNatural;
            break;
        default:
            textAlignment = NSTextAlignmentLeft;
            break;
    }
    return textAlignment;
}

-(CGPoint) pointFromJSON:(NSDictionary *)dictionary{
    CGPoint point;
    CGFloat x = [[dictionary objectForKey:@"keyPoint_x"] floatValue];
    CGFloat y = [[dictionary objectForKey:@"keyPoint_y"] floatValue];
    point.x = x;
    point.y = y;
    return point;
}

-(CGSize )sizeFromJSON:(NSDictionary *)dictionary{
    CGSize size;
    CGFloat width = [[dictionary objectForKey:@"keySize_width"] floatValue];
    CGFloat height = [[dictionary objectForKey:@"keySize_height"] floatValue];
    size.width = width;
    size.height = height;
    return size;
}

-(CGRect )rectFromJSON:(NSDictionary *)dictionary{
    CGRect rect;
    NSDictionary  *dicForPoint = [dictionary objectForKey:@"keyPoint"];
    NSDictionary *dicForSize = [dictionary objectForKey:@"keySize"];
    rect.origin = [self pointFromJSON:dicForPoint];
    rect.size = [self sizeFromJSON:dicForSize];
    return rect;
}

-(BOOL) boolFromJSON:(NSInteger )integer{
    BOOL isOK;
    if (integer != 0) {
        isOK = YES;
    }else{
        isOK  = NO;
    }
    return isOK;
}

-(UIImage *)imageFromJSON:(NSString *)string{
    UIImage *image = [UIImage imageNamed:string];
    return image;
}
-(UIViewContentMode)modeFromJSON:(NSInteger )integer{
    UIViewContentMode contentMode=UIViewContentModeScaleAspectFill;
    if (integer ==0) {
        contentMode = UIViewContentModeScaleAspectFill;
    }
    if (integer == 1) {
        contentMode = UIViewContentModeScaleAspectFit;
    }
    if (integer == 2) {
        contentMode = UIViewContentModeScaleToFill;
    }
    return contentMode;
}
//转换为button类型的方法
-(UIButtonType )buttonTypeFromMapper:(NSString *)string{
    UIButtonType butType;
    if ([string isEqualToString:@"0"]) {
        butType = UIButtonTypeCustom;
        return butType;
    }
    if ([string isEqualToString:@"1"]) {
        butType = UIButtonTypeRoundedRect;
        return butType;
    }
    if ([string isEqualToString:@"2"]) {
        butType = UIButtonTypeDetailDisclosure;
        return butType;
    }
    if ([string isEqualToString:@"3"]) {
        butType = UIButtonTypeInfoLight;
        return butType;
    }
    if ([string isEqualToString:@"4"]) {
        butType = UIButtonTypeInfoDark;
        return butType;
    }
    if ([string isEqualToString:@"5"]) {
        butType = UIButtonTypeContactAdd;
        return butType;
    }
    return butType = UIButtonTypeRoundedRect;
}

#pragma mark 事件响应通过tag值取出后的描述方法
//-(void)cScrollerViewClick:(NSArray *)array{
//    [super cScrollerViewClick:array];
//
//}
-(void)customButtonClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[customButton class]]) {
                customButton *cButton = [array objectAtIndex:i];
                __block customButton *cB = cButton;
                cButton.myblock = ^(customButton *button){
        
//                    if (cB.clickOfType == 3) {
//                        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"warning" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
//                        [alertView show];
//                        NSLog(@"%ld",(long)alertView.cancelButtonIndex);
//                        NSLog(@"%ld",(long)alertView.firstOtherButtonIndex);
//                    }
                    NSLog(@"____________%@",[cB class]);
                };
                
            }
        }
        
    }
}
//pagecontrol的事件监听描述
-(void)customPageControlClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CpageControl class]]){
                CpageControl *cPageControl = [array objectAtIndex:i];
                [cPageControl addTarget:self action:@selector(pageControlClick:) forControlEvents:UIControlEventValueChanged];
            }
        }
    }
    
}
-(void)pageControlClick:(CpageControl *)sender{
    NSLog(@"hello");
}
//segmentcontrol的事件监听描述
-(void)customSegmentClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CustomSegmetnControl class]]){
                CustomSegmetnControl *cSement = [array objectAtIndex:i];
                [cSement addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
            }
        }
    }
    
}
-(void)segmentClick:(CustomSegmetnControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"first");
    }else{
        NSLog(@"other");
    }
}
//UISlider的事件监听描述
-(void)customSliderClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CustomSlider class]]){
                CustomSlider *cSlider = [array objectAtIndex:i];
                [cSlider addTarget:self action:@selector(sliderClick:) forControlEvents:UIControlEventValueChanged];
            }
        }
    }
    
}
-(void)sliderClick:(CustomSlider *)sender{
    NSLog(@"sender.value = %f",sender.value);
}
//CustomSwitch的事件监听描述
-(void)customSwitchClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CustomSwitch class]]){
                CustomSwitch *cSwitch = [array objectAtIndex:i];
                [cSwitch addTarget:self action:@selector(switchClick:) forControlEvents:UIControlEventValueChanged];
            }
        }
    }
    
}
-(void)switchClick:(CustomSwitch *)sender{
    if (sender.on) {
        NSLog(@"选中状态");
    }else{
        NSLog(@"空闲状态");
    }
}
//textField的事件监听描述
-(void)customTextFieldClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CustomTextField class]]){
                CustomTextField *cTextField = [array objectAtIndex:i];
                [cTextField addTarget:self action:@selector(textFieldClick:) forControlEvents:UIControlEventEditingDidEndOnExit];
            }
        }
    }
}
-(void)textFieldClick:(CustomTextField *)sender{
    [sender resignFirstResponder];
    NSLog(@"resign");
}
//customView的事件点击描述
-(void)customViewClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CustomView class]]){
                CustomView *cView = [array objectAtIndex:i];
                cView.customViewBlock = ^(CustomView *viwe){
                    NSLog(@"customView be Touch!");
                };
            }
        }
    }
    
}


-(void)cScrollerViewClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CustomScrollerView class]]){
                //                CustomScrollerView *cSView = [array objectAtIndex:i];
                NSLog(@"hello cSView");
                
            }
        }
    }
    
}

@end
