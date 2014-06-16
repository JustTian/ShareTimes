//
//  WFirstCustomCell.m
//  shiyan4
//
//  Created by 传晟 on 14-4-16.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "WFirstCustomCell.h"

@implementation WFirstCustomCell

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//    }
//    return self;
//}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    WFirstCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WFirstCustomCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _wTestLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.height, 0, self.frame.size.width-self.frame.size.height, self.frame.size.height)];
        _wTestLabel.numberOfLines = 0;
        _wTestLabel.font = [UIFont boldSystemFontOfSize:15];
//        _wTestLabel.backgroundColor = [UIColor grayColor];
        
        _wImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.origin.x+5, self.frame.origin.y+5, self.frame.size.height-10, self.frame.size.height-10)];
        _wImageView.contentMode = UIViewContentModeCenter;
        [self addSubview:_wTestLabel];
        [self addSubview:_wImageView];
        //设置包含视图的基本属性
//        self.textLabel.font = [UIFont boldSystemFontOfSize:14];
//        self.contentView.backgroundColor = [UIColor grayColor];
        self.wTestLabel.textColor = [UIColor redColor];
        self.textLabel.textColor  = [UIColor blueColor];
        self.detailTextLabel.textColor = [UIColor brownColor];
    }
    return self;
}

-(void)layoutSubviews{
    CGFloat height = [self heightContentBackgroundView:self.wTestLabel.text];
    //image跟随放大缩小时这样设置
//    self.wTestLabel.frame = CGRectMake(self.frame.size.height, 0, self.frame.size.width-self.frame.size.height, height);
    //
    self.wTestLabel.frame = CGRectMake(self.wImageView.frame.size.width+10, 0, self.frame.size.width-self.frame.size.height, height);
    self.wImageView.center = CGPointMake(self.wImageView.center.x, self.wTestLabel.center.y);
    
    if (!self.wImageView.image) {
        
//        self.wImageView.frame = CGRectMake(5, 5, self.frame.size.height-10, self.frame.size.height-10);
        self.wImageView.backgroundColor = [UIColor clearColor];
    }
}
- (CGFloat)heightContentBackgroundView:(NSString *)content
{
    CGFloat height = [self heigtOfLabelForFromString:content fontSizeandLabelWidth:320-self.frame.size.height andFontSize:15.0];
    if (height<44)
    {
        height = 44;
    }
//    height += 10;
    
    return height;
}

- (CGFloat)heigtOfLabelForFromString:(NSString *)text fontSizeandLabelWidth:(CGFloat)width andFontSize:(CGFloat)fontSize
{
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, 20000)];
    return size.height;
}


-(void)setMember:(FirstCellMember *)member{
    
    _member = member;
    self.wTestLabel.text = member.labelText;
    if (member.image) {
        self.wImageView.image = member.image;
    }
}

//-(void)setBaseMember:(BaseCellMember *)baseMember{
//
//    _baseMember = baseMember;
//    self.textLabel.text = baseMember.mainString;
//    self.detailTextLabel.text = baseMember.detailString;
//    if (baseMember.isShowImage) {
//        self.imageView.image = baseMember.imageName;
//    }
//}

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
