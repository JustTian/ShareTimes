//
//  wDynamicLayout.h
//  AutoLoodViewDemo
//
//  Created by 传晟 on 14-3-18.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeaderForMacro.h"
#import "CountString.h"

@interface wDynamicLayout : NSObject
@property(nonatomic,retain)NSMutableDictionary *items;
//@property(nonatomic,retain)NSArray *typeOfArray;
//@property(nonatomic,assign) NSInteger numOfItems;


-(void)drawingInterfaceFromJSONName:(NSString *)nameOfJSON AndBaseView:(id) baseView;

-(void)loadItemsForGroup:(NSDictionary *)dictionary AndBaseView:(id)baseView;
-(id) viewOfItems:(NSDictionary *)array andTag:(NSInteger )num;
-(NSDictionary *)getItemsOfGroup:(NSDictionary *)wDictionary;//获取每个控键的类型和tag值

-(NSArray *)titleOfArrayOfTitleFormJSON:(NSDictionary *)dictionary;
-(NSArray *)imageOfArrayOfTitleFormJSON:(NSDictionary *)dictionary andString:(NSString *)string;

//返回自定义按钮的对象数组
-(NSArray *)instanceCustomButtonFromDic:(NSDictionary *)dictionary AndSupperView:(id)supperView;
//返回自定义label的对象数组
-(NSArray *)instanceCustomLabelFromDic:(NSDictionary *)dictionary AndSupperView:(id)supperView;
//返回自定义表视图的对象数组
-(NSArray *)instanceCustomTabelViewFromDic:(NSDictionary *)dictionary AndSupperView:(id)supperView;
//返回自定义图片视图的对象数组
-(NSArray *)instanceCImageViewFromDic:(NSDictionary *)dictionary AndSupperView:(id)supperView;
//返回自定义pageControl的对象数组
-(NSArray *)instanceCPageControlFromDic:(NSDictionary *)dictionary AndSupperView:(id)supperView;
//返回自定义segmentControl的对象数组
-(NSArray *)instanceCSegmentControlFromDic:(NSDictionary *)dictionary AndSupperView:(id)supperView;
//返回自定义UISlider的对象数组
-(NSArray *)instanceSliderFromDic:(NSDictionary *)dictionary AndSupperView:(id)supperView;
//返回自定义swtich的对象数组
-(NSArray *)instanceSwitchFromDic:(NSDictionary *)dictionary AndSupperView:(id)supperView;
//返回自定义textField的对象数组
-(NSArray *)instanceTextFieldFromDic:(NSDictionary *)dictionary AndSupperView:(id)supperView;
//返回自定义customView的对象数组
-(NSArray *)instanceCustomViewFromDic:(NSDictionary *)dictionary AndSupperView:(id)supperView;
//返回自定义scrollView的对象数组
-(NSArray *)instanceCustomScrollViewFromDic:(NSDictionary *)dictionary AndSupperView:(id)supperView;
@end
@interface wDynamicLayout  (headersClickAction)

//-(void)cScrollerViewClick:(NSArray *)array;

@end