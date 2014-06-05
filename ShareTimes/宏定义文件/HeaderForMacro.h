//
//  HeaderForMacro.h
//  AutoLoadView
//
//  Created by 传晟 on 14-3-19.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#ifndef AutoLoadView_HeaderForMacro_h
#define AutoLoadView_HeaderForMacro_h
#endif

//上面的可以不要


#if ! __has_feature(objc_arc)
#define SmartCellAutorelease(__v) ([__v autorelease]);
#define SmartCellReturnAutoreleased SmartCellAutorelease

#define SmartCellRetain(__v) ([__v retain]);
#define SmartCellReturnRetained SmartCellRetain

#define SmartCellRelease(__v) ([__v release]);

#define SmartCellDispatchQueueRelease(__v) (dispatch_release(__v));
#else
// -fobjc-arc
#define SmartCellAutorelease(__v)
#define SmartCellReturnAutoreleased(__v) (__v)

#define SmartCellRetain(__v)
#define SmartCellReturnRetained(__v) (__v)

#define SmartCellRelease(__v)

#if TARGET_OS_IPHONE
// Compiling for iOS
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= 60000
// iOS 6.0 or later
#define SmartCellDispatchQueueRelease(__v)
#else
// iOS 5.X or earlier
#define SmartCellDispatchQueueRelease(__v) (dispatch_release(__v));
#endif
#else
// Compiling for Mac OS X
#if MAC_OS_X_VERSION_MIN_REQUIRED >= 1080
// Mac OS X 10.8 or later
#define SmartCellDispatchQueueRelease(__v)
#else
// Mac OS X 10.7 or earlier
#define SmartCellDispatchQueueRelease(__v) (dispatch_release(__v));
#endif
#endif
#endif

#if !__has_feature(objc_instancetype)
#define instancetype id
#endif