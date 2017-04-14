//
//  AppDelegate+RootController.h
//  DLZProject
//
//  Created by ddllzz on 16/11/16.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (RootController)

+ (UIViewController *)getCurrentVC;

/**
 *  首次启动轮播图
 */
- (void)createLoadingScrollView;
/**
 *  tabbar实例
 */
- (void)setTabbarController;

/**
 *  window实例
 */
- (void)setAppWindows;

/**
 *  设置根视图
 */
- (void)setRootViewController;

@end
