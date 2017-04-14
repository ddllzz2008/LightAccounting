//
//  AlertController.m
//  DLZControls
//
//  Created by 李方超 on 15/12/23.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import "AlertController.h"


@implementation AlertController

+(id)sharedInstance{
    static AlertController *sharedAlert = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAlert = [[self alloc] init];
    });
    return sharedAlert;
}

-(void)showMessageAutoClose:(NSString*)message{
    
    messageWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    messageWindow.windowLevel=UIWindowLevelStatusBar;
    messageWindow.backgroundColor=[UIColor clearColor];
    messageWindow.alpha=1;
    messageWindow.hidden = NO;
    
    UIView *rootview = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [messageWindow addSubview:rootview];
    
    hub = [MBProgressHUD showHUDAddedTo:rootview animated:YES];
    hub.mode = MBProgressHUDModeText;
    hub.labelText = message;
    hub.removeFromSuperViewOnHide=YES;
    [hub hide:YES afterDelay:2];
    if (messageWindow!=nil) {
        messageWindow.hidden=YES;
        messageWindow=nil;
    }
}

-(void)showMessage:(NSString*)message{
    
    [self closeMessage];
    
    messageWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    messageWindow.windowLevel=UIWindowLevelStatusBar;
    messageWindow.backgroundColor=[UIColor clearColor];
    messageWindow.alpha=1;
    messageWindow.hidden = NO;
    
    UIView *rootview = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [messageWindow addSubview:rootview];
    
    hub = [MBProgressHUD showHUDAddedTo:rootview animated:YES];
    hub.mode = MBProgressHUDModeText;
    hub.labelText = message;
    hub.removeFromSuperViewOnHide=YES;
    [hub show:YES];
}

-(void)closeMessage{
    if (hub!=nil) {
        [hub hide:YES];
        hub = nil;
    }
    if (messageWindow!=nil) {
        messageWindow.hidden=YES;
        messageWindow=nil;
    }
}

-(void)closeMessageDealy{
    if (hub!=nil) {
        [hub hide:YES afterDelay:2];
    }
    if (messageWindow!=nil) {
        messageWindow.hidden=YES;
        messageWindow=nil;
    }
}

@end
