//
//  NewStep1View.h
//  LightAccounting
//
//  Created by ddllzz on 17/3/26.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UITextField+Style.h"
#import "NSDate+ExtMethod.h"
#import "CategoryChooseView.h"
#import "DLPickerView.h"
#import "DLDatePickerView.h"
#import "UIView+ExtMethod.h"

@interface NewStep1View : UIView<UIGestureRecognizerDelegate,UITextFieldDelegate,CategoryChooseViewDelegate,DLDatePickerViewDelegate>{
    
    UITextField *labeldate;
    
    UIImageView *imgcategory;
    
    UITextField *labelcategory;
    
}

@property (nonatomic,strong) UITextField *labelremark;

@property (nonatomic,strong) UITextField *inputmoney;

@property(nonatomic,strong) UIWindow *chooseWindow;

@end
