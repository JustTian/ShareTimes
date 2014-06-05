//
//  CustomScrollerView.h
//  FirstProject
//
//  Created by 传晟 on 14-5-8.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomScrollerView : UIScrollView
@property(nonatomic,assign) NSInteger numOfViews;

+(CustomScrollerView *)loadCustomScrollViewFromMode:(NSDictionary *)dictionary;

@end
