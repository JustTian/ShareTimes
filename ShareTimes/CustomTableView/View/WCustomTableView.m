//
//  WCustomTableView.m
//  shiyan4
//
//  Created by 传晟 on 14-4-16.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "WCustomTableView.h"
#import "WFirstCustomCell.h"
#import "FirstCellMember.h"
#import "BaseCellMember.h"
#import "TableOfMapper.h"

//注意此处的关键字用于取出每个分组的数据
#define keyForRowData @"rowItems"
#define keyForSectionName @"sectionName"

@interface WCustomTableView (){
    WFirstCustomCell *customCell;

}

@end

@implementation WCustomTableView
//表视图的实例化方法
+ (WCustomTableView *)loadTableViewWithModer:(NSDictionary *)dictionary{
    
    TableOfMapper *tableOfMapper = [[TableOfMapper alloc]initWithDictionary:dictionary];
    WCustomTableView *wcTabelView = [[WCustomTableView alloc]initWithFrame:CGRectZero style:tableOfMapper.tableViewStyle];
    CGRect wRect = [wcTabelView rectFromModelJSON:tableOfMapper];
    wcTabelView.frame = wRect;
    wcTabelView.isCustomCell = [tableOfMapper.isCustomCell boolValue];
    wcTabelView.tag = [tableOfMapper.tag integerValue];
    wcTabelView.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;//设置分割线
    wcTabelView.allowsSelection  = YES; //cell是否可以被选择
    
    if (wcTabelView.isCustomCell) {
        if (wcTabelView.style == UITableViewStylePlain) {
            [wcTabelView gainFCMDataArray];
        }else{
            [wcTabelView gainFCMDataArrayForGrouped];
        }
    }else{
        if (wcTabelView.style == UITableViewStylePlain) {
            [wcTabelView gainBCMDataArray];
        }else{
            [wcTabelView gainBCMDataArrayForGrouped];
        }
    }
    
    //    [wcTabelView gainFCMDataArray];
    return wcTabelView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

//实例化方法主要调用的方法 在此主要可以通过类解析方法实现主要数据的添加以及数据源的初始化
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.tag = 101;
        _dataArray  = [[NSMutableArray alloc]init];
        _isCustomCell = NO;
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

#pragma mark 获取cell的数据 dataArray
//获取表视图的数据源(第一种cell)不分组的
-(void)gainFCMDataArray{
    BOOL isYes = YES;
    for (int i = 0; i< 5; i++) {
        FirstCellMember *member = [[FirstCellMember alloc]init];
        if (isYes) {
            member.labelText = @"how are you?";
            member.image = [UIImage imageNamed:@"5"];
            isYes = NO;
        }else{
            member.labelText = @"I'm fine!";
            member.image = nil;
            isYes = YES;
        }
        [_dataArray addObject:member];
        
    }
    
}
//获取表视图的数据源(第一种cell)分组的
-(void)gainFCMDataArrayForGrouped{
    
}
//获取表视图的基本数据源（基本subtitle样式的数据源）不分组的
-(void)gainBCMDataArray{

    for (int i = 0; i<5; i++) {
        BaseCellMember *member = [[BaseCellMember alloc]init];
        if (i%2==0) {
            member.mainString = @"hello ?";
            member.detailString = @"cs";
            member.isShowImage = YES;
            member.imageName = [UIImage imageNamed:@"5"];
        }else{
        
            member.mainString =@"hello!";
            member.detailString = @"me";
            member.isShowImage = NO;
            member.imageName = nil;
        }
        [_dataArray addObject:member];
    }
}

-(void)gainBCMDataArrayForGrouped{
    for (int t = 0; t<3; t++) {
        NSMutableDictionary *dictionar =[[NSMutableDictionary alloc]init];
        NSMutableArray *itemArray = [[NSMutableArray alloc]init];
        for (int i = 0; i<5; i++) {
            BaseCellMember *member = [[BaseCellMember alloc]init];
            if (i%2==0) {
                member.mainString = @"hello ?";
                member.detailString = @"cs";
                member.isShowImage = YES;
                member.imageName = [UIImage imageNamed:@"5"];
            }else{
                
                member.mainString =@"hello!";
                member.detailString = @"me";
                member.isShowImage = NO;
                member.imageName = nil;
            }
            [itemArray addObject:member];
        }
        [dictionar setObject:itemArray forKey:keyForRowData];
        [dictionar setObject:@"section" forKey:keyForSectionName];
        [_dataArray addObject:dictionar];
    }
   

}
#pragma mark setter methord
//数据源设置方法
-(void)setDataArray:(NSMutableArray *)dataArray{

    _dataArray = dataArray;
}

//是否加载为自定义的tableViewCell
-(void)setIsCustomCell:(BOOL)isCustomCell{

    _isCustomCell = isCustomCell;
    
}


#pragma mark tableView Delegate

//IOS7.0新增的三个预估计高度设置的方法
//将允许快速加载表视图

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 40;
//}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section{
//    
//    return 44;
//}
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section{
//    self.tableFooterView.backgroundColor = [UIColor blueColor];
//    return 44;
//}

//如果执行了上述三个方法，那么以下三个方法将推迟到视图可以显示出来，因此在此可以放置更加昂贵的逻辑
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    WFirstCustomCell *wCell = (WFirstCustomCell *)[tableView cellForRowAtIndexPath:indexPath];
//    CGFloat height = 40;
//    if (_isCustomCell) {
//        NSString *text = wCell.wTestLabel.text;
//        CGSize size = [text sizeWithFont:wCell.wTestLabel.font constrainedToSize:CGSizeMake(260, 300)];
////        CGSize wSize = [text boundingRectWithSize:CGSizeMake(320, 300) options:<#(NSStringDrawingOptions)#> attributes:<#(NSDictionary *)#> context:<#(NSStringDrawingContext *)#>]
//        height = size.height < 40? 40 :size.height + 10;
//    }
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    self.tableHeaderView.backgroundColor = [UIColor redColor];
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    view.backgroundColor = [UIColor blueColor];
    return nil;
}
//选中状态下的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"didSelectRowAtIndexPath");
}
//取消选中执行的代理方法
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"didDeselectRowAtIndexPth");
}
#pragma mark tableView DataSource
//设置表示图的分组数
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSInteger integer=1;
    if (tableView.style == UITableViewStylePlain) {
        integer = 1;
    }else{
        integer = _dataArray.count;
    }
    return integer;
}
//设置表示图每个分组的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger integer = 1;
    if (tableView.style == UITableViewStylePlain) {
        integer = _dataArray.count;
    }else{
        if ([[_dataArray objectAtIndex:section]isKindOfClass:[NSDictionary class]]) {
            NSArray *memberArray = [[NSArray alloc]init];
            memberArray = [[_dataArray objectAtIndex:section] objectForKey:keyForRowData];
            integer = memberArray.count;
        }else{
            NSArray *memberArray = [[NSArray alloc]init];
            memberArray = [_dataArray objectAtIndex:section];
            integer = memberArray.count;
        }
    }
    return integer;
}
//每个单行（cell）的设置
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    WFirstCustomCell *wcCell = [WFirstCustomCell cellWithTableView:tableView];
    wcCell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    if (tableView.style == UITableViewStylePlain) {
        
        if (_isCustomCell) {
            if ([[_dataArray objectAtIndex:indexPath.row]isKindOfClass:[FirstCellMember class]]) {
                wcCell.wTestLabel.text = nil;
                wcCell.wImageView.image = nil;
                wcCell.wTestLabel.textAlignment = NSTextAlignmentCenter;
                wcCell.member = [_dataArray objectAtIndex:indexPath.row];
                //    wcCell.textLabel.text = @"hello";
                //    wcCell.detailTextLabel.text = @"dsfdsf";
                //                wcCell.accessoryType = UITableViewCellAccessoryDetailButton;
            }else{
                
                wcCell.wTestLabel.text = @"Isn't FC member";
            }
            
        }else{
            if ([[_dataArray objectAtIndex:indexPath.row]isKindOfClass:[BaseCellMember class]]) {
                wcCell.textLabel.text = nil;
                
                wcCell.detailTextLabel.text = nil;
                wcCell.imageView.image = nil;
                wcCell.wTestLabel.textAlignment = NSTextAlignmentCenter;
                wcCell.baseMember = [_dataArray objectAtIndex:indexPath.row];
                //    wcCell.textLabel.text = @"hello";
                //    wcCell.detailTextLabel.text = @"dsfdsf";
                //                wcCell.accessoryType = UITableViewCellAccessoryDetailButton;
            }else{
                wcCell.textLabel.text = @"Isn't BC member";
            }
            
        }
        
    }
    else{
        NSArray *memberItem = [[NSArray alloc]init];//用于加载每个cell的单个数组
        if ([[_dataArray objectAtIndex:indexPath.section]isKindOfClass:[NSDictionary class]]) {
            memberItem = [[_dataArray objectAtIndex:indexPath.section] objectForKey:keyForRowData];
        }else{
            memberItem = [_dataArray objectAtIndex:indexPath.section];
        }
        if (_isCustomCell) {
            if ([[memberItem objectAtIndex:indexPath.row]isKindOfClass:[FirstCellMember class]]) {
                wcCell.wTestLabel.text = nil;
                wcCell.wImageView.image = nil;
                
                wcCell.wTestLabel.textAlignment = NSTextAlignmentCenter;
                wcCell.member = [memberItem objectAtIndex:indexPath.row];
                //                wcCell.accessoryType = UITableViewCellAccessoryDetailButton;
            }else{
                
                wcCell.wTestLabel.text = @"Isn't FC member";
            }
            
        }else{
            if ([[memberItem objectAtIndex:indexPath.row]isKindOfClass:[BaseCellMember class]]) {
                wcCell.textLabel.text = nil;
                
                wcCell.detailTextLabel.text = nil;
                wcCell.imageView.image = nil;
                wcCell.wTestLabel.textAlignment = NSTextAlignmentCenter;
                wcCell.baseMember = [memberItem objectAtIndex:indexPath.row];
                //                wcCell.accessoryType = UITableViewCellAccessoryDetailButton;
            }else{
                
                wcCell.textLabel.text = @"Isn't BC member";
            }
            
        }
    }    
    return wcCell;
}

//设置表示图的头视图的标签
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *string = [[NSString alloc]init];
    if (tableView.style == UITableViewStylePlain) {
        string = @"header";
    }else{
        string = [[_dataArray objectAtIndex:section] objectForKey:keyForSectionName];
    }
    return string;
}
//设置表示图的尾视图的标签
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSString *string = [[NSString alloc]init];
    if (tableView.style == UITableViewStylePlain) {
        string = @"footer";
    }else{
        string = nil;
    }
    return string;
}

//关于编辑的代理方法
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;
}
//关于移动的代理方法
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{

    return NO;
}
//返回表示图的分组标题的数组
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSArray *aray = [[NSArray alloc]init];
    if (tableView.style == UITableViewStylePlain) {
        aray = nil;
    }else{
        NSMutableArray *mArray = [[NSMutableArray alloc]init];
        for (int i = 0; i<_dataArray.count; i++) {
            if ([[_dataArray objectAtIndex:i]isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dic = [_dataArray objectAtIndex:i];
                NSString *seName = [NSString stringWithFormat:@"%@%d",[dic objectForKey:keyForSectionName],i];
                [mArray addObject:seName];
            }
        }
        aray = mArray;
    }
    return aray;
}

//处理编辑状态的方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

}
//处理移动状态的方法
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
   
}

#pragma mark 辅助方法
-(CGRect)rectFromModelJSON:(TableOfMapper *)tableOfMapper{
    CGRect table_rect;
    table_rect.origin.x = [tableOfMapper.xPointOfRect floatValue];
    table_rect.origin.y = [tableOfMapper.yPointOfRect floatValue];
    table_rect.size.width = [tableOfMapper.widthOfRect floatValue];
    table_rect.size.height = [tableOfMapper.heightOfRect floatValue];
    return table_rect;
}

@end
