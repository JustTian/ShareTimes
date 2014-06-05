//
//  WFirstCustomCell.h
//  shiyan4
//
//  Created by 传晟 on 14-4-16.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstCellMember.h"
#import "BaseCellMember.h"

@interface WFirstCustomCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,retain)UIImageView *wImageView;
@property (nonatomic,retain)UILabel *wTestLabel;
@property (nonatomic,retain)FirstCellMember *member;
@property (nonatomic,retain)BaseCellMember  *baseMember;
@end
