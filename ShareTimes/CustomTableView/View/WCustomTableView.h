//
//  WCustomTableView.h
//  shiyan4
//
//  Created by 传晟 on 14-4-16.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TableOfMapper;
@class WCustomTableView;
//选择cell的block定义
typedef void (^MyTableViewCellSelectionBlock) (NSIndexPath *selectedIndex);
//取消选择cell的block定义
typedef void (^MyTableViewCellUnSelectBlock) (NSIndexPath *UnSelectedIndex);


@interface WCustomTableView : UITableView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,retain) NSMutableArray *dataArray;//tableViewCell的数据数组
@property (nonatomic,retain) NSMutableArray *sectionTitleArray;
@property (nonatomic,retain) NSMutableArray *footGroupArray;
@property (nonatomic,assign) BOOL isCustomCell;

@property (nonatomic,retain) UIView *tHeaderView;
@property (nonatomic,retain) UIView *tFooterView;

@property (nonatomic,assign) BOOL isHeadView;
@property (nonatomic,assign) BOOL isFootView;

//定制响应block
@property(nonatomic,copy) MyTableViewCellSelectionBlock myTCellSelectedBlock;
@property(nonatomic,copy) MyTableViewCellUnSelectBlock myTCellUnSelectedBlock;

+ (WCustomTableView *)loadTableViewWithModer:(NSDictionary *)dictionary;
//-(instancetype)initWithMapper:(TableOfMapper *)tableOfMapper;
@end
