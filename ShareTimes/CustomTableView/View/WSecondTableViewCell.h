//
//  WSecondTableViewCell.h
//  ShareTimes
//
//  Created by WZHEN on 14-6-23.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSecondTableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic,retain)UIImageView *wImageView;
@property (nonatomic,retain)UITextView *wTextView;
@end
