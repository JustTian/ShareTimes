//
//  RefreshFooterView.m
//  shiyan3
//
//  Created by 传晟 on 14-4-14.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import "RefreshFooterView.h"
#import "WZRefrshConst.h"


@interface RefreshFooterView (){
    int _lastRefreshCount;
}

@end

@implementation RefreshFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [_lastUpdateTimeLabel removeFromSuperview];
        _lastUpdateTimeLabel = nil;
    }
    return self;
}
+ (instancetype)footer{
    return [[RefreshFooterView alloc]init];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    CGFloat h = frame.size.height;
    if (_statusLabel.center.y != h * 0.5) {
        CGFloat w = frame.size.width;
        _statusLabel.center = CGPointMake(w * 0.5, h * 0.5);
    }
}

#pragma mark about UIScrollView methord
- (void)setScrollView:(UIScrollView *)scrollView
{
    // 1.移除以前的监听器
    [_scrollView removeObserver:self forKeyPath:WZRefreshContentSize context:nil];
    // 2.监听contentSize
    [scrollView addObserver:self forKeyPath:WZRefreshContentSize options:NSKeyValueObservingOptionNew context:nil];
    
    // 3.父类的方法
    [super setScrollView:scrollView];
    
    // 4.重新调整frame
    [self adjustFrame];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
    if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden) return;
    
    if ([WZRefreshContentSize isEqualToString:keyPath]) {
        [self adjustFrame];
    }
}
- (void)adjustFrame
{
    // 内容的高度
    CGFloat contentHeight = _scrollView.contentSize.height;
    // 表格的高度
    CGFloat scrollHeight = _scrollView.frame.size.height - _scrollViewInitInset.top - _scrollViewInitInset.bottom;
    CGFloat y = MAX(contentHeight, scrollHeight);
    // 设置边框
    self.frame = CGRectMake(0, y, _scrollView.frame.size.width, WZRefreshViewHeight);
}

#pragma mark 设置状态
- (void)setState:(WZRefreshState)state
{
    if (_state == state) return;
    WZRefreshState oldState = _state;
    
    [super setState:state];
    
	switch (state)
    {
		case WZRefreshStatePulling:
        {
            _statusLabel.text = WZRefreshFooterReleaseToRefresh;
            
            [UIView animateWithDuration:WZRefreshAnimationDuration animations:^{
                _arrowImage.transform = CGAffineTransformIdentity;
                UIEdgeInsets inset = _scrollView.contentInset;
                inset.bottom = _scrollViewInitInset.bottom;
                _scrollView.contentInset = inset;
            }];
			break;
        }
            
		case WZRefreshStateNormal:
        {
            _statusLabel.text = WZRefreshFooterPullToRefresh;
            
            // 刚刷新完毕
            CGFloat animDuration = WZRefreshAnimationDuration;
            CGFloat deltaH = [self contentBreakView];
            CGPoint tempOffset;
            
            int currentCount = [self totalDataCountInScrollView];
            if (WZRefreshStateDidRefreshing == oldState && deltaH > 0 && currentCount != _lastRefreshCount) {
                tempOffset = _scrollView.contentOffset;
                animDuration = 0;
            }
            
            [UIView animateWithDuration:animDuration animations:^{
                _arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                UIEdgeInsets inset = _scrollView.contentInset;
                inset.bottom = _scrollViewInitInset.bottom;
                _scrollView.contentInset = inset;
            }];
            
            if (animDuration == 0) {
                _scrollView.contentOffset = tempOffset;
            }
			break;
        }
            
        case WZRefreshStateDidRefreshing:
        {
            // 记录刷新前的数量
            _lastRefreshCount = [self totalDataCountInScrollView];
            
            _statusLabel.text = WZRefreshFooterRefreshing;
            _arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
            [UIView animateWithDuration:WZRefreshAnimationDuration animations:^{
                UIEdgeInsets inset = _scrollView.contentInset;
                CGFloat bottom = WZRefreshViewHeight + _scrollViewInitInset.bottom;
                CGFloat deltaH = [self contentBreakView];
                if (deltaH < 0) { // 如果内容高度小于view的高度
                    bottom -= deltaH;
                }
                inset.bottom = bottom;
                _scrollView.contentInset = inset;
            }];
			break;
        }
            
        default:
            break;
	}
}

#pragma mark 获得scrollView的内容 超出 view 的高度
- (CGFloat)contentBreakView
{
    CGFloat h = _scrollView.frame.size.height - _scrollViewInitInset.bottom - _scrollViewInitInset.top;
    return _scrollView.contentSize.height - h;
}

#pragma mark - 在父类中用得上
// 合理的Y值(刚好看到上拉刷新控件时的contentOffset.y，取相反数)
- (CGFloat)validY
{
    CGFloat deltaH = [self contentBreakView];
    if (deltaH > 0) {
        return deltaH -_scrollViewInitInset.top;
    } else {
        return -_scrollViewInitInset.top;
    }
}

// view的类型
- (int)viewType
{
    return WZRefreshViewTypeFooter;
}

- (void)free
{
    [super free];
    [_scrollView removeObserver:self forKeyPath:WZRefreshContentSize];
}


@end
