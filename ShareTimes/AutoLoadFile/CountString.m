//
//  CountString.m
//  shiyan2
//
//  Created by 传晟 on 14-3-20.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "CountString.h"

@implementation CountString

//一个带有加减乘除的字符串转为运算结果的方法
-(CGFloat )operatorString:(NSString *)string{
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"+-*/"];
    NSMutableArray *numArrayOfString = (NSMutableArray *)[string componentsSeparatedByCharactersInSet:characterSet];
    
    NSCharacterSet *fCharacterSet = [[NSCharacterSet characterSetWithCharactersInString:@"+-*/"] invertedSet];
    NSArray *typArrayOfString = [string componentsSeparatedByCharactersInSet:fCharacterSet];
    //过滤后只剩运算符号
    NSMutableArray *typeArray = [[NSMutableArray alloc]init];
    for (NSString *string0 in typArrayOfString) {
        if (![string0 isEqualToString:@""]) {
            [typeArray addObject:string0];
        }
    }
    //如果第一个数字是负数进行优化
    if ([self judgeFirstNumber:string]) {
        [numArrayOfString removeObjectAtIndex:0];
        NSString *ls = [numArrayOfString objectAtIndex:0];
        NSString *lst = [NSString stringWithFormat:@"-%@",ls];
        [numArrayOfString replaceObjectAtIndex:0 withObject:lst];
        [typeArray removeObjectAtIndex:0];
    }
    NSMutableArray *AMarray = [[NSMutableArray alloc]init];
    //计算乘除
    float a,b,c;
    int x= 0;
    for (int i=0; i<typeArray.count; i++) {
        NSString *str = [typeArray objectAtIndex:i];
        if ([str isEqualToString:@"*"]||[str isEqualToString:@"/"]) {
            if ([str isEqualToString:@"*"]) {
                //每次乘除运算都会使Narray里面的元素减少1个，下次运算时要i-x
                a=[[numArrayOfString objectAtIndex:i-x]floatValue];
                b=[[numArrayOfString objectAtIndex:i+1-x]floatValue];
                c=a*b;
                NSNumber *lNumber=[NSNumber numberWithFloat:c];
                [numArrayOfString removeObjectAtIndex:i-x];
                [numArrayOfString replaceObjectAtIndex:i-x withObject:lNumber];
                x++;//统计乘除运算次数
            }
            if ([str isEqualToString:@"/"]) {
                a=[[numArrayOfString objectAtIndex:i-x]floatValue];
                b=[[numArrayOfString objectAtIndex:i+1-x]floatValue];
                c=a/b;
                NSNumber *lNumber=[NSNumber numberWithFloat:c];
                [numArrayOfString removeObjectAtIndex:i-x];
                [numArrayOfString replaceObjectAtIndex:i-x withObject:lNumber];
                x++;//统计乘除运算次数
            }
        }
        else{
            [AMarray addObject:str];
        }
    }
//    NSLog(@"%@",AMarray);
    
    //计算加减
    float d = [[numArrayOfString objectAtIndex:0]floatValue];
    for (int i=0; i<AMarray.count; i++) {
        NSString *lSt=[AMarray objectAtIndex:i];
        if ([lSt isEqualToString:@"+"]) {
            d=d+[[numArrayOfString objectAtIndex:i+1]floatValue];
        }
        if ([lSt isEqualToString:@"-"]) {
            d=d-[[numArrayOfString objectAtIndex:i+1]floatValue];
        }
    }
    return d;
}
//判断第一个数字是否是负数的方法
-(BOOL) judgeFirstNumber:(NSString *) string1 {
    NSString *typeString =@"-";
    if ([typeString isEqualToString:[string1 substringToIndex:1]]) {
        return YES;
    }
    return NO;
}

#pragma mark 消除括号的方法
-(NSString *)getStatement:(NSString *)string{
//    self.finallyString = [[NSString alloc]init];
    static NSString* finallyString;
    NSInteger AfterBraketLocation = 0;
    NSInteger BeforeBracketLocation;
    NSString *InBracketString;//括号中的字符串
    //判断得到的字符串中是否有括号
    NSString *AfterbraketString=@")";
    NSRange AfterbraketStringRange=[string rangeOfString:AfterbraketString];
    if (AfterbraketStringRange.location==NSNotFound) {
        finallyString=string;
        return finallyString;
    }else{
        //找到第一个后括号的位置
        for (int i=0; i<string.length; i++) {
            NSString *lString=[string substringWithRange:NSMakeRange(i, 1)];
            if ([lString isEqualToString:@")"]) {
                AfterBraketLocation=i;
                break;
            }
        }
        //找到最后一个前括号的位置
        for (int i=1; i<string.length; i++) {
            NSString *lString=[string substringWithRange:NSMakeRange(AfterBraketLocation-i, 1)];
            if ([lString isEqualToString:@"("]) {
                BeforeBracketLocation=AfterBraketLocation-i;
                break;
            }
        }
        
        //取出括号中得字符串
        InBracketString=[string substringWithRange:NSMakeRange(BeforeBracketLocation+1,AfterBraketLocation-BeforeBracketLocation-1)];
//        NSLog(@"%@",InBracketString);
        //去除找到的第一组最里面的括号
        NSRange range;
        range.length=AfterBraketLocation-BeforeBracketLocation+1;
        range.location=BeforeBracketLocation;
        //重复执行去除括号的方法，直到没有括号为止
        //如果括号里的表达式算出来不为负
        if ([self operatorString:InBracketString]>=0) {
            NSString *replaceString = [NSString stringWithFormat:@"%ld",(long)[self operatorString:InBracketString]];
            string=[string stringByReplacingCharactersInRange:range withString:replaceString];
//            NSLog(@"%@",string);
            [self getStatement:string];
        }else{
            NSString *replaceString = [NSString stringWithFormat:@"%ld",(long)[self operatorString:InBracketString]];
            NSString *lString=[string stringByReplacingCharactersInRange:range withString:replaceString];
            NSMutableString *MBstring=[[NSMutableString alloc]initWithString:lString];
            NSRange Brange;
            Brange.location=BeforeBracketLocation;
            Brange.length=1;
            //若“-”号前面没有非乘除运算符，在字符串最前面加“-”，并移除原来的“-”
            NSString *Zstring=[lString substringToIndex:BeforeBracketLocation];
            NSRange BeforBracketrange=[Zstring rangeOfString:@"("];
            NSRange Addrange=[Zstring rangeOfString:@"+"];
            NSRange Minusrange=[Zstring rangeOfString:@"-"];
            if (BeforBracketrange.location==NSNotFound&&Addrange.location==NSNotFound&&Minusrange.location==NSNotFound) {
                [MBstring deleteCharactersInRange:Brange];
                [MBstring insertString:@"-" atIndex:0];
            }
            else{
                //若“-”号前面有非乘除运算符，找到“-”号前面第一非乘除运算符，若为括号，在括号后面加“-”并移除原来的“-”
                for (int i=1; i<MBstring.length; i++) {
                    NSString *Bstring=[lString substringWithRange:NSMakeRange(BeforeBracketLocation-i, 1)];
                    if ([Bstring isEqualToString:@"("]) {
                        [MBstring deleteCharactersInRange:Brange];
                        [MBstring insertString:@"-" atIndex:BeforeBracketLocation-i+1];
//                        NSLog(@"MBString = %@",MBstring);
                        break;
                    }
                    //若为“-”号，把其变为“+”
                    else if ([Bstring isEqualToString:@"-"]) {
                        NSRange Crange;
                        Crange.location=BeforeBracketLocation-i;
                        Crange.length=1;
                        [MBstring deleteCharactersInRange:Brange];
                        [MBstring replaceCharactersInRange:Crange withString:@"+"];
//                        NSLog(@"MBString = %@",MBstring);
                        break;
                    }
                    //若为“+”，把其变为“-”
                    else if ([Bstring isEqualToString:@"+"]) {
                        NSRange Drange;
                        Drange.location=BeforeBracketLocation-i;
                        Drange.length=1;
                        [MBstring deleteCharactersInRange:Brange];
                        [MBstring replaceCharactersInRange:Drange withString:@"-"];
//                        NSLog(@"MBString = %@",MBstring);
                        break;
                    }
                }
            }
            string=MBstring;
            [self getStatement:string];
        }
    }
//    NSLog(@"%@",finallyString);
    return finallyString;
}

@end
