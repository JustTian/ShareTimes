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
@interface WCustomTableView : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain) NSMutableArray *dataArray;
@property (nonatomic,assign) BOOL isCustomCell;
+ (WCustomTableView *)loadTableViewWithModer:(NSDictionary *)dictionary;
//-(instancetype)initWithMapper:(TableOfMapper *)tableOfMapper;
@end
