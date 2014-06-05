//
//  CountString.h
//  shiyan2
//
//  Created by 传晟 on 14-3-20.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CountString : NSObject
//@property(nonatomic,retain)NSString* finallyString;
-(CGFloat )operatorString:(NSString *)string;
-(NSString *)getStatement:(NSString *)string;
-(BOOL) judgeFirstNumber:(NSString *) string1;
@end
