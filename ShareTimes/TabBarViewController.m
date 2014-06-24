//
//  TabBarViewController.m
//  ShareTimes
//
//  Created by 传晟 on 14-6-5.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "TabBarViewController.h"
#import "MainViewController.h"
#import "FunctionViewController.h"
#import "UsersViewController.h"

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "FourthViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

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
    [CommonDataClass sharCommonData].dataDic = [[NSDictionary alloc]init];
    
//    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view.
    MainViewController *mainVC = [[MainViewController alloc]init];
    UITabBarItem *imageViewItem1 = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"home_24x24"] tag:10];
    [mainVC setTabBarItem:imageViewItem1];
    UINavigationController *mainNVC = [[UINavigationController alloc]initWithRootViewController:mainVC];
    
    FunctionViewController *funVc = [[FunctionViewController alloc]init];
    UITabBarItem *imageViewItem2 = [[UITabBarItem alloc]initWithTitle:@"功能" image:[UIImage imageNamed:@"heart_stroke_24x21"] tag:10];
    [funVc setTabBarItem:imageViewItem2];
    UINavigationController *funNVC = [[UINavigationController alloc]initWithRootViewController:funVc];
    
    UsersViewController *userVC = [[UsersViewController alloc]init];
    UITabBarItem *imageViewItem3 = [[UITabBarItem alloc]initWithTitle:@"用户" image:[UIImage imageNamed:@"user_18x24"] tag:10];
    [userVC setTabBarItem:imageViewItem3];
    UINavigationController *userNVC = [[UINavigationController alloc]initWithRootViewController:userVC];
    
//    FourthViewController *fuserVC = [[FourthViewController alloc]init];
//    UITabBarItem *imageViewItem4 = [[UITabBarItem alloc]initWithTitle:@"测试题" image:[UIImage imageNamed:@"isRead_selectedButton@2x"] tag:10];
//    [fuserVC setTabBarItem:imageViewItem4];
//    UINavigationController *fuserNVC = [[UINavigationController alloc]initWithRootViewController:fuserVC];

    NSArray *items = @[mainNVC,funNVC,userNVC];
    
    //这里设置代理控制是否有用户登录
    self.delegate = self;
    [self setViewControllers:items animated:YES];
    
}

#pragma mark UITabBarControllers Delegate

-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    NSLog(@"%lu",(unsigned long)tabBarController.selectedIndex);
    if ([viewController.title isEqualToString:@"个人中心"]) {
        if ([CommonDataClass sharCommonData].userID == nil) {
            NSLog(@"没有用户登录");
//            RegisterViewController *regstrer = [[RegisterViewController alloc]init];
//            [self presentViewController:regstrer animated:YES completion:nil];
            LoginViewController *loginVC = [[LoginViewController alloc]init];
            [self presentViewController:loginVC animated:NO completion:nil];
        }
        return NO;
    }else{
        return YES;
    }
//    if (tabBarController.selectedIndex != 2) {
//        if ([CommonDataClass sharCommonData].userID == nil) {
//            NSLog(@"没有用户登录");
////            RegisterViewController *regstrer = [[RegisterViewController alloc]init];
////            [self presentViewController:regstrer animated:YES completion:nil];
//            LoginViewController *loginVC = [[LoginViewController alloc]init];
//            [self presentViewController:loginVC animated:YES completion:nil];
//        }
//        return NO;
//    }else{
//    
//        return YES;
//    }
}

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"tabBarController.subViewContrller num  %lu",(unsigned long)tabBarController.selectedIndex);
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
