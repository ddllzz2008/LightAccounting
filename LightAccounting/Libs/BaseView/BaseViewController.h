//
//  BaseViewController.h
//  DLZProject
//
//  Created by ddllzz on 16/11/22.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "FBKVOController.h"
#import "../../Protocol/BaseViewDelegate.h"
#import "BaseViewModel.h"

@class UserModel;

@interface BaseViewController : UIViewController<UITextFieldDelegate,AppdelegateKeyboardState>{
    @private UITextField *currentResponser;
    @private NSMutableArray *textfieldArray;
    @private FBKVOController *fbkvo;
}

@property (nonatomic,weak,readwrite) id<UIViewcontrollerArgument> argumentDelegate;

#pragma mark---UI模式
/*!
 *  @brief 初始化当前ViewController的viewmodel
 *
 *
 *  @since 1.0
 */
-(void)initWithViewModel;
/*!
 *  @brief 添加UIView约束
 *
 *  @since 1.0
 */
-(void)initContraints;
/*!
 *  @brief 初始化UIView样式
 *
 *  @since 1.0
 */
-(void)initViewStyle;
/*!
 *  @brief 初始化控件
 *
 *  @since 1.0
 */
-(void)initControls;
/*!
 *  @brief 添加观察者对象
 *
 *  @since 1.0
 */
-(void)addObservObject;

#pragma mark---UI相关
/*!
 *  @brief 隐藏工具栏
 *
 *  @since 1.0
 */
-(void)hiddenTabbar;
/*!
 *  @brief 显示工具栏
 *
 *  @since 1.0
 */
-(void)showTabbar;
/*!
 *  @brief 初始化要缩回的键盘集合
 *
 *
 *  @since 1.0
 */
/*!
 *
 *  @since 1.0
 */
-(void)hiddenNavigator;
/*!
 *  @brief 显示工具栏
 *
 *  @since 1.0
 */
-(void)showNavigator;

/**
 初始化要使用键盘的控件view

 @param views 可以弹出键盘的uiview
 */
-(void)initTextFieldArray:(UIView*)views,...;
/**
 关闭弹出键盘
 */
-(void)hiddenKeyBoard;
#pragma mark---用户相关
/*!
 *  @brief 获取当前登录用户
 *
 *  @return 登录用户
 *
 *  @since 1.0
 */
-(UserModel *)currentUser;

@end
