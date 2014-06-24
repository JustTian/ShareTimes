//
//  CommonDataClass.h
//  ShareTimes
//
//  Created by 传晟 on 14-6-5.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,wTopicalType) {
    topicalTypeOfSelect = 0,      //
    topicalTypeOfPicture  = 1,      //
    topicalTypeOfVoice = 2,//
    topicalTypeOfText = 3,//
};

@interface CommonDataClass : NSObject
+(CommonDataClass *)sharCommonData;

@property(nonatomic,strong) NSString *userID;
@property(nonatomic,assign) wTopicalType topicalType;

@property (nonatomic,retain) NSDictionary *dataDic;
//@property(NSString,strong) NSString *
@end
