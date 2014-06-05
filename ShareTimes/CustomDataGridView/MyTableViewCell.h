//
//  MyTableViewCell.h
//  FirstProject
//
//  Created by 传晟 on 14-5-29.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MyTableViewCell,GridHeaderView,ModleForHeader;
@protocol MyTableViewCellDelegate <NSObject>

-(void)myHeadView:(GridHeaderView *)headView point:(CGPoint )point;

@end


@interface MyTableViewCell : UITableViewCell


@property(nonatomic,assign) id <MyTableViewCellDelegate> delegate;
@property(nonatomic,strong) NSMutableArray *currentTime;
@property(nonatomic,assign) NSInteger index;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andCellNum:(NSInteger)integer;
@end
