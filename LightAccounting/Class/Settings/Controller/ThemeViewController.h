//
//  ThemeViewController.h
//  LightAccounting
//
//  Created by ddllzz on 2017/4/26.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewController.h"
#import "DLZAlertView.h"
#import "AlertController.h"
#import "HRColorPickerView.h"
#import "UIViewController+BackButtonHandler.h"

@interface ThemeViewController : BaseViewController{
    
    UIColor *currentColor;
    
    BOOL ifcolorChanged;
    
}

@end
