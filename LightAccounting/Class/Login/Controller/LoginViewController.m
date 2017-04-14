//
//  LoginViewController.m
//  DLZProject
//
//  Created by ddllzz on 16/11/21.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "AlertController.h"
#import "DLZAlertView.h"
#import "AppDelegate.h"
#import "NSString+ExtMethod.h"

#import "MainTabController.h"
#import "LeftMenuController.h"
#import "MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"

@interface LoginViewController(){
    
    void (^ponitLeftConstant)(MASConstraintMaker *make);
    void (^ponitRightConstant)(MASConstraintMaker *make);
    
}

@end

@implementation LoginViewController


-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self hiddenNavigator];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self hiddenNavigator];
}

-(void)initViewStyle{
    self.uipanel.backgroundColor = UIColorFromRGB(color_blue_01);
    self.btnpassword.backgroundColor = UIColorFromRGB(color_blue_01);
    self.btncodelogin.backgroundColor = UIColorFromRGB(color_blue_01);
    self.lbversion.textColor = UIColorFromRGB(color_gray_02);
    
    [self.btncode.layer setBorderWidth:1];
    [self.btncode.layer setBorderColor:UIColorFromRGB(color_blue_01).CGColor];
    [self.btncode setTitleColor:UIColorFromRGB(color_blue_01) forState:UIControlStateNormal];
}

-(void)initContraints{
    
    self.lbcode.translatesAutoresizingMaskIntoConstraints = NO;
    self.lbpoint.translatesAutoresizingMaskIntoConstraints = NO;
    
    __weak typeof(self) weakself = self;
    
    [self.uipanel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(weakself.view);
        make.height.equalTo(@240);
    }];
    
    [self.uilogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.uipanel);
        make.centerY.equalTo(weakself.uipanel);
    }];
    
    [self.logincsp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.uipanel.mas_bottom);
    }];
    
    
    ponitLeftConstant = ^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.lbpassword);
    };
    
    ponitRightConstant = ^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.lbcode);
    };
    
    [self.lbpoint mas_makeConstraints:ponitLeftConstant];
    
}

-(void)initControls{
    UITapGestureRecognizer *tapleftType = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginTypeChanged:)];
    UITapGestureRecognizer *taprightType = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginTypeChanged:)];
    
    self.lbpassword.userInteractionEnabled = YES;
    [self.lbpassword addGestureRecognizer:tapleftType];
    self.lbpassword.tag = 0;
    
    self.lbcode.userInteractionEnabled = YES;
    [self.lbcode addGestureRecognizer:taprightType];
    self.lbcode.tag = 1;
    
    [self initTextFieldArray:self.txtusername,self.txtpassword,self.txtcode,self.txtphone,nil];
}

-(void)initWithViewModel{
    self.viewmodel = [LoginViewModel new];
    RAC(self.logincsp,alpha) = [RACObserve(self.viewmodel, loginType) map:^id(NSNumber *value) {
        return value.intValue ==0 ? @1.0 : @0.0;
    }];
    RAC(self.logincsc,alpha) = [RACObserve(self.viewmodel, loginType) map:^id(NSNumber *value) {
        return value.intValue ==1 ? @1.0 : @0.0;
    }];
    RAC(self.viewmodel,telphone) = self.txtphone.rac_textSignal;
    RAC(self.viewmodel,telcode) = self.txtcode.rac_textSignal;
    RAC(self.viewmodel,userName) = self.txtusername.rac_textSignal;
    RAC(self.txtusername,text) = RACObserve(self.viewmodel, userName);
    RAC(self.viewmodel,userpassword) = self.txtpassword.rac_textSignal;
    
    self.btncode.rac_command = self.viewmodel.getCodeCommand;
    [self.btncode.rac_command.executing subscribeNext:^(id x) {
        
    }];
    [self.btncode.rac_command.executionSignals.flatten subscribeNext:^(id x) {
        if ([x isEqualToString:REQUEST_START]) {
            [self.btncode.layer setBorderColor:UIColorFromRGB(color_gray_01).CGColor];
            [self.btncode setTitleColor:UIColorFromRGB(color_gray_01) forState:UIControlStateNormal];
            
            self.viewmodel.codeGetTime = 60;
            codeTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(codeTimeCount) userInfo:nil repeats:YES];
            [codeTimer fire];
            
        }else if([x isEqualToString:REQUEST_END]){
        }else{
            [[AlertController sharedInstance] showMessageAutoClose:x];
        }
    }];
    self.btnpassword.rac_command = self.viewmodel.loginCommand;
//    [self.btnpassword.rac_command.executing subscribeNext:^(id x) {
//        if ([x intValue]==1) {
//            
//        }
//    }];
    [[self.btnpassword.rac_command.executionSignals flatten] subscribeNext:^(id x) {
        
        if ([x isEqualToString:REQUEST_START]) {
            [[AlertController sharedInstance] showMessage:@"登录中..."];
        }
        else if ([x isEqualToString:REQUEST_ASYNC]){
            [[AlertController sharedInstance] showMessage:@"下载数据..."];
        }
        else if ([x isEqualToString:REQUEST_ERROR]){
            [[AlertController sharedInstance] showMessageAutoClose:@"数据下载失败..."];
        }
        else if([x isEqualToString:REQUEST_SUCCESS]){
            
            [[AlertController sharedInstance] closeMessage];
            
            LeftMenuController *menuController = [[LeftMenuController alloc] init];
            MainTabController *tabController = [[MainTabController alloc] init];
    
            UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:tabController];
            UINavigationController * sideNavController = [[UINavigationController alloc] initWithRootViewController:menuController];
    
            [navigationController.navigationBar setTintColor:UIColorFromRGB(color_white_01)];
            [navigationController.navigationBar setBarTintColor:UIColorFromRGB(color_navigation_bar)];
    
    
            MMDrawerController *sideController = [[MMDrawerController alloc] initWithCenterViewController:navigationController leftDrawerViewController:sideNavController];
    
            [sideController setShowsShadow:NO];
            [sideController setRestorationIdentifier:@"MMDrawer"];
            [sideController setMaximumRightDrawerWidth:200.0];
            [sideController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
            [sideController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
            
            [self.navigationController pushViewController:sideController animated:NO];
            
        }else if (![x isBlankString]){
            [[AlertController sharedInstance] closeMessage];
            [DLZAlertView showAlertMessage:self title:@"提示" content:x];
        }
        else{
            [[AlertController sharedInstance] showMessageAutoClose:x];
        }
    }];
    
//    [self.btnpassword.rac_command.executionSignals.flatten subscribeNext:^(id x) {
//        if([x isEqualToString:REQUEST_END]){
//            
//        }else if (![x isBlankString]){
//            [DLZAlertView showAlertMessage:self title:@"提示" content:x];
//        }
//        else{
//            [[AlertController sharedInstance] showMessageAutoClose:self.view message:x];
//        }
//    }];
    
    [self.viewmodel loadLoginModel];
}

#pragma mark---UI互动方法
-(void)loginTypeChanged:(UITapGestureRecognizer *)tap{
    
    if (tap.view.tag==0) {
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath=@"transform.translation.x";
        animation.fromValue=[NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width/2];
        animation.toValue=@1.0f;
        animation.repeatCount=1;
        animation.removedOnCompletion=NO;
        animation.fillMode=kCAFillModeForwards;
        animation.duration=0.2f;
        
        [self.lbpoint.layer addAnimation:animation forKey:@"Animation"];
        
        [self.viewmodel setLoginType:0];
    }else{
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath=@"transform.translation.x";
        animation.fromValue=@1.0f;
        animation.toValue=[NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width/2];
        animation.repeatCount=1;
        animation.removedOnCompletion=NO;
        animation.fillMode=kCAFillModeForwards;
        animation.duration=0.2f;
        
        [self.lbpoint.layer addAnimation:animation forKey:@"Animation"];
        
        [self.viewmodel setLoginType:1];
    }
    [super updateViewConstraints];
    
}

-(void)codeTimeCount{
    if(self.viewmodel.codeGetTime==0){
        if(codeTimer!=nil){
            [codeTimer invalidate];
            codeTimer = nil;
        }
        [self.btncode.layer setBorderColor:UIColorFromRGB(color_blue_01).CGColor];
        [self.btncode setTitleColor:UIColorFromRGB(color_blue_01) forState:UIControlStateNormal];
        [self.btncode setTitle:@"获取验证码" forState:UIControlStateNormal];
    }else{
        self.viewmodel.codeGetTime--;
        [self.btncode setTitle:[NSString stringWithFormat:@"%ld秒后重新获取",self.viewmodel.codeGetTime] forState:UIControlStateNormal];
    }
}

@end
