//
//  CommonDataClass.h
//  ShareTimes
//
//  Created by 传晟 on 14-6-5.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonDataClass : NSObject
+(CommonDataClass *)sharCommonData;

@property(nonatomic,strong) NSString *userID;
@end
