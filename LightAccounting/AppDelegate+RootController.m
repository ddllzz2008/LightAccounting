//
//  AppDelegate+RootController.m
//  DLZProject
//
//  Created by ddllzz on 16/11/16.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "AppDelegate+RootController.h"
#import "MainTabController.h"

@implementation AppDelegate (RootController)

/*!
 *  @brief 获取当前屏幕显示的viewcontroller
 *
 *  @return 当前屏幕ViewController
 *
 *  @since 1.0
 */
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

-(void)setRootViewController{
//    UINavigationController * navc = [[UINavigationController alloc] initWithRootViewController:self.viewController];
//    [navc.navigationBar setTintColor:UIColorFromRGB(color_white_01)];
//    [navc.navigationBar setBarTintColor:UIColorFromRGB(color_navigation_bar)];
//    
//    navc.navigationBar.shadowImage = [[UIImage alloc] init];
//    [navc.navigationBar setTranslucent:NO];
//    
//    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    
//    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
//    
//    [navc.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    navc.navigationBar.tintColor = [UIColor whiteColor];
//    
    
    MainTabController *tabController = [[MainTabController alloc] init];
    self.window.rootViewController = tabController;
}

-(void)setTabbarController{
    
}

- (void)createLoadingScrollView{
    
}

-(void)setAppWindows{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication]setStatusBarHidden:NO];
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
}

@end
