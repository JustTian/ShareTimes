//
//  FunctionViewController.m
//  ShareTimes
//
//  Created by 传晟 on 14-6-5.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "FunctionViewController.h"

@interface FunctionViewController ()

@end

@implementation FunctionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"功能界面";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
//    wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
//    
//    NSString *nameString = @".json";
//    NSDictionary *lDictionary = [self dictionaryFromJSONName:nameString];
//    [dynamicLayout drawingInterfaceFromJSONName:nameString AndBaseView:self.view];
//    
//    NSDictionary *lDic = [dynamicLayout getItemsOfGroup:lDictionary];
//    NSLog(@"控件：%@",lDic);
//    
//    /*
//     *
//     *此后主要时取出实例化控件并做事件响应处理
//     *
//     */
//    
//    //通过tag值取出实例化的控件
//    NSArray *buttonArray = [dynamicLayout instanceCustomButtonFromDic:lDic AndSupperView:self.view];
//    //取出的实例化控件添加响应方法
//    [self customButtonClick:buttonArray];
//    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
