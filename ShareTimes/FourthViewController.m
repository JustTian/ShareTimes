//
//  FourthViewController.m
//  ShareTimes
//
//  Created by 传晟 on 14-6-9.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "FourthViewController.h"
#import "HeaderForCustoms.h"
@interface FourthViewController ()
@property(nonatomic,retain)NSArray *comomArray;
@property(nonatomic,retain)NSArray *cLabelArray;
@end

#define BackName1 @"4.png"
#define BackName2 @"3.png"
@implementation FourthViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"试题测试";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *rightBT = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(rightBTClick:)];
    self.navigationItem.rightBarButtonItem = rightBT;
    
    // Do any additional setup after loading the view.
    wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
//    NSString *nameJstring = @"fourthViewController.json";
//    NSString *nameJstring = @"textViewController.json";
    NSString *nameJstring = @"voiceViewController.json";
    NSDictionary *lDictionary = [self dictionaryFromJSONName:nameJstring];
    //利用载入类描绘出视图界面
    [dynamicLayout drawingInterfaceFromJSONName:nameJstring AndBaseView:self.view];
    
    NSDictionary *ldic = [dynamicLayout getItemsOfGroup:lDictionary];//直接调用解析的json文件的第一个字典----返回所有控件的tag值与类型的字典
    NSLog(@"***************%@",ldic);
    
    NSArray *widgetArray = [dynamicLayout instanceCustomButtonFromDic:ldic AndSupperView:self.view];//返回实例化自定义按钮的对象数组
    [self customButtonClick:widgetArray];//执行响应的响应事件
    self.comomArray = widgetArray;

    NSArray *customViewArray = [dynamicLayout instanceCustomViewFromDic:ldic AndSupperView:self.view];
    [self customViewClick:customViewArray];
    
    //取出文本视图
    NSArray *textFieldArray = [dynamicLayout instanceTextFieldFromDic:ldic AndSupperView:self.view];
    [self customTextFieldClick:textFieldArray];
    
    //取出label数组
    self.cLabelArray = [dynamicLayout instanceCustomLabelFromDic:ldic AndSupperView:self.view];
    
}
-(void)rightBTClick:(UIBarButtonItem *)sender{
    for (int i =0; i<self.cLabelArray.count; i++) {
        CustomLabel *cla = [self.cLabelArray objectAtIndex:i];
        cla.text = @"gaibain";
    }
    NSLog(@"rightBarButton be touch");
}
-(void)customButtonClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[customButton class]]) {
                customButton *cButton = [array objectAtIndex:i];
                __block customButton *cB = cButton;
                cButton.myblock = ^(customButton *button){
                    if (cB.clickOfType == 1) {
//                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                    if (cB.clickOfType == 4) {
                        UIImage *image1 = [UIImage imageNamed:BackName1];
                        UIImage *image2 = [UIImage imageNamed:BackName2];
                        if ([[cB backgroundImageForState:UIControlStateNormal]isEqual:image2]) {
                            [cB setBackgroundImage:image1 forState:UIControlStateNormal];
                        }else{
                            [cB setBackgroundImage:image2 forState:UIControlStateNormal];
                        }

                    }
                    //                    if (cB.clickOfType == 3) {
                    //                        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"warning" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                    //                        [alertView show];
                    //                        NSLog(@"%ld",(long)alertView.cancelButtonIndex);
                    //                        NSLog(@"%ld",(long)alertView.firstOtherButtonIndex);
                    //                    }
                    NSLog(@"____________%@",[cB class]);
                };
                
            }
        }
        
    }
}

-(void)customViewClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CustomView class]]){
                CustomView *cView = [array objectAtIndex:i];
                __block CustomView *cV = cView;
                cView.customViewBlock = ^(CustomView *viwe){
                    
                    //点击让其子button被选中
                    for (int j = 0; j<[cV.subviews count]; j++) {
                        if ([[cV.subviews objectAtIndex:j]isKindOfClass:[customButton class]]) {
                            customButton *cButton = [cV.subviews objectAtIndex:j];
                            UIImage *image1 = [UIImage imageNamed:BackName1];
                            UIImage *image2 = [UIImage imageNamed:BackName2];
                            if ([[cButton backgroundImageForState:UIControlStateNormal]isEqual:image2]) {
                                [cButton setBackgroundImage:image1 forState:UIControlStateNormal];
                            }else{
                                [cButton setBackgroundImage:image2 forState:UIControlStateNormal];
                            }

                        }
                    }//over
                    
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
