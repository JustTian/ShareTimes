//
//  WZRefrshConst.h
//  shiyan3
//
//  Created by 传晟 on 14-4-14.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#ifdef DEBUG
#define MJLog(...) NSLog(__VA_ARGS__)
#else
#define MJLog(...)
#endif

// 文字颜色
#define WZRefreshLabelTextColor [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0]

extern const CGFloat WZRefreshViewHeight;
extern const CGFloat WZRefreshAnimationDuration;

extern NSString *const WZRefreshBundleName;
#define kSrcName(file) [WZRefreshBundleName stringByAppendingPathComponent:file]

extern NSString *const WZRefreshFooterPullToRefresh;
extern NSString *const WZRefreshFooterReleaseToRefresh;
extern NSString *const WZRefreshFooterRefreshing;

extern NSString *const WZRefreshHeaderPullToRefresh;
extern NSString *const WZRefreshHeaderReleaseToRefresh;
extern NSString *const WZRefreshHeaderRefreshing;
extern NSString *const WZRefreshHeaderTimeKey;

extern NSString *const WZRefreshContentOffset;
extern NSString *const WZRefreshContentSize;