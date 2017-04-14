//
//  BaseTableViewController.h
//  DLZProject
//
//  Created by ddllzz on 16/12/12.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "FBKVOController.h"
#import "../../Protocol/BaseViewDelegate.h"
#import "BaseViewModel.h"

@interface BaseTableViewController : UITableViewController<UITextFieldDelegate,AppdelegateKeyboardState>{
    @private UITextField *currentResponser;
    @private NSMutableArray *textfieldArray;
    @private FBKVOController *fbkvo;
}

@property (nonatomic,strong,readwrite) MBProgressHUD *hub;

@property (nonatomic,weak,readwrite) id<UIViewcontrollerArgument> argumentDelegate;

#pragma mark---UI模式
/*!
 *  @brief 初始化当前ViewController的viewmodel
 *
 *  @param viewModel 当前界面的viewmodel
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
 *  @param views 要添加的textfield集合
 *
 *  @since 1.0
 */
/*!
 *  @brief 隐藏工具栏
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

-(void)initTextFieldArray:(UIView*)views,...;

@end
