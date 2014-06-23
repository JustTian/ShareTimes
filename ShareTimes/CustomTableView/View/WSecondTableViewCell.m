//
//  WSecondTableViewCell.m
//  ShareTimes
//
//  Created by WZHEN on 14-6-23.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "WSecondTableViewCell.h"

@implementation WSecondTableViewCell{
    UITextView *selectTV;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    WSecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[WSecondTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        if (self) {
            _wTextView = [[UITextView alloc]initWithFrame:CGRectMake(self.frame.size.height, 0, self.frame.size.width-self.frame.size.height, self.frame.size.height)];
            _wTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
            _wTextView.autocorrectionType = UITextAutocorrectionTypeYes;
            _wTextView.keyboardType = UIKeyboardTypeDefault;
            _wTextView.returnKeyType = UIReturnKeyDone;
            
            //在弹出的键盘上面加一个view来放置退出键盘的Done按钮
            [self setCustomKeyBoard:_wTextView];
            selectTV = _wTextView;
            
            _wTextView.font = [UIFont boldSystemFontOfSize:15];
            //        _wTestLabel.backgroundColor = [UIColor grayColor];
            
            _wImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.origin.x+5, self.frame.origin.y+5, self.frame.size.height-10, self.frame.size.height-10)];
            _wImageView.contentMode = UIViewContentModeScaleAspectFit;
            [self addSubview:_wImageView];
            //设置包含视图的基本属性
            //        self.textLabel.font = [UIFont boldSystemFontOfSize:14];
            //        self.contentView.backgroundColor = [UIColor grayColor];
            _wTextView.textColor = [UIColor blueColor];
            _wTextView.textAlignment = NSTextAlignmentCenter;
        }

    }
    return self;
}
-(void) setCustomKeyBoard:(UITextView *)textView{
    UIToolbar * topView = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleDefault];
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard:)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace, doneButton, nil];
    [topView setItems:buttonsArray];
    [textView setInputAccessoryView:topView];
}

-(void) dismissKeyBoard:(UITextView *)textView{
//    if ([self isKindOfClass:[UITextView class]]) {
//        [self resignFirstResponder];
//    }else{
//        NSLog(@"meiyou xiangying");
//    }
    [selectTV resignFirstResponder];
}


-(void)layoutSubviews{
    CGFloat height = [self heightContentBackgroundView:self.wTextView.text];
    //image跟随放大缩小时这样设置
    //    self.wTestLabel.frame = CGRectMake(self.frame.size.height, 0, self.frame.size.width-self.frame.size.height, height);
    //
    self.wTextView.frame = CGRectMake(self.wImageView.frame.size.width+10, 0, self.frame.size.width-self.frame.size.height, height);
    self.wImageView.center = CGPointMake(self.wImageView.center.x, self.wTextView.center.y);
    
    if (!self.wImageView.image) {
        
        //        self.wImageView.frame = CGRectMake(5, 5, self.frame.size.height-10, self.frame.size.height-10);
        self.wImageView.backgroundColor = [UIColor clearColor];
    }
}
- (CGFloat)heightContentBackgroundView:(NSString *)content
{
    CGFloat height = [self heigtOfLabelForFromString:content fontSizeandLabelWidth:320-self.frame.size.height andFontSize:15.0];
    if (height<60)
    {
        height = 60;
    }
    //    height += 10;
    
    return height;
}

- (CGFloat)heigtOfLabelForFromString:(NSString *)text fontSizeandLabelWidth:(CGFloat)width andFontSize:(CGFloat)fontSize
{
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:fontSize] constrainedToSize:CGSizeMake(width, 20000)];
    return size.height;
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
