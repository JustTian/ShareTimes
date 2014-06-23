//
//  FunctionViewController.m
//  ShareTimes
//
//  Created by 传晟 on 14-6-5.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "FunctionViewController.h"
#import "HeaderForCustoms.h"
#import "BaseCellMember.h"
#import "HeaderAndFooterRefresh.h"

#import "FourthViewController.h"
#import "TestM1ViewController.h"

@interface FunctionViewController ()

@end
#define keyForRowData @"rowItems"
#define keyForSectionName @"sectionName"
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
    ldata = [[NSMutableData alloc]init];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor grayColor];
    
    //从本地json文件加载
//    wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
//    
//    NSString *nameString = @"functionViewController.json";
//    NSDictionary *lDictionary = [self dictionaryFromJSONName:nameString];
//    [dynamicLayout drawingInterfaceFromJSONName:nameString AndBaseView:self.view];
//    
//    NSDictionary *lDic = [dynamicLayout getItemsOfGroup:lDictionary];
//    NSLog(@"控件：%@",lDic);
//    NSArray *cArray = [dynamicLayout instanceCustomButtonFromDic:lDic AndSupperView:self.view];//返回实例化自定义按钮的对象数组
//    [self customButtonClick:cArray];//执行响应的响应事件
//    
//    NSArray *tabelViewArray = [dynamicLayout instanceCustomTabelViewFromDic:lDic AndSupperView:self.view];
//    [self customTableViewClick:tabelViewArray];
    //从网络获取加载
    NSString *lstr = @"op=getallprojects&data={\"UserID\":\"21\"}";
    NSString *string = [NSString stringWithFormat:@"http://%@/es/server/esservice.ashx",ServerIP];
    NSURL *lurl = [NSURL URLWithString:string];
    NSMutableURLRequest *lmutableURLRequest = [NSMutableURLRequest requestWithURL:lurl];
    [lmutableURLRequest setHTTPMethod:@"post"];
    [lmutableURLRequest setHTTPBody:[lstr dataUsingEncoding:NSUTF8StringEncoding]];
    NSURLConnection *lURLConnection = [NSURLConnection connectionWithRequest:lmutableURLRequest delegate:self];
    [lURLConnection start];


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
        
        NSArray *tabelViewArray = [dynamicLayout instanceCustomTabelViewFromDic:lDic AndSupperView:self.view];
        [self customTableViewClick:tabelViewArray];
    }else{
        UIAlertView *alerVIEW = [[UIAlertView alloc]initWithTitle:@"提示" message:@"获取数据失败" delegate:self cancelButtonTitle:@"cancle" otherButtonTitles: nil];
        [alerVIEW show];
    }
    
}


#pragma mark 自定义按钮控件的响应时间描述
-(void)customButtonClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[customButton class]]) {
                customButton *cButton = [array objectAtIndex:i];
                __block customButton *cB = cButton;
                cButton.myblock = ^(customButton *button){
                    //        [cB performSelector:@selector(buttonClick:)];
                    if (cB.clickOfType == 1) {
                        [self dismissViewControllerAnimated:YES completion:nil];
                    }
                    if (cB.clickOfType == 2)  {
                        NSLog(@"第二种响应类型");
                    }
                    if (cB.clickOfType == 3) {
                        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"warning" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
                        [alertView show];
                        NSLog(@"%ld",(long)alertView.cancelButtonIndex);
                        NSLog(@"%ld",(long)alertView.firstOtherButtonIndex);
                    }
                    if (cB.clickOfType == 4)  {
//                        UIImage *image1 = [UIImage imageNamed:BackName1];
//                        UIImage *image2 = [UIImage imageNamed:BackName2];
//                        if ([[cB backgroundImageForState:UIControlStateNormal]isEqual:image2]) {
//                            [cB setBackgroundImage:image1 forState:UIControlStateNormal];
//                        }else{
//                            [cB setBackgroundImage:image2 forState:UIControlStateNormal];
//                        }
                    }
                    NSLog(@"____________________");
                };
                
            }
        }
        
    }
}
-(void)customTableViewClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[WCustomTableView class]]){
                WCustomTableView *cTableView = [array objectAtIndex:i];
                [self addHeaderWithTableView:cTableView];
                cTableView.myTCellSelectedBlock = ^(NSIndexPath *indexPath){
                    if (indexPath.row == 0) {
                        FourthViewController *fourVC = [[FourthViewController alloc]init];
                        [self.navigationController pushViewController:fourVC animated:YES];
                    }else if (indexPath.row == 1){
                        TestM1ViewController *textMVC = [[TestM1ViewController alloc]init];
                        [self.navigationController pushViewController:textMVC animated:YES];
                    }else{
                        TestM1ViewController *textMVC = [[TestM1ViewController alloc]init];
                        [self.navigationController pushViewController:textMVC animated:YES];
                        
                    }
                    
                    NSLog(@"cell Be Selcected at %ld",(long)indexPath.row);
                };
            }
        }
    }
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.tabBarController setHidesBottomBarWhenPushed:NO];
}

#pragma mark 表视图的头部刷新控件关联
//在此进行重载数据
- (void)addHeaderWithTableView:(WCustomTableView *)cTableView
{
    RefreshHeaderView *headerView = [RefreshHeaderView header];
    headerView.scrollView  = cTableView;
    __block WCustomTableView *tableViewC = cTableView;
    headerView.beginBolock = ^(WZRefreshBaseView *refreshView){
        NSMutableDictionary *dictionar =[[NSMutableDictionary alloc]init];
        NSMutableArray *itemArray = [[NSMutableArray alloc]init];
        for (int i = 0; i<2; i++) {
            BaseCellMember *member = [[BaseCellMember alloc]init];
            if (i%2==0) {
                member.mainString = @"hello ?";
                member.detailString = @"cs";
                member.isShowImage = YES;
                member.imageName = [UIImage imageNamed:@"5"];
            }else{
                
                member.mainString =@"hello!";
                member.detailString = @"me";
                member.isShowImage = NO;
                member.imageName = nil;
            }
            [itemArray addObject:member];
        }
        [dictionar setObject:itemArray forKey:keyForRowData];
//        [dictionar setObject:@"section" forKey:keyForSectionName];
        NSString *setTitle = [NSString stringWithFormat:@"+Section:%d",1];
        [tableViewC.sectionTitleArray addObject:setTitle];
        [tableViewC.dataArray addObject:dictionar];
        [self performSelector:@selector(doneWithView:) withObject:refreshView afterDelay:2];
        
    };
    headerView.endBlock = ^(WZRefreshBaseView *refreshView){
        NSLog(@"refresh is end!");
    };
    headerView.changeBlock = ^(WZRefreshBaseView *refreshView,WZRefreshState state ){
        switch (state) {
            case WZRefreshStateDidRefreshing:
                NSLog(@"refreshing");
                break;
            case WZRefreshStateNormal:
                NSLog(@"normal");
                break;
            case WZRefreshStatePulling:
                NSLog(@"pulling");
                break;
            case WZRefreshStateWillRefreshing:
                NSLog(@"willRefreshing");
                break;
            default:
                break;
        }
    };
    //是否一进界面就开始刷新
//    [headerView beginRefreshing];
    
}

-(void)doneWithView:(WZRefreshBaseView *)refreshView{
    WCustomTableView *tableVC = (WCustomTableView *)[self.view viewWithTag:11001];
    [tableVC reloadData];
    [refreshView endRefreshing];
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
