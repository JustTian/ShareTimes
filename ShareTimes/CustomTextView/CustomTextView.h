//
//  CustomTextView.h
//  ShareTimes
//
//  Created by 传晟 on 14-6-22.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTextView : UITextView<UITextViewDelegate>
+(CustomTextView *)loadCustomLabelFromMode:(NSDictionary *)dictionary;

@end
