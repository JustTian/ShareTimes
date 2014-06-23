//
//  CustomTextView.m
//  ShareTimes
//
//  Created by 传晟 on 14-6-22.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "CustomTextView.h"
#import "TextViewOfMapper.h"

@implementation CustomTextView{
    CustomTextView *seleVIew;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
+(CustomTextView *)loadCustomLabelFromMode:(NSDictionary *)dictionary{
    TextViewOfMapper *textMapper = [[TextViewOfMapper alloc]initWithDictionary:dictionary];
    //    NSLog(@"textMapper = %@",textMapper);
    
    CustomTextView *wTextView = [[CustomTextView alloc]init];
    CGRect framRect = [wTextView rectFromModelJSON:textMapper];
    wTextView.frame = framRect;
    wTextView.backgroundColor = [UIColor colorWithRed:[textMapper.RGBRed floatValue]
                                                 green:[textMapper.RGBGreen floatValue]
                                                  blue:[textMapper.RGBBlue floatValue]
                                                 alpha:[textMapper.RGB_alpha floatValue]];
    wTextView.textColor = [wTextView colorFromJSONnum:[textMapper.textColor integerValue]];
    wTextView.font = [UIFont fontWithName:textMapper.font size:[textMapper.fontSize floatValue]];
//    wTextView.placeholder = textMapper.placeHolder;
    wTextView.textAlignment = [wTextView acheiveTextAlignmentFromJSONnum:[textMapper.aligement integerValue]];
    
    wTextView.tag = [textMapper.tag integerValue];
    
    wTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    wTextView.autocorrectionType = UITextAutocorrectionTypeYes;
    wTextView.keyboardType = UIKeyboardTypeDefault;
    wTextView.returnKeyType = UIReturnKeyDone;
    wTextView.delegate = wTextView;
    
    //在弹出的键盘上面加一个view来放置退出键盘的Done按钮
    [wTextView setCustomKeyBoard:wTextView];
    return wTextView;
}
-(void) setCustomKeyBoard:(CustomTextView *)textView{
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard:)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    [topView setItems:buttonsArray];
    [textView setInputAccessoryView:topView];
}

-(void) dismissKeyBoard:(CustomTextView *)textView{
    if ([self isKindOfClass:[CustomTextView class]]) {
        [self resignFirstResponder];
    }else{
        NSLog(@"meiyou xiangying");
    }
    
}
#pragma mark 辅助方法
-(CGRect)rectFromModelJSON:(TextViewOfMapper *)textFieldOfMapper{
    CGRect table_rect;
    table_rect.origin.x = [textFieldOfMapper.xPointOfRect floatValue];
    table_rect.origin.y = [textFieldOfMapper.yPointOfRect floatValue];
    table_rect.size.width = [textFieldOfMapper.widthOfRect floatValue];
    table_rect.size.height = [textFieldOfMapper.heightOfRect floatValue];
    return table_rect;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
