//
//  TextViewController.m
//  ShareTimes
//
//  Created by WZHEN on 14-6-23.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "SelectViewController.h"
#import "PictureViewController.h"
#import "VoiceViewController.h"
#import "TextViewController.h"

#import "HeaderForCustoms.h"
#import "BMKGeocodeSearch.h"
#import "BMKLocationService.h"

@interface TextViewController ()<BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate>

@property (nonatomic) BMKGeoCodeSearch *searcher;
@property (nonatomic) BMKLocationService *locationService;

@end

@implementation TextViewController{
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
    
    NSString *nameString = @"textViewController.json";
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
    //初始化Location
    _locationService = [[BMKLocationService alloc]init];
    _locationService.delegate = self;
    //初始化sercher
    _searcher = [[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;

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
                    
                    if (cB.clickOfType == 3) {
                        
                        //启动LocationService
                        [_locationService startUserLocationService];
                        
                    }

                    NSLog(@"____________%@",[cB class]);
                };
                
            }
        }
        
    }
}

#pragma mark -定位代理方法
//处理位置坐标更新
- (void)didUpdateUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    UILabel *label = (UILabel *)[self.view viewWithTag:2012];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:10];
    label.text = [NSString stringWithFormat:@"纬度:%f,经度:%f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude];
    //停止LocationService
    [_locationService stopUserLocationService];
    
    //发起反向地理编码检索
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:reverseGeocodeSearchOption];
    //    [reverseGeoCodeSearchOption release];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}
#pragma mark-地理反编码代理
//接收反向地理编码结果

- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    
    NSString *resultString = @"抱歉，未找到结果";
    if (error == BMK_SEARCH_NO_ERROR) {
        // 在此处理正常结果
        
        if (result.address.length) {
            resultString= result.address;
        }else{
            NSLog(@"result = %@",result.address);
        }
        
    }
    customButton *cBut = (customButton *)[self.view viewWithTag:1012];
    cBut.titleLabel.font = [UIFont systemFontOfSize:10];
    [cBut setTitle:resultString forState:UIControlStateNormal];
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
