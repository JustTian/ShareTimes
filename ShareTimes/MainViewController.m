//
//  MainViewController.m
//  ShareTimes
//
//  Created by 传晟 on 14-6-5.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "MainViewController.h"
#import "CImageVIew.h"



@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
    
    
    //    NSString *lstring = [[NSBundle mainBundle] resourcePath];
    //    NSString *path = [lstring stringByAppendingPathComponent:@"baseViewController.json"];
    //    NSData *ldata = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    //    NSDictionary *lDictionary = [NSJSONSerialization JSONObjectWithData:ldata options:NSJSONReadingAllowFragments error:nil];
    //
    //    int rows = [[lDictionary objectForKey:@"rowsOfType"] intValue];//纪录json描绘的有多少行
    //    for (int i= 0; i<rows; i++) {
    //        NSString *keyOfGroupItems = [NSString stringWithFormat:@"itemsOfGroup_%d",i];
    //        NSDictionary *lDic = [lDictionary objectForKey:keyOfGroupItems];
    //        [dynamicLayout loadItemsForGroup:lDic AndBaseView:self.view];
    //    }
    
    //通过JSON名称解析出需要的字典
    NSString *nameJstring = @"baseViewController.json";
    NSDictionary *lDictionary = [self dictionaryFromJSONName:nameJstring];
    //利用载入类描绘出视图界面
    [dynamicLayout drawingInterfaceFromJSONName:nameJstring AndBaseView:self.view];
    
    NSDictionary *ldic = [dynamicLayout getItemsOfGroup:lDictionary];//直接调用解析的json文件的第一个字典----返回所有控件的tag值与类型的字典
    NSLog(@"***************%@",ldic);
    NSArray *widgetArray = [dynamicLayout instanceCustomButtonFromDic:ldic AndSupperView:self.view];//返回实例化自定义按钮的对象数组
    [self customButtonClick:widgetArray];//执行响应的响应事件
    
    
//    NSArray *imageArray = [dynamicLayout instanceCImageViewFromDic:ldic AndSupperView:self.view];
//    CImageVIew *iamgV = [imageArray objectAtIndex:0];
//    if ([iamgV isAnimating]) {
//        [iamgV performSelector:@selector(stopAnimating) withObject:nil afterDelay:2];
//        [iamgV performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"6"] afterDelay:2.1];
//    }
    
    NSArray *pageControlArray = [dynamicLayout instanceCPageControlFromDic:ldic AndSupperView:self.view];
    //    NSLog(@"%@",pageControlArray);
    [self customPageControlClick:pageControlArray];
    
    
    NSArray *segmentControlArray = [dynamicLayout instanceCSegmentControlFromDic:ldic AndSupperView:self.view];
    //    NSLog(@"%@",segmentControlArray);
    [self customSegmentClick:segmentControlArray];
    
    NSArray *sliderArray = [dynamicLayout instanceSliderFromDic:ldic AndSupperView:self.view];
    [self customSliderClick:sliderArray];
    
    NSArray *swtichArray = [dynamicLayout instanceSwitchFromDic:ldic AndSupperView:self.view];
    [self customSwitchClick:swtichArray];
    
    NSArray *textFieldArray = [dynamicLayout instanceTextFieldFromDic:ldic AndSupperView:self.view];
    [self customTextFieldClick:textFieldArray];
    
    NSArray *customViewArray = [dynamicLayout instanceCustomViewFromDic:ldic AndSupperView:self.view];
    [self customViewClick:customViewArray];

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
