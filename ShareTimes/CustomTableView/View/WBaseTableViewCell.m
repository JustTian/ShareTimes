//
//  WBaseTableViewCell.m
//  ShareTimes
//
//  Created by 传晟 on 14-6-13.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "WBaseTableViewCell.h"

@implementation WBaseTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
//        self.imageView.frame = CGRectMake(self.frame.origin.x+5, self.frame.origin.y+5, self.frame.size.height-10, self.frame.size.height-10);
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

-(void)setBaseMember:(BaseCellMember *)baseMember{
    
    _baseMember = baseMember;
    self.textLabel.text = baseMember.mainString;
    self.detailTextLabel.text = baseMember.detailString;
    if (baseMember.imageName) {
//        self.imageView.frame = CGRectMake(self.frame.origin.x+5, self.frame.origin.y+5, self.frame.size.height-10, self.frame.size.height-10);
        self.imageView.image = baseMember.imageName;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
