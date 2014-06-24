//
//  AppDelegate.h
//  ShareTimes
//
//  Created by 传晟 on 14-6-5.
//  Copyright (c) 2014年 传晟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BMapKit.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    BMKMapManager*_mapManager;
}
@property (strong, nonatomic) UIWindow *window;

@end
