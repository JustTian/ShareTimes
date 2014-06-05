//
//  CustomView.m
//  FirstProject
//
//  Created by 传晟 on 14-5-3.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "CustomView.h"
#import "CustomViewOfMapper.h"

@implementation CustomView

+(CustomView *)loadCustomLabelFromMode:(NSDictionary *)dictionary{
    CustomViewOfMapper *cusViewMapper = [[CustomViewOfMapper alloc]initWithDictionary:dictionary];
    
    CustomView *cView = [[CustomView alloc]init];
    CGRect frameRect = [cView rectFromModelJSON:cusViewMapper];
    cView.frame = frameRect;
    cView.backgroundColor = [UIColor colorWithRed:[cusViewMapper.RGBRed floatValue]
                                            green:[cusViewMapper.RGBGreen floatValue]
                                             blue:[cusViewMapper.RGBBlue floatValue]
                                            alpha:[cusViewMapper.RGB_alpha floatValue]];
    
    wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
    if (cView) {
        [dynamicLayout loadItemsForGroup:cusViewMapper.subDictionary AndBaseView:cView];
    }
    cView.layer.cornerRadius = [cusViewMapper.cornerRadies floatValue];
    cView.tag = [cusViewMapper.tag integerValue];
    cView.customViewBlock = ^(CustomView *customView){
        NSLog(@"CustomView 的初始响应设定");
    };
    return cView;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)setimageWithView:(Myblock)block{
    self.customViewBlock = block;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    self.customViewBlock(self);
    
    //    NSLog(@"hello");
}
#pragma mark 辅助方法
-(CGRect)rectFromModelJSON:(CustomViewOfMapper *)customViewOfMapper{
    CGRect table_rect;
    table_rect.origin.x = [customViewOfMapper.xPointOfRect floatValue];
    table_rect.origin.y = [customViewOfMapper.yPointOfRect floatValue];
    table_rect.size.width = [customViewOfMapper.widthOfRect floatValue];
    table_rect.size.height = [customViewOfMapper.heightOfRect floatValue];
    return table_rect;
}

@end
