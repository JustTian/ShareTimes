//
//  CustomTextField.m
//  FirstProject
//
//  Created by 传晟 on 14-5-7.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "CustomTextField.h"
#import "TextFieldOfMapper.h"
#import "CustomSwitch.h"
#import "customView.h"

@implementation CustomTextField {
    UIColor *_backgroundColor;
    UIColor *_placeholderTextColor;
    UIFont *_font;
    CustomTextField *_cTField;
}
+(CustomTextField *)loadCustomLabelFromMode:(NSDictionary *)dictionary{
    TextFieldOfMapper *textMapper = [[TextFieldOfMapper alloc]initWithDictionary:dictionary];
//    NSLog(@"textMapper = %@",textMapper);
    
    CustomTextField *wTextField = [[CustomTextField alloc]init];
    CGRect framRect = [wTextField rectFromModelJSON:textMapper];
    wTextField.frame = framRect;
    wTextField.backgroundColor = [UIColor colorWithRed:[textMapper.RGBRed floatValue]
                                              green:[textMapper.RGBGreen floatValue]
                                               blue:[textMapper.RGBBlue floatValue]
                                              alpha:[textMapper.RGB_alpha floatValue]];
    //设置文本视图的左视图
    UIImage *imagel = [UIImage imageNamed:textMapper.leftViewName];
    if (imagel) {
        UIImageView *lImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
        lImageView.image = imagel;
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [view addSubview:lImageView];
        wTextField.leftView = view;
        wTextField.leftViewMode = [wTextField textFieldViewModeFromJSON:[textMapper.leftViewMode integerValue]];
    }else{
        if ([textMapper.isCustomLeftView boolValue]) {
             //
        }
        NSLog(@"没有设置leftview");
    }
    //设置文本视图的右视图
    UIImage *rImage = [UIImage imageNamed:textMapper.rightViewName];
    if (rImage) {
        UIImageView *rImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 20, 20)];
        rImageView.image = rImage;
        CustomView *view = [[CustomView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
//        view.backgroundColor = [UIColor redColor];
        //此处添加响应的功能miaoshu
//        view.customViewBlock = ^
        [view addSubview:rImageView];
        wTextField.rightView = view;
        wTextField.rightViewMode = [wTextField textFieldViewModeFromJSON:[textMapper.rightViewMode integerValue]];
    }else{
        if ([textMapper.isCustomRightView boolValue]) {
            NSLog(@"自定义rightview");
            UIView *rView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 40)];
            CustomSwitch *cSwitch = [[CustomSwitch alloc]initWithFrame:CGRectMake(0, 10, 40, 20)];
            cSwitch.onColor = [UIColor blueColor];
            cSwitch.on = NO;
            cSwitch.switchBlock = ^(CustomSwitch *cuSwitch){
                if (cuSwitch.on) {
                    NSLog(@"selected");
                    wTextField.secureTextEntry = NO;
                }else{
                    NSLog(@"unSelected");
                    wTextField.secureTextEntry = YES;
                }
            };
            //        [cSwitch addTarget:cSwitch action:@selector(cswitchClick:) forControlEvents:UIControlEventValueChanged];
            [rView addSubview:cSwitch];
            
            //         = wTextField;
            wTextField.rightView = rView;
            wTextField.rightViewMode = UITextFieldViewModeAlways;
        }
        else{
            //
        }
        
    }
    
    wTextField.textColor = [wTextField colorFromJSONnum:[textMapper.textColor integerValue]];
    wTextField.font = [UIFont fontWithName:textMapper.font size:[textMapper.fontSize floatValue]];
    wTextField.placeholder = textMapper.placeHolder;
    wTextField.textAlignment = [wTextField acheiveTextAlignmentFromJSONnum:[textMapper.aligement integerValue]];
    
    wTextField.tag = [textMapper.tag integerValue];
    
    wTextField.borderStyle = [wTextField borderStyleFromJSON:[textMapper.borderStyle integerValue]];
    wTextField.secureTextEntry = [wTextField boolFromJSON:[textMapper.secureTextEntry integerValue]];
    
//    wTextField.contentHorizontalAlignment = 
    
    return wTextField;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        [self appearance];
//        self.delegate = self;
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
//        [self appearance];
//        self.delegate = self;
    }
    return self;
}

-(id)init{
    self = [super init];
    if (self) {
//        [self appearance];
//        self.delegate = self;
    }
    return self;
}
//
//-(void)cswitchClick:(CustomSwitch *)sender{
//    if (sender.on) {
////        NSLog(@"%@",[sender.superview class]);
////        self.secureTextEntry = YES;
//        NSLog(@"选中状态");
//    }else{
//        self.secureTextEntry = NO;
//        NSLog(@"空闲状态");
//    }
//}

//- (void)appearance {
//    _backgroundColor = [[WidgetSettingForLayout sharAllMableAttribute] backgroundColor];
//    _mainColor = [[WidgetSettingForLayout sharAllMableAttribute] mainColor];
//    _placeholderTextColor = [[WidgetSettingForLayout sharAllMableAttribute] textFieldPlaceHolderColor];
//    _font = [[WidgetSettingForLayout sharAllMableAttribute] font];
//    
//    [self setTextColor:_mainColor];
//    [self setFont:_font];
//    [self setBorderStyle:UITextBorderStyleNone];
//    [self setBackgroundColor:[[WidgetSettingForLayout sharAllMableAttribute] backgroundColor]];
//    
//}
//-(void)drawRect:(CGRect)rect {
//    // Drawing code
//    CALayer *layer = self.layer;
//    layer.backgroundColor = [[UIColor clearColor] CGColor];
//    layer.cornerRadius = 5.0;
//    layer.masksToBounds = YES;
//    layer.borderWidth = 1.0;
//    layer.borderColor = [_placeholderTextColor CGColor];
//    [layer setShadowColor: [[UIColor blackColor] CGColor]];
//    [layer setShadowOpacity:1];
//    [layer setShadowOffset: CGSizeMake(0, 0.0)];
//    [layer setShadowRadius:0];
//}
//- (void)drawPlaceholderInRect:(CGRect)rect {
//    [_placeholderTextColor setFill];
//    [[self placeholder] drawInRect:rect withFont:_font];
//}
//
//- (CGRect)textRectForBounds:(CGRect)bounds {
//    return CGRectInset( bounds , 10 , 5 );
//}
//
//- (CGRect)editingRectForBounds:(CGRect)bounds {
//    return CGRectInset( bounds , 10 , 5 );
//}
#pragma mark 辅助方法
-(CGRect)rectFromModelJSON:(TextFieldOfMapper *)textFieldOfMapper{
    CGRect table_rect;
    table_rect.origin.x = [textFieldOfMapper.xPointOfRect floatValue];
    table_rect.origin.y = [textFieldOfMapper.yPointOfRect floatValue];
    table_rect.size.width = [textFieldOfMapper.widthOfRect floatValue];
    table_rect.size.height = [textFieldOfMapper.heightOfRect floatValue];
    return table_rect;
}

//返回UITextFieldViewMode的私有方法，通过解析JSON文件的传值

-(UITextFieldViewMode)textFieldViewModeFromJSON:(NSInteger)integer{

    UITextFieldViewMode tfVIEWMODE = UITextFieldViewModeNever;
    switch (integer) {
        case 1:
            tfVIEWMODE = UITextFieldViewModeWhileEditing;
            break;
        case 2:
            tfVIEWMODE = UITextFieldViewModeUnlessEditing;
            break;
        case 3:
            tfVIEWMODE = UITextFieldViewModeAlways;
            break;
        default:
            tfVIEWMODE = UITextFieldViewModeNever;
            break;
    }
    return tfVIEWMODE;
}

//UITextBorderStyleNone,
//UITextBorderStyleLine,
//UITextBorderStyleBezel,
//UITextBorderStyleRoundedRect
-(UITextBorderStyle )borderStyleFromJSON:(NSInteger )integer{
    UITextBorderStyle borderStyle = UITextBorderStyleNone;
    switch (integer) {
        case 1:
            borderStyle = UITextBorderStyleLine;
            break;
            case 2:
            borderStyle = UITextBorderStyleBezel;
            break;
            case 3:
            borderStyle = UITextBorderStyleRoundedRect;
            break;
        default:
            borderStyle = UITextBorderStyleNone;
            break;
    }
    return borderStyle;
}
#pragma mark textField delegate

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    NSLog(@"textFieldShouldBeginEditing");
//    return YES;
//}

// return NO to disallow editing.

//- (void)textFieldDidBeginEditing:(UITextField *)textField{
//    NSLog(@"textFieldDidBeginEditing");
//    
//}

// became first responder

//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
//    NSLog(@"textFieldShouldEndEditing");
//    return YES;
//}

// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end

//- (void)textFieldDidEndEditing:(UITextField *)textField{
//    NSLog(@"textFieldDidEndEditing");
//}

// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//    NSLog(@"shouldChangeCharacterInRange");
//    return NO;
//}   // return NO to not change text

//- (BOOL)textFieldShouldClear:(UITextField *)textField{
//    NSLog(@"textFieldShoukdClear");
//    return YES;
//}

// called when clear button pressed. return NO to ignore (no notifications)

//-(BOOL)textFieldShouldReturn:(UITextField *)textField{
//    NSLog(@"textFieldShouldReturn");
//    [self resignFirstResponder];
//    return NO;
//}
@end
