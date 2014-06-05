//
//  LeftTitleView.m
//  FirstProject
//
//  Created by 传晟 on 14-5-30.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "LeftTitleView.h"
#import "LabelForLeftView.h"
#import "ViewCellForLeftView.h"

#define kHeightMargin 3
#define kCount 20


@interface LeftTitleView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray *TimesForLabel;

@end

@implementation LeftTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        self.TimesForLabel = [NSMutableArray array];
//        for (int i=0; i<= 20; i++) {//i控制输入的个数，在此作变量修改（后期）
//            int cTime = i*30+510;
//            NSString *timelabel = [NSString stringWithFormat:@"%d:%02d",cTime/60,cTime%60];
//            [self.TimesForLabel addObject:timelabel];
//        }
        
        self.leftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        self.leftTableView.delegate = self;
        self.leftTableView.dataSource = self;
//        self.leftTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.leftTableView.userInteractionEnabled = NO;//让这个表视图本身是不能被拖动的
        [self addSubview:self.leftTableView];
        
    }
    return self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _ShowLeftTitleArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *CellID = @"mycell";
    ViewCellForLeftView *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    if (cell == nil) {
        cell = [[ViewCellForLeftView alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
        
    }
//    cell.titleLabel.text = self.TimesForLabel[indexPath.row];
    cell.titleLabel.text = self.ShowLeftTitleArray[indexPath.row];
    return cell;
}

-(void)setShowLeftTitleArray:(NSArray *)ShowLeftTitleArray{
    
    _ShowLeftTitleArray = ShowLeftTitleArray;
    
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
