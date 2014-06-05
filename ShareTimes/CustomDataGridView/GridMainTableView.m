//
//  GridMainTableView.m
//  FirstProject
//
//  Created by 传晟 on 14-6-2.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "GridMainTableView.h"
//导入主要的三个子视图控件
#import "GridHeaderView.h"
#import "LeftTitleView.h"
#import "MyTableViewCell.h"

#import "LabelForLeftView.h"

//导入模型类
#import "ModleForHeader.h"
#import "ModleForLeftTitleVIew.h"

#define kWidth 100
#define kHeight 50
//#define kWidthMargin 1
#define kHeightMargin 3
#define kCount 15
@interface GridMainTableView ()<UITableViewDelegate,UITableViewDataSource,MyTableViewCellDelegate>
@property(nonatomic,strong) UIView *myHeadView;
@property(nonatomic,strong) UITableView *myTableView;
@property(nonatomic,strong) LeftTitleView *leftView;

@end
@implementation GridMainTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initeDataWithView:self];
    }
    return self;
}

//-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
//    self = [super initWithFrame:frame style:style];
//    if (self) {
//        self.dataSource = self;
//        self.delegate = self;
//        [self initeDataWithView:self];
//    }
//    return self;
//}

-(void)initeDataWithView:(UIView *)view{
    self.meets=[NSMutableArray array];
    self.currentTime=[NSMutableArray array];
    for(int i=0;i<10;i++){
        
        ModleForHeader *meet=[[ModleForHeader alloc]init];
        meet.meetRoom=[NSString stringWithFormat:@"%03d",i];
        int cTime=i*30+520;
        NSString *time=[NSString stringWithFormat:@"%d:%02d",cTime/60,cTime%60];
        meet.meetTime=time;
        [self.meets addObject:meet];
    }
    view.backgroundColor = [UIColor whiteColor];
    UIView *tableViewHeadView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kCount*kWidth, kHeight)];
//    tableViewHeadView
    self.myHeadView=tableViewHeadView;
    for(int i=0;i<kCount;i++){
        
//        GridHeaderView *headView=[[GridHeaderView alloc]initWithFrame:CGRectMake(i*kWidth, 0, kWidth, kHeight)];
        GridHeaderView *headView=[[GridHeaderView alloc]init];
        headView.frame = CGRectMake(i*kWidth, 0, kWidth, kHeight);
        headView.num=[NSString stringWithFormat:@"第%03d行",i];
        headView.detail=@"查看数据展示";
        headView.backgroundColor=[UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        [tableViewHeadView addSubview:headView];
    }
    //给该视图添加滚动视图和左边标题栏
    UITableView *tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.myHeadView.frame.size.width, 44*9+kHeight) style:UITableViewStylePlain];
    tableView.delegate=self;
    tableView.dataSource=self;
    tableView.bounces=NO;
    tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    self.myTableView=tableView;
    tableView.backgroundColor=[UIColor whiteColor];
    
    UIScrollView *myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(70, 40, view.frame.size.width-kWidth*0.7, 44*9+kHeight)];
    [myScrollView addSubview:tableView];
    myScrollView.bounces=NO;
    myScrollView.contentSize=CGSizeMake(self.myHeadView.frame.size.width,0);
    [view addSubview:myScrollView];
    //kCount*(kHeight+kHeightMargin)   view.frame.size.height-40
    
    /*-------------------------*/
    self.leftView=[[LeftTitleView alloc]initWithFrame:CGRectMake(0, 40+kHeight, 70, 44*9+kHeight-kHeight)];
    //此处用于给左边标题加载数据
    NSMutableArray *mArray= [NSMutableArray array];
    for (int i=0; i<= 10; i++) {//i控制输入的个数，在此作变量修改（后期）
        int cTime = i*30+510;
        NSString *timelabel = [NSString stringWithFormat:@"%d:%02d",cTime/60,cTime%60];
        [mArray addObject:timelabel];
    }
    self.leftView.ShowLeftTitleArray = mArray;
    
    [view addSubview:self.leftView];
    
    
    LabelForLeftView *crossView = [[LabelForLeftView alloc]initWithFrame:CGRectMake(0, 40, 70, kHeight)];
    crossView.text = @"数据演示";
    crossView.backgroundColor = [UIColor grayColor];
    [view addSubview:crossView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;////////////////////////
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier=@"cell";
    
    MyTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell==nil){
        //自定义cell加载
        cell=[[MyTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier andCellNum:kCount];
        cell.delegate=self;
        cell.backgroundColor=[UIColor redColor];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
    }
    [self.currentTime removeAllObjects];
//    for(ModleForHeader *model in self.meets){
//        
//        NSArray *timeArray=[ model.meetTime componentsSeparatedByString:@":"];
//        NSLog(@"%@",timeArray);
//        int min=[timeArray[0] intValue]*60+[timeArray[1] intValue];
//        long int currentTime=indexPath.row*30+510;
//        if(min>currentTime&&min<currentTime+30){
//            [self.currentTime addObject:model];
//        }
//    }
    cell.index=indexPath.row;
    cell.currentTime=self.currentTime;
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return self.myHeadView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return kHeight;
}
-(void)myHeadView:(GridHeaderView *)headView point:(CGPoint)point
{
    CGPoint myPoint= [self.myTableView convertPoint:point fromView:headView];
    
    [self convertRoomFromPoint:myPoint];
}
-(void)convertRoomFromPoint:(CGPoint)ponit
{
    NSString *roomNum=[NSString stringWithFormat:@"%03d",(int)(ponit.x)/kWidth];
    int currentTime=(ponit.y-kHeight-kHeightMargin)*30.0/(kHeight+kHeightMargin)+510;
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"clicked room" message:[NSString stringWithFormat:@"time :%@ room :%@",[NSString stringWithFormat:@"%d:%02d",currentTime/60,currentTime%60],roomNum] delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
    [alert show];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY= self.myTableView.contentOffset.y;
    CGPoint timeOffsetY=self.leftView.leftTableView.contentOffset;
    timeOffsetY.y=offsetY;
    self.leftView.leftTableView.contentOffset=timeOffsetY;
    if(offsetY==0){
        self.leftView.leftTableView.contentOffset=CGPointZero;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
