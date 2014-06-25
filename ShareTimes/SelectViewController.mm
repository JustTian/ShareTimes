//
//  SelectViewController.m
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
#import "FourthViewController.h"
#import "BMKGeocodeSearch.h"
#import "BMKLocationService.h"



#define BackName1 @"4.png"
#define BackName2 @"3.png"

@interface SelectViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate>
{
    
    
    BOOL isScreen;//判断点击后是否加载满屏
    CGRect imageVRect;//记录图片视图变化前的大小
    NSMutableArray *addIVArray;
    UIScrollView *fScrollView;//装载图片视图的滚动视图
    CImageVIew *selectView;
    
    
    
}
@property (nonatomic) BMKGeoCodeSearch *searcher;
@property (nonatomic) BMKLocationService *locationService;
@end

@implementation SelectViewController{
    NSMutableData *ldata;
    
//    int   selectNUM;
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

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    NSLog(@"%@",[CommonDataClass sharCommonData].dataDic);
    
//    wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
//    
//    [dynamicLayout drawingInterfaceFromURLDictionary:[CommonDataClass sharCommonData].dataDic AndBaseView:self.view];
//    
//    NSDictionary *lDic = [dynamicLayout getItemsOfGroup:[CommonDataClass sharCommonData].dataDic];
//    NSLog(@"控件：%@",lDic);
//    
//    
//    NSArray *cArray = [dynamicLayout instanceCustomButtonFromDic:lDic AndSupperView:self.view];//返回实例化自定义按钮的对象数组
//    [self customButtonClick:cArray];//执行响应的响应事件
//    NSArray *customViewArray = [dynamicLayout instanceCustomViewFromDic:lDic AndSupperView:self.view];
//    [self customViewClick:customViewArray];
//    //取出label数组
//    self.cLabelArray = [dynamicLayout instanceCustomLabelFromDic:lDic AndSupperView:self.view];
    
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
//    self.navigationController.viewControllers
    
//    [CommonDataClass sharCommonData].timuDataArray = oArray;
//    NSDictionary *oDic = [oArray objectAtIndex:0];
    
//    [CommonDataClass sharCommonData].dataDic = [oDic objectForKey:@"Content"];
//    [CommonDataClass sharCommonData].selectNum = 0;

    [self.navigationController setNavigationBarHidden:YES];
    if ([CommonDataClass sharCommonData].selectNum < [CommonDataClass sharCommonData].timuDataArray.count-1) {
       NSInteger i = [CommonDataClass sharCommonData].selectNum;
        i++;
        [CommonDataClass sharCommonData].selectNum = i;
        NSDictionary *oDic = [[CommonDataClass sharCommonData].timuDataArray objectAtIndex:i];
        [CommonDataClass sharCommonData].dataDic = [oDic objectForKey:@"Content"];
        if ([[oDic objectForKey:@"TitleType"]isEqualToString:@"0"]) {
            SelectViewController *selec  = [[SelectViewController alloc]init];
            [self.navigationController pushViewController:selec animated:YES];
        }
        
        if ([[oDic objectForKey:@"TitleType"]isEqualToString:@"1"]) {
            SelectViewController *selec  = [[SelectViewController alloc]init];
            [self.navigationController pushViewController:selec animated:YES];
        }

        if ([[oDic objectForKey:@"TitleType"]isEqualToString:@"2"]) {
            TextViewController *selec  = [[TextViewController alloc]init];
            [self.navigationController pushViewController:selec animated:YES];
        }

        if ([[oDic objectForKey:@"TitleType"]isEqualToString:@"3"]) {
            PictureViewController *selec  = [[PictureViewController alloc]init];
            [self.navigationController pushViewController:selec animated:YES];
        }

    }
    
    
//    [CommonDataClass sharCommonData].topicalType =  topicalTypeOfSelect;
//    [self jumpViewControllerFromTopicType:[CommonDataClass sharCommonData].topicalType];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}

-(void)jumpViewControllerFromTopicType:(wTopicalType)topicType{
    switch (topicType) {
        case topicalTypeOfSelect:
            for (int i = 0; i<self.navigationController.viewControllers.count; i++) {
                if ([[self.navigationController.viewControllers objectAtIndex:i]isKindOfClass:[SelectViewController class]]) {
                    if ([self.navigationController.visibleViewController isKindOfClass:[SelectViewController class]]) {
                        SelectViewController *selectVC = (SelectViewController *)self.navigationController.visibleViewController;
                        for (int j= 0; j<selectVC.view.subviews.count; j++) {
                            [[selectVC.view.subviews objectAtIndex:j]removeFromSuperview];
                        }
                        NSString *nameString = @"fourthViewController.json";
                        [CommonDataClass sharCommonData].dataDic = [self dictionaryFromJSONName:nameString];
                    
                        [selectVC setFootHandles:selectVC.view];
                        
                        [self viewWillAppear:YES];
                        
//                        wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
//                        
//                        [dynamicLayout drawingInterfaceFromURLDictionary:[CommonDataClass sharCommonData].dataDic AndBaseView:selectVC.view];
//                        
//                        NSDictionary *lDic = [dynamicLayout getItemsOfGroup:[CommonDataClass sharCommonData].dataDic];
//                        NSLog(@"控件：%@",lDic);
//                        
//                        
//                        NSArray *cArray = [dynamicLayout instanceCustomButtonFromDic:lDic AndSupperView:selectVC.view];//返回实例化自定义按钮的对象数组
//                        [self customButtonClick:cArray];//执行响应的响应事件
//                        NSArray *customViewArray = [dynamicLayout instanceCustomViewFromDic:lDic AndSupperView:selectVC.view];
//                        [self customViewClick:customViewArray];
//                        //取出label数组
//                        self.cLabelArray = [dynamicLayout instanceCustomLabelFromDic:lDic AndSupperView:selectVC.view];
                        
                    }else{
                        SelectViewController *selectVC = [self.navigationController.viewControllers objectAtIndex:i];
                        for (int j= 0; j<selectVC.view.subviews.count; j++) {
                            [[selectVC.view.subviews objectAtIndex:j]removeFromSuperview];
                        }
                        NSString *nameString = @"fourthViewController.json";
                        [CommonDataClass sharCommonData].dataDic = [self dictionaryFromJSONName:nameString];
                        [self.navigationController popToViewController:selectVC animated:YES];

                    }
                    
                }else{
                    //
                }
            }
            break;
            case topicalTypeOfPicture:
            for (int i = 0; i<self.navigationController.viewControllers.count; i++) {
                if ([[self.navigationController.viewControllers objectAtIndex:i]isKindOfClass:[PictureViewController class]]) {
                    PictureViewController *pictureVC = [self.navigationController.viewControllers objectAtIndex:i];
                    for (int j= 0; j<pictureVC.view.subviews.count; j++) {
                        [[pictureVC.view.subviews objectAtIndex:j]removeFromSuperview];
                    }
                    wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
                    
                    NSString *nameString = @"selectViewController.json";
                    NSDictionary *lDictionary = [self dictionaryFromJSONName:nameString];
                    [dynamicLayout drawingInterfaceFromJSONName:nameString AndBaseView:pictureVC.view];
                    
                    NSDictionary *ldic = [dynamicLayout getItemsOfGroup:lDictionary];
                    NSLog(@"控件：%@",ldic);
                 
                }
            }
            break;
        default:
            break;
    }
}

-(void)setFootHandles:(UIView *)view{
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
    [view addSubview:dView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    ldata = [[NSMutableData alloc]init];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setFootHandles:self.view];
    
    // Do any additional setup after loading the view.
    
    //    self.view.backgroundColor = [UIColor grayColor];
    
    //从本地json文件加载
   
    
//    NSString *nameString = @"selectViewController.json";
//    NSDictionary *lDictionary = [self dictionaryFromJSONName:nameString];
//    
//    [CommonDataClass sharCommonData].dataDic = lDictionary;
//    
//    wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
//    
//    [dynamicLayout drawingInterfaceFromURLDictionary:[CommonDataClass sharCommonData].dataDic AndBaseView:self.view];
//    
//    NSDictionary *lDic = [dynamicLayout getItemsOfGroup:[CommonDataClass sharCommonData].dataDic];
//    NSLog(@"控件：%@",lDic);
//    
//    
//    NSArray *cArray = [dynamicLayout instanceCustomButtonFromDic:lDic AndSupperView:self.view];//返回实例化自定义按钮的对象数组
//    [self customButtonClick:cArray];//执行响应的响应事件
//    NSArray *customViewArray = [dynamicLayout instanceCustomViewFromDic:lDic AndSupperView:self.view];
//    [self customViewClick:customViewArray];
//    //取出label数组
//    self.cLabelArray = [dynamicLayout instanceCustomLabelFromDic:lDic AndSupperView:self.view];
    
    
    //从网络获取加载
    if ([CommonDataClass sharCommonData].timuDataArray.count == 0) {
        NSString *lstr = @"op=getprojectinfo&data={\"UserID\":\"21\",\"ProjectID\":\"21\"}";
        NSString *string = [NSString stringWithFormat:@"http://%@/es/server/esservice.ashx",ServerIP];
        NSURL *lurl = [NSURL URLWithString:string];
        NSMutableURLRequest *lmutableURLRequest = [NSMutableURLRequest requestWithURL:lurl];
        [lmutableURLRequest setHTTPMethod:@"post"];
        [lmutableURLRequest setHTTPBody:[lstr dataUsingEncoding:NSUTF8StringEncoding]];
        NSURLConnection *lURLConnection = [NSURLConnection connectionWithRequest:lmutableURLRequest delegate:self];
        [lURLConnection start];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }else{
        NSLog(@"ldicionary  = %@",[CommonDataClass sharCommonData].dataDic);
        wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
        
        [dynamicLayout drawingInterfaceFromURLDictionary:[CommonDataClass sharCommonData].dataDic AndBaseView:self.view];
        
        NSDictionary *lDic = [dynamicLayout getItemsOfGroup:[CommonDataClass sharCommonData].dataDic];
        NSLog(@"控件：%@",lDic);
        
        
        NSArray *cArray = [dynamicLayout instanceCustomButtonFromDic:lDic AndSupperView:self.view];//返回实例化自定义按钮的对象数组
        [self customButtonClick:cArray];//执行响应的响应事件
        NSArray *customViewArray = [dynamicLayout instanceCustomViewFromDic:lDic AndSupperView:self.view];
        [self customViewClick:customViewArray];
        //取出label数组
        self.cLabelArray = [dynamicLayout instanceCustomLabelFromDic:lDic AndSupperView:self.view];

    }
    
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
//    NSLog(@"%@",ldata);
    NSDictionary *ldicionary = [NSJSONSerialization JSONObjectWithData:ldata options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"54556%@",ldicionary);
    if (![[ldicionary objectForKey:@"status"]isEqualToString:@"failure"]) {
//        [CommonDataClass sharCommonData].dataDic = ldicionary;
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        NSArray *oArray = [ldicionary objectForKey:@"items"];
        [CommonDataClass sharCommonData].timuDataArray = oArray;
        NSDictionary *oDic = [oArray objectAtIndex:0];
        
        [CommonDataClass sharCommonData].dataDic = [oDic objectForKey:@"Content"];
        [CommonDataClass sharCommonData].selectNum = 0;
        
        NSLog(@"ldicionary  = %@",[CommonDataClass sharCommonData].dataDic);
        wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
        
        [dynamicLayout drawingInterfaceFromURLDictionary:[CommonDataClass sharCommonData].dataDic AndBaseView:self.view];
        
        NSDictionary *lDic = [dynamicLayout getItemsOfGroup:[CommonDataClass sharCommonData].dataDic];
        NSLog(@"控件：%@",lDic);
        
        
        NSArray *cArray = [dynamicLayout instanceCustomButtonFromDic:lDic AndSupperView:self.view];//返回实例化自定义按钮的对象数组
        [self customButtonClick:cArray];//执行响应的响应事件
        NSArray *customViewArray = [dynamicLayout instanceCustomViewFromDic:lDic AndSupperView:self.view];
        [self customViewClick:customViewArray];
        //取出label数组
        self.cLabelArray = [dynamicLayout instanceCustomLabelFromDic:lDic AndSupperView:self.view];
        
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
                    if (cB.clickOfType == 3) {
                        
                        //启动LocationService
                        [_locationService startUserLocationService];
                        
                    }

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
