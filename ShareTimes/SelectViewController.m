//
//  SelectViewController.m
//  ShareTimes
//
//  Created by WZHEN on 14-6-23.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "SelectViewController.h"
#import "HeaderForCustoms.h"
#import "FourthViewController.h"

#define BackName1 @"4.png"
#define BackName2 @"3.png"

@interface SelectViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>
{
    BOOL isScreen;//判断点击后是否加载满屏
    CGRect imageVRect;//记录图片视图变化前的大小
    NSMutableArray *addIVArray;
    UIScrollView *fScrollView;//装载图片视图的滚动视图
    CImageVIew *selectView;
    
    
}

@end

@implementation SelectViewController{
    NSMutableData *ldata;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setHidesBottomBarWhenPushed:YES]; //设置tabBarController为隐藏
    }
    return self;
}
//地角事件监听
-(void)fButtonClick:(UIButton *)sender{
    //    FourthViewController *fVC = [[FourthViewController alloc]init];
    [self.navigationController popToRootViewControllerAnimated:YES];
}
-(void)sButtonClick:(UIButton *)sender{
//    FourthViewController *fVC = [[FourthViewController alloc]init];
//    [self.navigationController pushViewController:fVC animated:YES];
    //    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ldata = [[NSMutableData alloc]init];
    
    //添加上一页以及下一页按钮;
    UIView *dView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40)];
    dView.backgroundColor = [UIColor grayColor];
    UIButton *fButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 10, 20, 20)];
    [fButton setBackgroundImage:[UIImage imageNamed:@"retreat"] forState:UIControlStateNormal];
    [fButton addTarget:self action:@selector(fButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    //    [fButton setTitle:@"shang" forState:UIControlStateNormal];
    [dView addSubview:fButton];
    
    UIButton *sButton = [[UIButton alloc]initWithFrame:CGRectMake(280, 10, 20, 20)];
    //    [sButton setTitle:@"xia" forState:UIControlStateNormal];
    [sButton setBackgroundImage:[UIImage imageNamed:@"advance"] forState:UIControlStateNormal];
    [sButton addTarget:self action:@selector(sButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [dView addSubview:sButton];
    [self.view addSubview:dView];

    // Do any additional setup after loading the view.
    
    //    self.view.backgroundColor = [UIColor grayColor];
    
    //从本地json文件加载
    wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
    
    NSString *nameString = @"selectViewController.json";
    NSDictionary *lDictionary = [self dictionaryFromJSONName:nameString];
    [dynamicLayout drawingInterfaceFromJSONName:nameString AndBaseView:self.view];
    
    NSDictionary *ldic = [dynamicLayout getItemsOfGroup:lDictionary];
    NSLog(@"控件：%@",ldic);
    NSArray *widgetArray = [dynamicLayout instanceCustomButtonFromDic:ldic AndSupperView:self.view];//返回实例化自定义按钮的对象数组
    [self customButtonClick:widgetArray];//执行响应的响应事件
    self.comomArray = widgetArray;
    
    NSArray *customViewArray = [dynamicLayout instanceCustomViewFromDic:ldic AndSupperView:self.view];
    [self customViewClick:customViewArray];
    
    //取出文本视图
    NSArray *textFieldArray = [dynamicLayout instanceTextFieldFromDic:ldic AndSupperView:self.view];
    [self customTextFieldClick:textFieldArray];
    
    NSArray *textViewArray = [dynamicLayout instanceTextViewFromDic:ldic AndSupperView:self.view];
    [self customTextViewClick:textViewArray];
    //取出label数组
    self.cLabelArray = [dynamicLayout instanceCustomLabelFromDic:ldic AndSupperView:self.view];
    
    
    //从网络获取加载
    //    NSString *lstr = @"op=getallprojects&data={\"UserID\":\"21\"}";
    //    NSString *string = [NSString stringWithFormat:@"http://%@/es/server/esservice.ashx",ServerIP];
    //    NSURL *lurl = [NSURL URLWithString:string];
    //    NSMutableURLRequest *lmutableURLRequest = [NSMutableURLRequest requestWithURL:lurl];
    //    [lmutableURLRequest setHTTPMethod:@"post"];
    //    [lmutableURLRequest setHTTPBody:[lstr dataUsingEncoding:NSUTF8StringEncoding]];
    //    NSURLConnection *lURLConnection = [NSURLConnection connectionWithRequest:lmutableURLRequest delegate:self];
    //    [lURLConnection start];
    
    
    /*
     *
     *此后主要时取出实例化控件并做事件响应处理
     *
     */
    
    //通过tag值取出实例化的控件
    //    NSArray *buttonArray = [dynamicLayout instanceCustomButtonFromDic:lDic AndSupperView:self.view];
    //取出的实例化控件添加响应方法
    //    [self customButtonClick:buttonArray]
    
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [ldata setLength:0];
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [ldata appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSDictionary *ldicionary = [NSJSONSerialization JSONObjectWithData:ldata options:NSJSONReadingAllowFragments error:nil];
    //    NSLog(@"54556%@",ldicionary);
    if (![[ldicionary objectForKey:@"status"]isEqualToString:@"failure"]) {
        wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
        [dynamicLayout drawingInterfaceFromURLDictionary:ldicionary AndBaseView:self.view];
        
        NSDictionary *lDic = [dynamicLayout getItemsOfGroup:ldicionary];
        NSLog(@"控件：%@",lDic);
        NSArray *cArray = [dynamicLayout instanceCustomButtonFromDic:lDic AndSupperView:self.view];//返回实例化自定义按钮的对象数组
        [self customButtonClick:cArray];//执行响应的响应事件
        
    }else{
        UIAlertView *alerVIEW = [[UIAlertView alloc]initWithTitle:@"提示" message:@"获取数据失败" delegate:self cancelButtonTitle:@"cancle" otherButtonTitles: nil];
        [alerVIEW show];
    }
    
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
                    //语音功能
                    if (cB.clickOfType == 10) {
                        NSLog(@"yuyin");
                    }
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
