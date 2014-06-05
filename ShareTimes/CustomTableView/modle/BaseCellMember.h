//
//  BaseCellMember.h
//  shiyan4
//
//  Created by 传晟 on 14-4-23.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseCellMember : NSObject
@property (nonatomic,copy) NSString *mainString;
@property (nonatomic,copy) NSString *detailString;
@property (nonatomic,copy)   UIImage  *imageName;
@property (nonatomic,assign) BOOL     isShowImage;
@end
