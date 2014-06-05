//
//  CustomTextField.m
//  FirstProject
//
//  Created by 传晟 on 14-5-7.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "CustomTextField.h"
#import "TextFieldOfMapper.h"

@implementation CustomTextField {
    UIColor *_backgroundColor;
    UIColor *_placeholderTextColor;
    UIFont *_font;
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
    wTextField.textColor = [wTextField colorFromJSONnum:[textMapper.textColor integerValue]];
    wTextField.font = [UIFont fontWithName:textMapper.font size:[textMapper.fontSize floatValue]];
    wTextField.placeholder = textMapper.placeHolder;
    wTextField.textAlignment = [wTextField acheiveTextAlignmentFromJSONnum:[textMapper.aligement integerValue]];
    
    wTextField.tag = [textMapper.tag integerValue];
//    UIImageView *imageView = [[UIImageView alloc]init];
//    imageView.backgroundColor = [UIColor redColor];
//    imageView.frame = CGRectMake(0, 0, 40, 40);
//    wTextField.leftView = imageView;
    
//    UIView *TleftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 20, 80)];
//    TleftView.backgroundColor = [UIColor grayColor];
//    wTextField.leftView = TleftView;
//    wTextField.leftViewMode = UITextFieldViewModeWhileEditing;
    return wTextField;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self appearance];
//        self.delegate = self;
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self appearance];
//        self.delegate = self;
    }
    return self;
}

-(id)init{
    self = [super init];
    if (self) {
        [self appearance];
//        self.delegate = self;
    }
    return self;
}


- (void)appearance {
    _backgroundColor = [[WidgetSettingForLayout sharAllMableAttribute] backgroundColor];
    _mainColor = [[WidgetSettingForLayout sharAllMableAttribute] mainColor];
    _placeholderTextColor = [[WidgetSettingForLayout sharAllMableAttribute] textFieldPlaceHolderColor];
    _font = [[WidgetSettingForLayout sharAllMableAttribute] font];
    
    [self setTextColor:_mainColor];
    [self setFont:_font];
    [self setBorderStyle:UITextBorderStyleNone];
    [self setBackgroundColor:[[WidgetSettingForLayout sharAllMableAttribute] backgroundColor]];
    
}
-(void)drawRect:(CGRect)rect {
    // Drawing code
    CALayer *layer = self.layer;
    layer.backgroundColor = [[UIColor clearColor] CGColor];
    layer.cornerRadius = 5.0;
    layer.masksToBounds = YES;
    layer.borderWidth = 1.0;
    layer.borderColor = [_placeholderTextColor CGColor];
    [layer setShadowColor: [[UIColor blackColor] CGColor]];
    [layer setShadowOpacity:1];
    [layer setShadowOffset: CGSizeMake(0, 0.0)];
    [layer setShadowRadius:0];
}
- (void)drawPlaceholderInRect:(CGRect)rect {
    [_placeholderTextColor setFill];
    [[self placeholder] drawInRect:rect withFont:_font];
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 5 );
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 10 , 5 );
}
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
