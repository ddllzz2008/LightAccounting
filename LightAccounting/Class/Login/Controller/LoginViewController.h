//
//  LoginViewController.h
//  DLZProject
//
//  Created by ddllzz on 16/11/21.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "../../../Libs/BaseView/BaseViewController.h"

@class LoginViewModel;

@interface LoginViewController : BaseViewController{
    
    NSTimer *codeTimer;
    
    BOOL end;
    
}

@property (nonatomic,strong,readwrite) LoginViewModel *viewmodel;

//@property (weak, nonatomic) IBOutlet UIButton *uibtn;
//
//@property (weak, nonatomic) IBOutlet UITextField *uitxt;
//
//@property (weak, nonatomic) IBOutlet UILabel *uilab;
//

@property (weak, nonatomic) IBOutlet UIView *uipanel;

@property (weak, nonatomic) IBOutlet UIImageView *uilogo;

@property (weak, nonatomic) IBOutlet UILabel *lbpassword;

@property (weak, nonatomic) IBOutlet UILabel *lbcode;

@property (weak, nonatomic) IBOutlet UIImageView *lbpoint;

@property (weak, nonatomic) IBOutlet UIView *logincsp;

@property (weak, nonatomic) IBOutlet UIView *logincsc;

@property (weak, nonatomic) IBOutlet UIButton *btnpassword;

@property (weak, nonatomic) IBOutlet UITextField *txtusername;

@property (weak, nonatomic) IBOutlet UITextField *txtpassword;

@property (weak, nonatomic) IBOutlet UILabel *lbversion;

@property (weak, nonatomic) IBOutlet UITextField *txtphone;

@property (weak, nonatomic) IBOutlet UITextField *txtcode;

@property (weak, nonatomic) IBOutlet UIButton *btncode;

@property (weak, nonatomic) IBOutlet UIButton *btncodelogin;




@end
