//
//  CustomView.h
//  FirstProject
//
//  Created by 传晟 on 14-5-3.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomView;
typedef void (^Myblock) (CustomView *);
@interface CustomView : UIView
@property(nonatomic,copy )Myblock customViewBlock;


-(void)setimageWithView:(Myblock) block;

+(CustomView *)loadCustomLabelFromMode:(NSDictionary *)dictionary;


@end
