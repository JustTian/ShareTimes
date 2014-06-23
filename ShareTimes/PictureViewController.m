//
//  PictureViewController.m
//  ShareTimes
//
//  Created by WZHEN on 14-6-23.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "PictureViewController.h"
#import "HeaderForCustoms.h"

@interface PictureViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>
{
    BOOL isScreen;//判断点击后是否加载满屏
    CGRect imageVRect;//记录图片视图变化前的大小
    NSMutableArray *addIVArray;
    UIScrollView *fScrollView;//装载图片视图的滚动视图
    CImageVIew *selectView;
}

@end

@implementation PictureViewController{
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
    addIVArray = [[NSMutableArray alloc]init];
    
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
    
    NSString *nameString = @"pictureViewController.json";
    NSDictionary *lDictionary = [self dictionaryFromJSONName:nameString];
    [dynamicLayout drawingInterfaceFromJSONName:nameString AndBaseView:self.view];
    
    NSDictionary *lDic = [dynamicLayout getItemsOfGroup:lDictionary];
    NSLog(@"控件：%@",lDic);
    NSArray *cArray = [dynamicLayout instanceCustomButtonFromDic:lDic AndSupperView:self.view];//返回实例化自定义按钮的对象数组
    [self customButtonClick:cArray];//执行响应的响应事件
    
    //给图片视图添加点击事件
    NSArray *imageVArray = [dynamicLayout instanceCImageViewFromDic:lDic AndSupperView:self.view];
    [self imageViewAddClick:imageVArray];
    
    NSArray *scrollViewArray = [dynamicLayout instanceCustomScrollViewFromDic:lDic AndSupperView:self.view];
    
    for (int i =0; i<scrollViewArray.count; i++) {
        if ([[scrollViewArray objectAtIndex:i]isKindOfClass:[CustomScrollerView class]]){
            CustomScrollerView *cSView = [scrollViewArray objectAtIndex:i];
            
            if (cSView.tag ==8001) {
                for (int j = 0; j<cSView.subviews.count; j++) {
                    if ([[cSView.subviews objectAtIndex:j]isKindOfClass:[CImageVIew class]]) {
                        [addIVArray addObject:[cSView.subviews objectAtIndex:j]];
                    }
                }
                
            }
        }
    }
    //    selectView = [addIVArray objectAtIndex:0];
    
    [self cScrollerViewClick:scrollViewArray];
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

-(void)imageViewAddClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CImageVIew class]]) {
                CImageVIew *cIView = [array objectAtIndex:i];
                cIView.userInteractionEnabled = YES;
                if (cIView.tag == 10001) {
                    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick)];
                    [cIView addGestureRecognizer:tapGesture];
                    
                }else{
                    UITapGestureRecognizer *lTapgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap:)];
                    //                lTapgesture.numberOfTapsRequired = 2;
                    lTapgesture.numberOfTouchesRequired = 1;
                    [cIView addGestureRecognizer:lTapgesture];
                }
                
            }
        }
        
    }
    
}

-(void)Tap:(UITapGestureRecognizer *)sender{
    //    NSLog(@"top  %@",sender.view);
    
    UIImageView *limageV = (CImageVIew *)sender.view;
    //    selectView = (CImageVIew *)limageV;
    if (!isScreen) {
        for (int i=0; i<fScrollView.subviews.count; i++) {
            if (![[fScrollView.subviews objectAtIndex:i]isEqual:limageV]) {
                [[fScrollView.subviews objectAtIndex:i] setAlpha:0];
                UIImageView *iview = [fScrollView.subviews objectAtIndex:i];
                iview.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }
        }
        imageVRect = limageV.frame;
        [UIView animateWithDuration:1.0 animations:^{
            fScrollView.frame = CGRectMake(0, 0, 320+320-imageVRect.size.width, self.view.frame.size.height);
            fScrollView.backgroundColor = [UIColor clearColor];
            //            [fScrollView setContentOffset:CGPointMake(limageV.frame.origin.x-110, 0) animated:YES];
            limageV.frame = self.view.frame;
            [self.navigationController setNavigationBarHidden:YES];
            
        }];
        isScreen = YES;
    }else{
        [UIView animateWithDuration:1.0 animations:^{
            fScrollView.frame = CGRectMake(5, 220, 310, 100);
            fScrollView.backgroundColor = [UIColor colorWithRed:115/255.0 green:250/255.0 blue:250/255.0 alpha:1.0];
            
            limageV.frame = imageVRect;
            //            limageV.transform = CGAffineTransformMakeScale(1.0, 1.0);
            [fScrollView setContentOffset:CGPointMake(limageV.frame.origin.x-110, 0) animated:YES];
            [self.navigationController setNavigationBarHidden:NO];
            
        } completion:^(BOOL finish){
            for (int i=0; i<fScrollView.subviews.count; i++) {
                [[fScrollView.subviews objectAtIndex:i] setAlpha:1];
                
            }
        }];
        
        imageVRect = self.view.frame;
        isScreen = NO;
    }
    
    //    limageV.transform = CGAffineTransformMakeScale(4.5, 4.5);
    
}
-(void)tapClick{
    UIImageView *addView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
    addView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *lTapgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap:)];
    lTapgesture.numberOfTouchesRequired = 1;
    [addView addGestureRecognizer:lTapgesture];
    
    [addIVArray insertObject:addView atIndex:0];
    //滚动时的第一个视图
    selectView = [addIVArray objectAtIndex:0];
    
    UIImagePickerController *lpicer = [[UIImagePickerController alloc]init];
    lpicer.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:lpicer animated:YES completion:nil];
    lpicer.delegate = self;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@",info);
    UIImage *limage=[info objectForKey:@"UIImagePickerControllerOriginalImage"];
    [picker dismissViewControllerAnimated:YES completion:^{
        
        CATransition *ltransition = [CATransition animation];
        [ltransition setDuration:1.0];
        ltransition.delegate = self;
        [ltransition setType:@"rippleEffect"];
        [ltransition setSubtype:kCATransitionFromLeft];
        
        UIImageView *addView = [addIVArray objectAtIndex:0];
        [addView.layer addAnimation:ltransition forKey:@"animation"];
        addView.image=limage;
    }];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (int j=0; j<fScrollView.subviews.count; j++) {
        [[fScrollView.subviews objectAtIndex:j] removeFromSuperview];
    }
    for (int i = 0; i<addIVArray.count; i++) {
        UIImageView *iv = [addIVArray objectAtIndex:i];
        [UIView animateWithDuration:1.0 animations:^{
            iv.center = CGPointMake(fScrollView.frame.size.width/2+100*i, 50);
            if (i!= 0) {
                iv.transform = CGAffineTransformMakeScale(1, 1);;
            }else{
                iv.transform = CGAffineTransformMakeScale(1.25, 1.25);
            }
        }];
        [fScrollView addSubview:iv];
    }
    fScrollView.contentSize = CGSizeMake(addIVArray.count<3?320:addIVArray.count*100+110, 100);
    
}
-(void)customButtonClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[customButton class]]) {
                customButton *cButton = [array objectAtIndex:i];
                __block customButton *cB = cButton;
                cButton.myblock = ^(customButton *button){
                    
                    if (cB.clickOfType == 0) {
                        NSLog(@"去拍照");
                        UIImagePickerController *lpicer1 = [[UIImagePickerController alloc]init];
                        lpicer1.sourceType = UIImagePickerControllerSourceTypeCamera;
                        [self presentViewController:lpicer1 animated:YES completion:nil];
                        lpicer1.delegate = self;
                        
                        //进入拍照时先创建一个图片视图 接受拍好的照片
                        UIImageView *addView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 70, 70)];
                        addView.userInteractionEnabled = YES;
                        
                        UITapGestureRecognizer *lTapgesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Tap:)];
                        lTapgesture.numberOfTouchesRequired = 1;
                        [addView addGestureRecognizer:lTapgesture];
                        
                        [addIVArray insertObject:addView atIndex:0];
                        //滚动时的第一个视图
                        selectView = [addIVArray objectAtIndex:0];
                    }
                    if (cB.clickOfType == 1) {
                        
                    }
                    NSLog(@"____________%@",[cB class]);
                };
                
            }
        }
        
    }
}


-(void)cScrollerViewClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CustomScrollerView class]]){
                CustomScrollerView *cSView = [array objectAtIndex:i];
                
                if (i==0) {
                    fScrollView = cSView;
                    fScrollView.delegate = self;
                    fScrollView.contentSize = CGSizeMake(addIVArray.count<3?320:addIVArray.count*100+110, 100);
                }
            }
        }
    }
    
}
//滚动视图将要开始拖动drag拖动
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (selectView != nil) {
        //        selectView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        [UIView animateWithDuration:0.5 animations:^{
            selectView.transform = CGAffineTransformMakeScale(1.0, 1.0);
            
        }];
        selectView =nil;
    }
}

//滚动视图将要开始减速
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
}

//滚动视图在拖动中
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (decelerate ==YES)
        return;
    int offset=(int)scrollView.contentOffset.x%100;
    int value=(int)scrollView.contentOffset.x/100;
    if (offset == 0) {
        //        selectView=[addIVArray objectAtIndex:value];
        //        [UIView animateWithDuration:1.0 animations:^{
        //            selectView.transform=CGAffineTransformMakeScale(1.25, 1.25);
        //
        //        }];
    }else if (offset<50){
        [scrollView setContentOffset:CGPointMake(100*value, scrollView.contentOffset.y) animated:YES];
    }else{
        [scrollView setContentOffset:CGPointMake(100*(value+1), scrollView.contentOffset.y) animated:YES];
    }
}

//UIScrollView惯性运动结束
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    //    NSLog(@"scrollView.x = %f",scrollView.contentOffset.x);
    //    NSLog(@"%lu",(unsigned long)addIVArray.count);
    
    int value=(int)scrollView.contentOffset.x/100;
    selectView=[addIVArray objectAtIndex:value];
    //    selectView.transform=CGAffineTransformMakeScale(1.25, 1.25);
    [UIView animateWithDuration:1.0 animations:^{
        selectView.transform=CGAffineTransformMakeScale(1.25, 1.25);
        
    }];
}

//滚动视图在减速中
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int offset=(int)scrollView.contentOffset.x%100;
    int value=(int)scrollView.contentOffset.x/100;
    if (offset==0) {
        //        selectView=[addIVArray objectAtIndex:value];
        //        [UIView animateWithDuration:1.0 animations:^{
        //            selectView.transform=CGAffineTransformMakeScale(1.25, 1.25);
        //
        //        }];
    }else if(offset<50){
        [scrollView setContentOffset:CGPointMake(100*value, scrollView.contentOffset.y) animated:YES];
    }else{
        [scrollView setContentOffset:CGPointMake(100*(value+1), scrollView.contentOffset.y) animated:YES];
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
