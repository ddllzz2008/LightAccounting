//
//  AppDelegate.m
//  DLZProject
//
//  Created by ddllzz on 16/11/15.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+AppLifeCircle.h"
#import "AppDelegate+AppService.h"
#import "AppDelegate+RootController.h"
#import "Class/Login/Controller/LoginViewController.h"
#import "AppliationLogic.h"
#import <iflyMSC/IFlySpeechUtility.h>

@interface AppDelegate (){
    
    BOOL _iskeyboardShow;
    
    BMKMapManager *_mapManager;
    
}

@end

@implementation AppDelegate

extern NSDictionary *viewrefreshCache;
/**
 获取键盘是否弹出

 @return YES：弹出，NO:没有弹出
 */
-(BOOL)iskeyboardShow{
    return _iskeyboardShow;
}

+ (UINavigationController *)rootNavigationController
{
    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
    return (UINavigationController *)app.window.rootViewController;
    
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSLog(@"%@", paths[0]);
    
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:fileLogger];
    
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];// 启用颜色区分
    // Override point for customization after application launch.
    
    [self monitorNetWorkStatus];
    
    //初始化下载配置信息数据
    [AppliationLogic createDatabase];
    
    [self setAppWindows];
    [self setTabbarController];
    [self setRootViewController];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];

    //初始化view刷新缓存对象
    [Constants Instance].viewrefreshCache = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@YES,@"mainpage",@YES,@"billpage",@YES,@"settingpage", nil];
    
    //初始化百度地图
    _mapManager = [[BMKMapManager alloc] init];
    bool ret = [_mapManager start:@"HUacHqLeSVqrGC4CHtXG0sQqMTZLXZau" generalDelegate:self];
    if (!ret) {
        DDLogError(@"百度地图服务启动失败");
    }
    
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@", @"593ff00a"];
    [IFlySpeechUtility createUtility:initString];
    
    [NSTimeZone setDefaultTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"CMT"]];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark---注册键盘打开关闭监听事件
-(void)keyboardWillShow:(NSNotification *)sender{
    _iskeyboardShow=YES;
    if (self.keyboardDelegate!=nil) {
        [self.keyboardDelegate keyboardWillShow:sender];
    }
}

-(void)keyboardWillHide:(NSNotification *)sender{
    _iskeyboardShow=NO;
    if (self.keyboardDelegate!=nil) {
        [self.keyboardDelegate keyboardWillHidden:sender];
    }
}

@end
