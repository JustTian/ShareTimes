//
//  VoiceViewController.m
//  ShareTimes
//
//  Created by WZHEN on 14-6-23.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "VoiceViewController.h"

@interface VoiceViewController ()

@end

@implementation VoiceViewController{
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
    
    NSString *nameString = @"voiceViewController.json";
    NSDictionary *lDictionary = [self dictionaryFromJSONName:nameString];
    [dynamicLayout drawingInterfaceFromJSONName:nameString AndBaseView:self.view];
    
    NSDictionary *lDic = [dynamicLayout getItemsOfGroup:lDictionary];
    NSLog(@"控件：%@",lDic);
    NSArray *cArray = [dynamicLayout instanceCustomButtonFromDic:lDic AndSupperView:self.view];//返回实例化自定义按钮的对象数组
    [self customButtonClick:cArray];//执行响应的响应事件
    
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
