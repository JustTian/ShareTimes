//
//  CustomSwitch.h
//  shiyan3
//
//  Created by 传晟 on 14-4-8.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSwitch : UIControl
@property(nonatomic,assign) BOOL on;               //判断是否开关状态
@property(nonatomic,strong) UIColor *inactiveColor;//不活跃的
@property(nonatomic,strong) UIColor *activeColor;  //活跃的
@property(nonatomic,strong) UIColor *onColor;      //选中状态
@property(nonatomic,strong) UIColor *borderColor;  //边界
@property(nonatomic,strong) UIColor *knobColor;    //把手，鼓起
@property(nonatomic,strong) UIColor *shadowColor;  //阴影
@property(nonatomic,assign) BOOL isRounded;        //是否是圆形的
@property(nonatomic,strong) UIImage *onImage;      //选中状态图片背景
@property(nonatomic,strong) UIImage *offImage;     //空闲状态图片背景
-(void)setOn:(BOOL)on animated:(BOOL)animated;     //设置切换动画
-(BOOL)isOn;                                       //返回开关状态的bool值

+(CustomSwitch *)loadCustomLabelFromMode:(NSDictionary *)dictionary;
@end
