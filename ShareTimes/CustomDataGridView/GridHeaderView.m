//
//  GridHeaderView.m
//  FirstProject
//
//  Created by 传晟 on 14-5-28.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "GridHeaderView.h"

@interface GridHeaderView()
//用于做头标题视图的两个子视图加载
@property (nonatomic,strong) UILabel *numRoom;
@property (nonatomic,strong) UILabel *detailRoom;
//用于做数据展示时应该加载的子视图
@property(nonatomic,strong) UILabel *dataLabel;

@end

@implementation GridHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.subLayoutMethod = loadHeaderForGridView;
        
        
        if (self.subLayoutMethod ==0) {
            self.numRoom=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.5)];
            self.numRoom.textAlignment=NSTextAlignmentCenter;
            self.numRoom.font=[UIFont systemFontOfSize:12];
            [self addSubview:self.numRoom];
            
            self.detailRoom=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.5)];
            self.detailRoom.textAlignment=NSTextAlignmentCenter;
            self.detailRoom.font=[UIFont systemFontOfSize:12];
            [self addSubview:self.detailRoom];
            
        }
        if (self.subLayoutMethod == 1) {
            self.dataLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            self.dataLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.dataLabel];
            
        }

        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)]];
    }
    return self;
}
//daixiugai
-(id)init{
    self = [super init];
    if (self) {
        self.subLayoutMethod = 0;
        
        if (self.subLayoutMethod ==0) {
            self.numRoom=[[UILabel alloc]initWithFrame:CGRectZero];
            self.numRoom.textAlignment=NSTextAlignmentCenter;
            self.numRoom.font=[UIFont systemFontOfSize:12];
            [self addSubview:self.numRoom];
            
            self.detailRoom=[[UILabel alloc]initWithFrame:CGRectZero];
            self.detailRoom.textAlignment=NSTextAlignmentCenter;
            self.detailRoom.font=[UIFont systemFontOfSize:12];
            [self addSubview:self.detailRoom];
            
        }
        if (self.subLayoutMethod == 1) {
            self.dataLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            self.dataLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.dataLabel];
            
        }

        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView:)]];

    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
//    NSLog(@"%f",self.frame.size.height);
    if (self.subLayoutMethod ==0) {
      
        self.numRoom.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.5);
        self.numRoom.center=CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.25);
        
        self.detailRoom.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height*0.5);
        self.detailRoom.center=CGPointMake(self.frame.size.width*0.5, self.frame.size.height-self.frame.size.height*0.25);

    }
    if (self.subLayoutMethod == 1) {
//        if (self.subviews) {
//            for (int i = 0; i<self.subviews.count; i++) {
//                UILabel *lable = [self.subviews objectAtIndex:i];
//                [lable removeFromSuperview];
//            }
//        }
        self.dataLabel.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        self.dataLabel.center = CGPointMake(self.frame.size.width*0.5, self.frame.size.height*0.5);
    }
    
}

//-(void)setFrame:(CGRect)frame{
//    self.frame = frame;
//    self.detailRoom = [[UILabel alloc]initWithFrame:frame];
//    self.detailRoom.font=[UIFont systemFontOfSize:12];
//    self.detailRoom.center=CGPointMake(self.frame.size.width*0.5, self.frame.size.height-self.frame.size.height);
//    [self addSubview:self.detailRoom];
//}

-(void)tapView:(UITapGestureRecognizer *)tap
{
    CGPoint point=[tap locationInView:self];
    
    if([self.delegate respondsToSelector:@selector(headView:point:)]){
        
        [self.delegate headView:self point:point];
    }
    
}
-(void)setNum:(NSString *)num
{
    _num=num;
    self.numRoom.text=num;
}
-(void)setDetail:(NSString *)detail
{
    _detail=detail;
    self.detailRoom.text=detail;
    
}
-(void)setDataString:(NSString *)dataString{

    _dataString = dataString;
    self.dataLabel.text = dataString;
}
-(void)setSubLayoutMethod:(layoutMethods)subLayoutMethod{
    _subLayoutMethod = subLayoutMethod;
    switch (subLayoutMethod) {
        case 1:{
            if (self.subviews) {
                for (int i = 0; i<self.subviews.count; i++) {
                    UILabel *lable = [self.subviews objectAtIndex:i];
                    [lable removeFromSuperview];
                }
            }
            self.dataLabel = [[UILabel alloc]initWithFrame:CGRectZero];
            self.dataLabel.textAlignment = NSTextAlignmentCenter;
            [self addSubview:self.dataLabel];
            break;
        }
        default:
            break;
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
