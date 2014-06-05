//
//  CustomSegmetnControl.h
//  FirstProject
//
//  Created by 传晟 on 14-5-6.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CustomSegmetnControl;
@interface CustomSegmetnControl : UISegmentedControl
+(CustomSegmetnControl *)loadCustomLabelFromMode:(NSDictionary *)dictionary;
@end
