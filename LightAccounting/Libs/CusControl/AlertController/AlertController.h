//
//  AlertController.h
//  DLZControls
//
//  Created by 李方超 on 15/12/23.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"


@interface AlertController : NSObject{
    MBProgressHUD *hub;
    UIWindow *messageWindow;
}

+(id)sharedInstance;

-(void)showMessageAutoClose:(NSString*)message;

-(void)showMessage:(NSString*)message;

-(void)closeMessage;

-(void)closeMessageDealy;

@end
