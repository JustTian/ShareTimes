//
//  WCustomTableView.m
//  shiyan4
//
//  Created by 传晟 on 14-4-16.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "WCustomTableView.h"
#import "WFirstCustomCell.h"
#import "WBaseTableViewCell.h"

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
    wcTabelView.isFootView = [tableOfMapper.isCustomFooterView boolValue];
    wcTabelView.isHeadView = [tableOfMapper.isCustomHeaderView boolValue];
    
//    wcTabelView.dataArray = (NSMutableArray *)tableOfMapper.dataArray;
//    wcTabelView.sectionTitleArray = (NSMutableArray *)tableOfMapper.sectionTArray;

    wcTabelView.tag = [tableOfMapper.tag integerValue];
    wcTabelView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;//设置分割线
    wcTabelView.allowsSelection  = YES; //cell是否可以被选择
    
//    wcTabelView.isHeadView = YES;
    
    wcTabelView.delegate = wcTabelView;
    wcTabelView.dataSource = wcTabelView;
    //初始化头视图
    wDynamicLayout *wdLayout = [[wDynamicLayout alloc]init];
    if (wcTabelView.isHeadView) {
        wcTabelView.tHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [tableOfMapper.CHeaderViewHeight floatValue])];
//        wcTabelView.tHeaderView.backgroundColor = [UIColor grayColor];
        [wdLayout loadItemsForGroup:tableOfMapper.cHeaderViewDic AndBaseView:wcTabelView.tHeaderView];
    }else{
        wcTabelView.headerTitlePlain = tableOfMapper.hTitleForPlain;
        if ([tableOfMapper.hTitleForPlain isEqualToString:@"nil"]) {
            wcTabelView.headerTitlePlain = nil;
        }
    }
    
    if (wcTabelView.isFootView) {
        wcTabelView.tFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, [tableOfMapper.CFooterViewHeight floatValue])];
//        wcTabelView.tFooterView.backgroundColor = [UIColor grayColor];
        [wdLayout loadItemsForGroup:tableOfMapper.cFooterViewDic AndBaseView:wcTabelView.tFooterView];
    }else{
        wcTabelView.footerTitlePlain = tableOfMapper.fTitleForPlain;
        if ([tableOfMapper.fTitleForPlain isEqualToString:@"nil"]) {
            wcTabelView.footerTitlePlain = nil;
        }

    }
    //初始化cell的数据源
    if (wcTabelView.isCustomCell) {
        [wcTabelView gainFCMDataArray:tableOfMapper.dataArray andTableViewStyle:wcTabelView.style];
        
    }
    //初始化分组表视图的分组标题
    wcTabelView.sectionTitleArray = (NSMutableArray *)tableOfMapper.sectionTArray;
//    if (wcTabelView.isCustomCell) {
//        if (wcTabelView.style == UITableViewStylePlain) {
//            [wcTabelView gainFCMDataArray];
//        }else{
//            [wcTabelView gainFCMDataArrayForGrouped];
//        }
//    }else{
//        if (wcTabelView.style == UITableViewStylePlain) {
//            [wcTabelView gainBCMDataArray];
//        }else{
//            [wcTabelView gainBCMDataArrayForGrouped];
//        }
//    }
    
    //    [wcTabelView gainFCMDataArray];
    return wcTabelView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.delegate = self;
//        self.dataSource = self;
    }
    return self;
}

//实例化方法主要调用的方法 在此主要可以通过类解析方法实现主要数据的添加以及数据源的初始化
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.tag = 101;
        _dataArray  = [[NSMutableArray alloc]init];
        _sectionTitleArray = [[NSMutableArray alloc]init];
        _footGroupArray = [[NSMutableArray alloc]init];
        
        _isCustomCell = NO;
//        self.delegate = self;
//        self.dataSource = self;
    }
    return self;
}

#pragma mark 获取cell的数据 dataArray
//获取表视图的数据源(第一种cell)不分组的
-(void)gainFCMDataArray:(NSArray *)array andTableViewStyle:(UITableViewStyle)tableStyle{
    int tCount = 1;
    if (tableStyle != UITableViewStylePlain) {
        tCount = (int )array.count;
    }
    for (int i = 0; i<tCount; i++) {
        NSMutableArray *mArray = [[NSMutableArray alloc]init];
        NSArray *subArray = [array objectAtIndex:i];
        for (int j = 0; j<subArray.count; j++) {
            NSDictionary *ldict = [subArray objectAtIndex:j];
            NSString *keyString = [NSString stringWithFormat:@"member_%d",j];
            NSDictionary *subDic = [ldict objectForKey:keyString];
            
            FirstCellMember *member = [[FirstCellMember alloc]init];
            member.labelText = [subDic objectForKey:@"mainTitle"];
            if ([[subDic objectForKey:@"isURLImage"] boolValue]) {
                NSURL *urel = [NSURL URLWithString:[subDic objectForKey:@"imageURLString"]];
                member.image = [self setImageWithURL:urel];
            }else{
                NSString *iString = [subDic objectForKey:@"imageName"];
                member.image = [UIImage imageNamed:iString];
            }
//            NSLog(@"%@",member);
            [mArray addObject:member];
            
        }
        if (tCount>1) {
            [_dataArray addObject:mArray];
        }else{
            [_dataArray addObjectsFromArray:mArray];
        }
    }
}
-(UIImage *)setImageWithURL:(NSURL *)url{
   __block UIImage *rImage;
    dispatch_queue_t queue = dispatch_queue_create("imageUrl", NULL);
    dispatch_async(queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            rImage =image;
            
        });
    });
    return rImage;
}

-(void)gainFCMDataArray{
//    BOOL isYes = YES;
//    for (int i = 0; i< 6; i++) {
//        FirstCellMember *member = [[FirstCellMember alloc]init];
//        if (isYes) {
//            member.labelText = @"how are you?";
//            member.image = [UIImage imageNamed:@"heart_fill_32x38"];
//            isYes = NO;
//        }else{
//            member.labelText = @"I'm fine!反狂萨芬是反动拉反dsa发动机拉飞但赛a费 翻开放到是尽量空a 负担凯撒发动垃圾分量撒飞单孔啦发动啦发dsa了发冬";
//            member.image = [UIImage imageNamed:@"heart_fill_32x38"];
//            isYes = YES;
//        }
//        [_dataArray addObject:member];
//        
//    }
    NSArray *ttArray = @[@"第一套调查问卷",@"第二套调查问卷",@"第三套调查问卷",@"第四套调查问卷",@"第五套调查问卷"];
    
        for (int i = 0; i<4; i++) {
            FirstCellMember *member = [[FirstCellMember alloc]init];
            member.labelText = [ttArray objectAtIndex:i];
            [_dataArray addObject:member];
        }
//        [_dataArray addObject:itemArray];
    
    
}
//获取表视图的数据源(第一种cell)分组的
-(void)gainFCMDataArrayForGrouped{
    NSArray *ttArray = @[@"第一套调查问卷",@"第二套调查问卷",@"第三套调查问卷",@"第四套调查问卷",@"第五套调查问卷"];
    for (int t = 0; t<3; t++) {
        NSMutableArray *itemArray = [[NSMutableArray alloc]init];
        for (int i = 0; i<1; i++) {
            FirstCellMember *member = [[FirstCellMember alloc]init];
            member.labelText = [ttArray objectAtIndex:t];
            [itemArray addObject:member];
        }
        [_dataArray addObject:itemArray];
        NSString *setTitle = [NSString stringWithFormat:@"Section:%d",t];
        [_sectionTitleArray addObject:setTitle];
    }

}
//获取表视图的基本数据源（基本subtitle样式的数据源）不分组的
-(void)gainBCMDataArray{

    for (int i = 0; i<5; i++) {
        BaseCellMember *member = [[BaseCellMember alloc]init];
        if (i%2==0) {
            member.mainString = @"hello ?";
            member.detailString = @"cs";
            member.isShowImage = YES;
            member.imageName = [UIImage imageNamed:@"3"];
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
        NSMutableArray *itemArray = [[NSMutableArray alloc]init];
        for (int i = 0; i<5; i++) {
            BaseCellMember *member = [[BaseCellMember alloc]init];
            if (i%2==0) {
                member.mainString = @"hello ?";
                member.detailString = @"cs";
                member.isShowImage = YES;
                member.imageName = [UIImage imageNamed:@"3"];
            }else{
                
                member.mainString =@"hello!";
                member.detailString = @"me";
                member.isShowImage = NO;
                member.imageName = nil;
            }
            [itemArray addObject:member];
        }
        [_dataArray addObject:itemArray];
        NSString *setTitle = [NSString stringWithFormat:@"Section:%d",t];
        [_sectionTitleArray addObject:setTitle];
    }
//   _footGroupArray = @[nil,nil,]

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
    if (_isCustomCell) {
        WFirstCustomCell *wcCell = [WFirstCustomCell cellWithTableView:tableView];
        wcCell.selectionStyle = UITableViewCellSelectionStyleBlue;
        if (tableView.style == UITableViewStylePlain) {

                if ([[_dataArray objectAtIndex:indexPath.row]isKindOfClass:[FirstCellMember class]]) {
                    wcCell.wTestLabel.text = nil;
                    wcCell.wImageView.image = nil;
                    wcCell.member = [_dataArray objectAtIndex:indexPath.row];
                    //                wcCell.accessoryType = UITableViewCellAccessoryDetailButton;
                }else{
                    
                    wcCell.wTestLabel.text = @"Isn't FC member";
                }
                
                
        }
        else{
            NSArray *memberItem = [[NSArray alloc]init];//用于加载每个cell的单个数组
            if ([[_dataArray objectAtIndex:indexPath.section]isKindOfClass:[NSDictionary class]]) {
                memberItem = [[_dataArray objectAtIndex:indexPath.section] objectForKey:keyForRowData];
            }else{
                memberItem = [_dataArray objectAtIndex:indexPath.section];
            }
           
                if ([[memberItem objectAtIndex:indexPath.row]isKindOfClass:[FirstCellMember class]]) {
                    wcCell.wTestLabel.text = nil;
                    wcCell.wImageView.image = nil;
                    wcCell.member = [memberItem objectAtIndex:indexPath.row];
//                wcCell.accessoryType = UITableViewCellAccessoryDetailButton;
                }else{
                    
                    wcCell.wTestLabel.text = @"Isn't FC member";
                }
                
        }
        return wcCell;
    }
    
    else
    {
        static  NSString *cellIn=@"haha";
        WBaseTableViewCell *wcCell=[tableView dequeueReusableCellWithIdentifier:cellIn];
        
        
        if(wcCell==nil){
            wcCell=[[WBaseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIn];
            wcCell.selectionStyle = UITableViewCellSelectionStyleBlue;
        }
        if (tableView.style == UITableViewStylePlain) {
            
                if ([[_dataArray objectAtIndex:indexPath.row]isKindOfClass:[BaseCellMember class]]) {
                    wcCell.textLabel.text = nil;
                    
                    wcCell.detailTextLabel.text = nil;
                    wcCell.imageView.image = nil;
                    //                wcCell.wTestLabel.textAlignment = NSTextAlignmentCenter;
                    wcCell.baseMember = [_dataArray objectAtIndex:indexPath.row];
                }else{
                    wcCell.textLabel.text = @"Isn't BC member";
                }
        }
        else{
            NSArray *memberItem = [[NSArray alloc]init];//用于加载每个cell的单个数组
            if ([[_dataArray objectAtIndex:indexPath.section]isKindOfClass:[NSDictionary class]]) {
                memberItem = [[_dataArray objectAtIndex:indexPath.section] objectForKey:keyForRowData];
            }else{
                memberItem = [_dataArray objectAtIndex:indexPath.section];
            }
            
            if ([[memberItem objectAtIndex:indexPath.row]isKindOfClass:[BaseCellMember class]]) {
                wcCell.textLabel.text = nil;
                wcCell.detailTextLabel.text = nil;
                wcCell.imageView.image = nil;
                wcCell.baseMember = [memberItem objectAtIndex:indexPath.row];
                
//                wcCell.accessoryType = UITableViewCellAccessoryDetailButton;
            }else{
                
                wcCell.textLabel.text = @"Isn't BC member";
            }
            
        }

        return wcCell;
    }
    /*
//    WFirstCustomCell *wcCell = [WFirstCustomCell cellWithTableView:tableView];
//    wcCell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
//    if (tableView.style == UITableViewStylePlain) {
//        
//        if (_isCustomCell) {
//            if ([[_dataArray objectAtIndex:indexPath.row]isKindOfClass:[FirstCellMember class]]) {
//                wcCell.wTestLabel.text = nil;
//                wcCell.wImageView.image = nil;
////                wcCell.wTestLabel.textAlignment = NSTextAlignmentCenter;
//                wcCell.member = [_dataArray objectAtIndex:indexPath.row];
//                //    wcCell.textLabel.text = @"hello";
//                //    wcCell.detailTextLabel.text = @"dsfdsf";
//                //                wcCell.accessoryType = UITableViewCellAccessoryDetailButton;
//            }else{
//                
//                wcCell.wTestLabel.text = @"Isn't FC member";
//            }
//            
//        }else{
//            if ([[_dataArray objectAtIndex:indexPath.row]isKindOfClass:[BaseCellMember class]]) {
//                wcCell.textLabel.text = nil;
//                
//                wcCell.detailTextLabel.text = nil;
//                wcCell.imageView.image = nil;
////                wcCell.wTestLabel.textAlignment = NSTextAlignmentCenter;
//                wcCell.baseMember = [_dataArray objectAtIndex:indexPath.row];
//                //    wcCell.textLabel.text = @"hello";
//                //    wcCell.detailTextLabel.text = @"dsfdsf";
//                //                wcCell.accessoryType = UITableViewCellAccessoryDetailButton;
//            }else{
//                wcCell.textLabel.text = @"Isn't BC member";
//            }
//            
//        }
//        
//    }
//    else{
//        NSArray *memberItem = [[NSArray alloc]init];//用于加载每个cell的单个数组
//        if ([[_dataArray objectAtIndex:indexPath.section]isKindOfClass:[NSDictionary class]]) {
//            memberItem = [[_dataArray objectAtIndex:indexPath.section] objectForKey:keyForRowData];
//        }else{
//            memberItem = [_dataArray objectAtIndex:indexPath.section];
//        }
//        if (_isCustomCell) {
//            if ([[memberItem objectAtIndex:indexPath.row]isKindOfClass:[FirstCellMember class]]) {
//                wcCell.wTestLabel.text = nil;
//                wcCell.wImageView.image = nil;
//                
////                wcCell.wTestLabel.textAlignment = NSTextAlignmentCenter;
//                wcCell.member = [memberItem objectAtIndex:indexPath.row];
//                //                wcCell.accessoryType = UITableViewCellAccessoryDetailButton;
//            }else{
//                
//                wcCell.wTestLabel.text = @"Isn't FC member";
//            }
//            
//        }else{
//            if ([[memberItem objectAtIndex:indexPath.row]isKindOfClass:[BaseCellMember class]]) {
//                wcCell.textLabel.text = nil;
//                
//                wcCell.detailTextLabel.text = nil;
//                wcCell.imageView.image = nil;
////                wcCell.wTestLabel.textAlignment = NSTextAlignmentCenter;
//                wcCell.baseMember = [memberItem objectAtIndex:indexPath.row];
//                //                wcCell.accessoryType = UITableViewCellAccessoryDetailButton;
//            }else{
//                
//                wcCell.textLabel.text = @"Isn't BC member";
//            }
//            
//        }
//    }    
//    return wcCell;
     */
}

//设置表示图的头视图的标签
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *string = [[NSString alloc]init];
    if (tableView.style == UITableViewStylePlain) {
        string = self.headerTitlePlain;
    }else{
        string  = [_sectionTitleArray objectAtIndex:section];
//        string = @"头标题";
    }
    return string;
//    return nil;
}
//设置表示图的尾视图的标签
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    NSString *string = [[NSString alloc]init];
    if (tableView.style == UITableViewStylePlain) {
        string = self.footerTitlePlain;
//        string = nil;
    }else{
        if (section == [_dataArray count]-1) {
            string = self.footerTitlePlain;
        }else{
            string = nil;
        }
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
//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    NSArray *aray = [[NSArray alloc]init];
//    if (tableView.style == UITableViewStylePlain) {
//        aray = nil;
//    }else{
//        NSMutableArray *mArray = [[NSMutableArray alloc]init];
//        for (int i = 0; i<_dataArray.count; i++) {
//            if ([[_dataArray objectAtIndex:i]isKindOfClass:[NSDictionary class]]) {
//                NSDictionary *dic = [_dataArray objectAtIndex:i];
//                NSString *seName = [NSString stringWithFormat:@"%@%d",[dic objectForKey:keyForSectionName],i];
//                [mArray addObject:seName];
//            }
//        }
//        aray = mArray;
//    }
//    return aray;
//}

//处理编辑状态的方法
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
//处理移动状态的方法
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
}


#pragma mark tableView Delegate
/* 
 *
 *
 *
 */
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
//    return 44;
//    WFirstCustomCell *fCustomCell = (WFirstCustomCell *)[tableView cellForRowAtIndexPath:indexPath];
    CGFloat fHeight = 44;
    if (tableView.style != UITableViewStylePlain) {
        NSArray *memberItem = [[NSArray alloc]init];//用于加载每个cell的单个数组
        if ([[_dataArray objectAtIndex:indexPath.section]isKindOfClass:[NSDictionary class]]) {
            memberItem = [[_dataArray objectAtIndex:indexPath.section] objectForKey:keyForRowData];
        }else{
            memberItem = [_dataArray objectAtIndex:indexPath.section];
        }
        if ([[memberItem objectAtIndex:indexPath.row]isKindOfClass:[FirstCellMember class]]) {
            FirstCellMember *fMember = [memberItem objectAtIndex:indexPath.row];
            if (fMember.labelText) {
                CGSize size = [fMember.labelText sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(280, 1000)];
                CGFloat Height = size.height;
                fHeight = Height>44? Height: 44;
            }
        }
        
        if ([[memberItem objectAtIndex:indexPath.row]isKindOfClass:[BaseCellMember class]]) {
            BaseCellMember *bMember = [memberItem objectAtIndex:indexPath.row];
            if (bMember.mainString) {
                CGSize size = [bMember.mainString sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(280, 1000)];
                CGFloat Height = size.height + 20;
                fHeight = Height>44? Height: 44;
            }
        }

    }else{
    
        if ([[_dataArray objectAtIndex:indexPath.row]isKindOfClass:[FirstCellMember class]]) {
            FirstCellMember *fMember = [_dataArray objectAtIndex:indexPath.row];
            if (fMember.labelText) {
                CGSize size = [fMember.labelText sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(280, 1000)];
                CGFloat Height = size.height;
                fHeight = Height>44? Height: 44;
            }
        }
        
        if ([[_dataArray objectAtIndex:indexPath.row]isKindOfClass:[BaseCellMember class]]) {
            BaseCellMember *bMember = [_dataArray objectAtIndex:indexPath.row];
            if (bMember.mainString) {
                CGSize size = [bMember.mainString sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(280, 1000)];
                CGFloat Height = size.height + 20;
                fHeight = Height>44? Height: 44;
            }
        }

    }
    return fHeight;
}

//设置头视图和尾视图的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    self.tableHeaderView.backgroundColor = [UIColor redColor];
    if (tableView.style == UITableViewStylePlain) {
        if (_isHeadView) {
            return self.tHeaderView.frame.size.height;
        }else{
            NSString *string = [self tableView:tableView titleForHeaderInSection:section];
            if (string) {
                return 30;
            }else{
                return 0;
            }
            
        }

    }
    //分组情况下对头视图的高度进行设置
    else{
        NSString *string = [self tableView:tableView titleForHeaderInSection:section];
        if (string) {
            return 30;
        }else{
            return 0;
        }

//        return 0;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView.style == UITableViewStylePlain) {
        if (_isFootView) {
            return self.tFooterView.frame.size.height;
        }else{
            NSString *string = [self tableView:tableView titleForFooterInSection:section];
            if (string) {
                return 30;
            }else{
                return 0;
            }
            
        }
        
    }
    //分组情况下对头视图的高度进行设置
    else{
        NSString *string = [self tableView:tableView titleForFooterInSection:section];
        NSLog(@"string = %@",string);
        if (string) {
            return 21;
        }else{
            return 0.1;
        }

//        return 5;
    }

}

//**************设置tableview的头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView.style == UITableViewStylePlain) {
        if (_isHeadView) {
            return self.tHeaderView;
        }else{
            return nil;
        }
    }
    else{
        //当在分组情况下对头视图进行设置
        return nil;
    }

    
}

//***************设置tableview的脚视图
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (tableView.style == UITableViewStylePlain) {
        if (_isFootView) {
            return self.tFooterView;
        }else{
            return nil;
        }
    }
    else{
        //当在分组情况下对头视图进行设置
//        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
//        view.backgroundColor = [UIColor greenColor];
//        return view;
        return nil;
    }
}
//选中状态下的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.myTCellSelectedBlock(indexPath);
    NSLog(@"didSelectRowAtIndexPath");
}
//取消选中执行的代理方法
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSLog(@"didDeselectRowAtIndexPth");
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
