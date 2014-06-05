//
//  GridMainTableView.h
//  FirstProject
//
//  Created by 传晟 on 14-6-2.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridMainTableView : UIView
@property(nonatomic,assign)NSInteger horizontalLength;//对应宏定义的宽设置
@property(nonatomic,assign)NSInteger verticalLength;//对应宏定义的高设置
@property(nonatomic,strong) NSMutableArray *meets;
@property(nonatomic,strong) NSMutableArray *currentTime;

//对应头标题的显示数据  接受数据的数组
@property(nonatomic,retain)NSMutableArray *headerDataArray;
//对应左标题的展示数据  接受数据的数组
@property(nonatomic,retain)NSMutableArray *leftDataArray;
//对应主要的数据显示    接受数据的数组
@property(nonatomic,retain)NSMutableArray *mainDataArray;
//@property(nonatomic,retain)nsm
@end
