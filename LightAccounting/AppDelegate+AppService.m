//
//  AppDelegate+AppService.m
//  DLZProject
//
//  Created by ddllzz on 16/11/16.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "AppDelegate+RootController.h"
#import "AFNetworking.h"
#import "Libs/CusControl/AlertController/AlertController.h"

@implementation AppDelegate (AppService)

-(void)monitorNetWorkStatus{
    //检测网络情况
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:
                [[AlertController sharedInstance] showMessageAutoClose:@"网络断开"];
                break;
            default:
                break;
        }
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

@end
