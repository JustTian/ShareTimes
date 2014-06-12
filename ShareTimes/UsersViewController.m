//
//  UsersViewController.m
//  ShareTimes
//
//  Created by 传晟 on 14-6-5.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "UsersViewController.h"
#import "customButton.h"

@interface UsersViewController ()

@end

@implementation UsersViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"个人中心";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
    
    NSString *nameString = @"usersViewController.json";
    NSDictionary *lDictionary = [self dictionaryFromJSONName:nameString];
    [dynamicLayout drawingInterfaceFromJSONName:nameString AndBaseView:self.view];
    
    NSDictionary *lDic = [dynamicLayout getItemsOfGroup:lDictionary];
    NSLog(@"控件：%@",lDic);
    
    NSArray *widgetArray = [dynamicLayout instanceCustomButtonFromDic:lDic AndSupperView:self.view];//返回实例化自定义按钮的对象数组
    [self customButtonClick:widgetArray];//执行响应的响应事件

}

-(void)customButtonClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[customButton class]]) {
                customButton *cButton = [array objectAtIndex:i];
                __block customButton *cB = cButton;
                cButton.myblock = ^(customButton *button){
                    
                    if (cB.clickOfType == 0) {
                        
                    }
                    if (cB.clickOfType == 1) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                    NSLog(@"____________%@",[cB class]);
                };
                
            }
        }
        
    }
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
