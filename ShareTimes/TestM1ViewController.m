//
//  TestM1ViewController.m
//  ShareTimes
//
//  Created by 传晟 on 14-6-16.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "TestM1ViewController.h"
#import "HeaderForCustoms.h"

@interface TestM1ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIScrollViewDelegate>
{
    BOOL isScreen;//判断点击后是否加载满屏
    CGRect imageVRect;//记录图片视图变化前的大小
    NSMutableArray *addIVArray;
    UIScrollView *fScrollView;//装载图片视图的滚动视图
    CImageVIew *selectView;
}

@end

@implementation TestM1ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setHidesBottomBarWhenPushed:YES]; //设置tabBarController为隐藏
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //添加上一页以及下一页按钮;
    UIView *dView = [[UIView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-30, self.view.frame.size.width, 30)];
    dView.backgroundColor = [UIColor grayColor];
    UIButton *fButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, 30)];
    [fButton setTitle:@"shang" forState:UIControlStateNormal];
    [dView addSubview:fButton];
    
    UIButton *sButton = [[UIButton alloc]initWithFrame:CGRectMake(270, 0, 40, 30)];
    [sButton setTitle:@"xia" forState:UIControlStateNormal];
    [dView addSubview:sButton];
    [self.view addSubview:dView];
    
    
    addIVArray = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view.
    wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
    NSString *nameJstring = @"textM1ViewController.json";
    NSDictionary *lDictionary = [self dictionaryFromJSONName:nameJstring];
    //利用载入类描绘出视图界面
    [dynamicLayout drawingInterfaceFromJSONName:nameJstring AndBaseView:self.view];
    
    NSDictionary *ldic = [dynamicLayout getItemsOfGroup:lDictionary];//直接调用解析的json文件的第一个字典----返回所有控件的tag值与类型的字典
    NSLog(@"***************%@",ldic);
    NSArray *widgetArray = [dynamicLayout instanceCustomButtonFromDic:ldic AndSupperView:self.view];//返回实例化自定义按钮的对象数组
    [self customButtonClick:widgetArray];//执行响应的响应事件
    
    //给图片视图添加点击事件
    NSArray *imageVArray = [dynamicLayout instanceCImageViewFromDic:ldic AndSupperView:self.view];
    [self imageViewAddClick:imageVArray];
    
    NSArray *scrollViewArray = [dynamicLayout instanceCustomScrollViewFromDic:ldic AndSupperView:self.view];
    
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
    selectView = [addIVArray objectAtIndex:0];
    
    [self cScrollerViewClick:scrollViewArray];
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
