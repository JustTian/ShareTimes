//
//  ViewCellForLeftView.m
//  FirstProject
//
//  Created by 传晟 on 14-5-30.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "ViewCellForLeftView.h"
#import "LabelForLeftView.h"

@implementation ViewCellForLeftView

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.titleLabel = [[LabelForLeftView alloc]initWithFrame:CGRectMake(15, 0, self.frame.size.width-15, self.frame.size.height)];
        [self.titleLabel setVerticalAlignment:VerticalAlignmentMiddle];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
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
