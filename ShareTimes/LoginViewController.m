//
//  LoginViewController.m
//  ShareTimes
//
//  Created by 传晟 on 14-6-8.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "UsersViewController.h"

#import "TopNavBar.h"
#import "CustomTextField.h"
#import "customButton.h"

@interface LoginViewController ()<TopNavBarDelegate>

@end

@implementation LoginViewController

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
    wDynamicLayout *dynamicLayout = [[wDynamicLayout alloc]init];
    NSString *nameJstring = @"LoginViewController.json";
    NSDictionary *lDictionary = [self dictionaryFromJSONName:nameJstring];
    //利用载入类描绘出视图界面
    [dynamicLayout drawingInterfaceFromJSONName:nameJstring AndBaseView:self.view];
    
    NSDictionary *ldic = [dynamicLayout getItemsOfGroup:lDictionary];//直接调用解析的json文件的第一个字典----返回所有控件的tag值与类型的字典
    NSLog(@"***************%@",ldic);
    NSArray *widgetArray = [dynamicLayout instanceCustomButtonFromDic:ldic AndSupperView:self.view];//返回实例化自定义按钮的对象数组
    [self customButtonClick:widgetArray];//执行响应的响应事件
    
    NSArray *textFieldArray = [dynamicLayout instanceTextFieldFromDic:ldic AndSupperView:self.view];
//    [[textFieldArray objectAtIndex:0] becomeFirstResponder];
    [self customTextFieldClick:textFieldArray];
    
    [self createCustomNavBar];
}

-(void)customButtonClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[customButton class]]) {
                customButton *cButton = [array objectAtIndex:i];
                __block customButton *cB = cButton;
                cButton.myblock = ^(customButton *button){
                    
                    if (cB.clickOfType == 0) {
                        RegisterViewController *regstrer = [[RegisterViewController alloc]init];
                        [self presentViewController:regstrer animated:YES completion:nil];
                    }
                    if (cB.clickOfType == 1) {
                        UsersViewController *userVC = [[UsersViewController alloc]init];
                        [self presentViewController:userVC animated:YES completion:nil];
                    }
                    NSLog(@"____________%@",[cB class]);
                };
                
            }
        }
        
    }
}



-(void)customTextFieldClick:(NSArray *)array{
    if (array.count) {
        for (int i =0; i<array.count; i++) {
            if ([[array objectAtIndex:i]isKindOfClass:[CustomTextField class]]){
                CustomTextField *cTextField = [array objectAtIndex:i];
                [cTextField addTarget:self action:@selector(textFieldClick:) forControlEvents:UIControlEventEditingDidEndOnExit];
                if (cTextField.tag ==3001) {
                    [cTextField becomeFirstResponder];
                }
            }
        }
    }
}
-(void)textFieldClick:(CustomTextField *)sender{
    [sender resignFirstResponder];
    NSLog(@"resign");
}


- (void)createCustomNavBar
{
    TopNavBar *topNavBar = [[TopNavBar alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, (FSystenVersion >= 7.0)?64.f:44.f)
                                      bgImageName:(FSystenVersion >= 7.0)?@"backgroundNavbar_ios7@2x":@"backgroundNavbar_ios6@2x"
                                       labelTitle:@"登  录"
                                         labFrame:CGRectMake(90.f,(FSystenVersion >= 7.0)?27.f:7.f , 140.f, 30.f)
                                         leftBool:YES
                                     leftBtnFrame:CGRectMake(12.f, (FSystenVersion >= 7.0)?27.f:7.f, 30.f, 30.f)
                                 leftBtnImageName:@"button_back_bg@2x.png"
                                        rightBool:NO
                                    rightBtnFrame:CGRectZero
                                rightBtnImageName:nil];
    topNavBar.delegate = self;
    [self.view addSubview:topNavBar];
    
}

#pragma mark - TopNavBarDelegate Method
/**
 *	@brief	TopNavBarDelegate Method
 *
 *	@param 	index 	barItemButton 的索引值
 *
 *  当自定义导航条的点击按钮被点击时都是响应这个共有的代理方法，通过左右顺序的数字不同响应不同的事件
 */
- (void)itemButtonClicked:(int)index
{
    switch (index) {
        case 0:
        {
            //            [Utils alertTitle:@"提示" message:@"您点击了返回按钮" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
            break;
        case 1:
        {
            [Utils alertTitle:@"提示" message:@"右侧按钮被点击" delegate:nil cancelBtn:@"确定" otherBtnName:nil];
        }
            break;
            
        default:
            break;
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
