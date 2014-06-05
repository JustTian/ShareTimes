//
//  MyTableViewCell.m
//  FirstProject
//
//  Created by 传晟 on 14-5-29.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "MyTableViewCell.h"
#import "GridHeaderView.h"
#import "ModleForHeader.h"


@interface MyTableViewCell ()<GridHeaderViewDelegate>

@end


@implementation MyTableViewCell
#define kWidth 100
#define kHeight 40
#define kWidthMargin 1
#define kHeightMargin 3

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andCellNum:(NSInteger)integer
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        for(int i=0;i<integer;i++){
            
            GridHeaderView *headView=[[GridHeaderView alloc]initWithFrame:CGRectMake(i*kWidth, 0, kWidth-kWidthMargin, kHeight+kHeightMargin)];
            headView.subLayoutMethod = 1;//用于加载数据显示的子视图设置
            headView.delegate=self;
            headView.dataString = @"23";
            headView.backgroundColor=[UIColor whiteColor];
            [self.contentView addSubview:headView];
        }
    }
    return self;
}
-(void)headView:(GridHeaderView *)headView point:(CGPoint)point
{
    if([self.delegate respondsToSelector:@selector(myHeadView:point:)]){
        
        [self.delegate myHeadView:headView point:point];
    }
    
}
-(void)setCurrentTime:(NSMutableArray *)currentTime
{
    _currentTime=currentTime;
    long int count=currentTime.count;
    if(count>0){
        for(int i=0;i<count;i++){
            
            ModleForHeader *model=currentTime[i];
            
            GridHeaderView *headView;
            if([model.meetRoom isEqualToString:@"000"]){
                
                headView=(GridHeaderView *)self.contentView.subviews[0];
            }else{
                
                NSArray *room=[model.meetRoom componentsSeparatedByString:@"0"];
                headView=(GridHeaderView *)self.contentView.subviews[[[room lastObject] intValue]];
            }
            headView.backgroundColor=[UIColor greenColor];
            
            for(GridHeaderView *leftHeadView in self.contentView.subviews){
                
                if(headView!=leftHeadView) leftHeadView.backgroundColor=[UIColor whiteColor];
            }
        }
    }else{
        
        for(GridHeaderView *headView in self.contentView.subviews){
            
            headView.backgroundColor=[UIColor whiteColor];
        }
    }
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
