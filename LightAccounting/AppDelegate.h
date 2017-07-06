//
//  AppDelegate.h
//  DLZProject
//
//  Created by ddllzz on 16/11/15.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import "BaseViewDelegate.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import "Constants.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong,nonatomic) UIViewController * viewController;

+ (UINavigationController *)rootNavigationController;

@property (nonatomic,weak) id<AppdelegateKeyboardState> keyboardDelegate;

@end

