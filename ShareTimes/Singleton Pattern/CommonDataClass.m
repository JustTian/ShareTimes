//
//  CommonDataClass.m
//  ShareTimes
//
//  Created by 传晟 on 14-6-5.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "CommonDataClass.h"

static CommonDataClass *CDClass = nil;
@implementation CommonDataClass
+(CommonDataClass *)sharCommonData{
    @synchronized(self){
        if (CDClass == nil) {
            CDClass = [[CommonDataClass alloc]init];
//            CDClass.topicalType = topicalTypeOfSelect;
        }
    }
    return CDClass;
}
@end
