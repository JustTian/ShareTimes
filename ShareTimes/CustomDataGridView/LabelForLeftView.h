//
//  LabelForLeftView.h
//  FirstProject
//
//  Created by 传晟 on 14-5-30.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;
@interface LabelForLeftView : UILabel
@property (nonatomic) VerticalAlignment verticalAlignment;
@end

