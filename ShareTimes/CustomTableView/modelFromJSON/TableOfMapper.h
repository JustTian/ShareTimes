//
//  TableOfMapper.h
//  shiyan4
//
//  Created by 传晟 on 14-4-24.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableOfMapper : NSObject
@property(nonatomic,strong) NSString *type;
@property(nonatomic,strong) NSString *tag;
//定制背景颜色
@property(nonatomic,strong) NSString *RGBGreen;
@property(nonatomic,strong) NSString *RGBBlue;
@property(nonatomic,strong) NSString *RGBRed;
@property(nonatomic,strong) NSString *RGB_alpha;
//定制控件的frame
@property(nonatomic,strong) NSString *heightOfRect;
@property(nonatomic,strong) NSString *widthOfRect;
@property(nonatomic,strong) NSString *xPointOfRect;
@property(nonatomic,strong) NSString *yPointOfRect;
//定制表视图的显示类型
@property(nonatomic,assign) UITableViewStyle tableViewStyle;
@property (nonatomic,strong) NSArray *dataArray;//用于加载cell的数据

@property (nonatomic,strong) NSArray *sectionTArray;

//定制表视图是否显示自定义的tableViewCell
@property(nonatomic,strong) NSString *isCustomCell;
//@property(nonatomic,strong) NSString *RGB_alpha;


@property (nonatomic,assign) NSString * isCustomHeaderView;
@property (nonatomic,strong) NSString * CHeaderViewHeight;
@property (nonatomic,strong) NSDictionary *cHeaderViewDic;
@property (nonatomic,strong) NSString *hTitleForPlain;

@property (nonatomic,assign) NSString * isCustomFooterView;
@property(nonatomic,assign) NSString * CFooterViewHeight;
@property (nonatomic,strong) NSDictionary *cFooterViewDic;
@property (nonatomic,strong) NSString *fTitleForPlain;

+(TableOfMapper *)modelObjectWithDictionary:(NSDictionary *)dictionary;
-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(NSDictionary *)dictionaryRepresentation;

@end
