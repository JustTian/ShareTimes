//
//  WZRefreshBaseView.h
//  shiyan3
//
//  Created by 传晟 on 14-4-13.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <UIKit/UIKit.h>
//控件的刷新状态
typedef NS_ENUM(NSInteger,WZRefreshState) {
    WZRefreshStatePulling = 1,      //松开就进行刷新
    WZRefreshStateNormal  = 2,      //普通刷新
    WZRefreshStateDidRefreshing = 3,//正在刷新
    WZRefreshStateWillRefreshing = 4,//将要刷新
};
//控件的类型
typedef enum {
    WZRefreshViewTypeHeader = -1,
    WZRefreshViewTypeFooter = 1,
}WZRefreshViewType;

@class WZRefreshBaseView;
//进入刷新状态时调用的block方法
typedef void (^ beginRefreshingBlock)(WZRefreshBaseView *refreshView);
//刷新结束时调用的block方法
typedef void (^ endRefreshBlock)(WZRefreshBaseView *refreshView);
//刷新状态变更时调用的block方法
typedef void (^ changRefreshStateBlock)(WZRefreshBaseView *refreshView,WZRefreshState refreshState);

@protocol WZRefreshBaseViewDelegate <NSObject>

@optional
//进入刷新状态时调用的协议方法
-(void)refreshViewBeginRefreshing:(WZRefreshBaseView *)refreshView;
//刷新状态结束时调用的协议方法
-(void)refreshViewEndRefreshing:(WZRefreshBaseView *)refreshView;
//刷新状态改变时调用的协议方法
-(void)refreshViewChanging:(WZRefreshBaseView *)refreshView andStateChang:(WZRefreshState) state;
@end

@interface WZRefreshBaseView : UIView{
    //父控件开始的contentinset
    UIEdgeInsets _scrollViewInitInset;
    //父控件
    __weak UIScrollView *_scrollView;
    //多个子控件
    __weak UILabel *_lastUpdateTimeLabel;
    __weak UILabel *_statusLabel;
    __weak UIImageView *_arrowImage;
    __weak UIActivityIndicatorView *_activityView;
    //状态
    WZRefreshState _state;
}
// 构造方法
- (instancetype)initWithScrollView:(UIScrollView *)scrollView;
// 设置要显示的父控件
@property (nonatomic, weak) UIScrollView *scrollView;

@property (nonatomic,weak,readonly) UILabel *lastUpdateTimeLabel;
@property (nonatomic,weak,readonly) UILabel *statusLabel;
@property (nonatomic,weak,readonly) UIImageView *arrowImage;

@property (nonatomic,copy)beginRefreshingBlock beginBolock;
@property (nonatomic,copy)endRefreshBlock endBlock;
@property (nonatomic,copy)changRefreshStateBlock changeBlock;

@property (nonatomic,assign) id<WZRefreshBaseViewDelegate> delegate;

@property  (nonatomic,readonly,getter = isRefreshing) BOOL refreshing;
//开始刷新
-(void)beginRefreshing;
//结束刷新
-(void)endRefreshing;
//结束使用，释放资源
-(void)free;

-(void)setState:(WZRefreshState) state;
-(int)totalDataCountInScrollView;

@end
