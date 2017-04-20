//
//  BaseViewController.m
//  DLZProject
//
//  Created by ddllzz on 16/11/22.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginModel.h"
#import "ArchiverCache.h"

@interface BaseViewController (){
    
    BOOL keyboardIsShow;
    
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    keyboardIsShow = NO;
    
    fbkvo = [FBKVOController controllerWithObserver:self];
    
    [self initControls];
    
    [self initViewStyle];
    
    [self initContraints];
    
    [self initWithViewModel];
    
    [self addObservObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    if (fbkvo!=nil) {
        [fbkvo unobserveAll];
    }
    fbkvo = nil;
    currentResponser = nil;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (textfieldArray.count>0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    DDLogDebug(@"baseviewcontroller被挂起");
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super viewWillDisappear:animated];
    
}

-(void)dealloc{
//    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark---UI模式
/*!
 *  @brief 初始化当前ViewController的viewmodel
 *
 *
 *  @since 1.0
 */
-(void)initWithViewModel{}
/*!
 *  @brief 添加UIView约束
 *
 *  @since 1.0
 */
-(void)initContraints{}
/*!
 *  @brief 初始化UIView样式
 *
 *  @since 1.0
 */
-(void)initViewStyle{}
/*!
 *  @brief 初始化控件
 *
 *  @since 1.0
 */
-(void)initControls{}
/*!
 *  @brief 添加观察者对象
 *
 *  @since 1.0
 */
-(void)addObservObject{}

#pragma mark---UI相关
/*!
 *  @brief 隐藏工具栏
 *
 *  @since 1.0
 */
-(void)hiddenTabbar{
    [self.tabBarController.tabBar setHidden:YES];
    self.tabBarController.tabBar.bounds = CGRectMake(0, 0, ScreenSize.width, 0);
}
/*!
 *  @brief 显示工具栏
 *
 *  @since 1.0
 */
-(void)showTabbar{
    [self.tabBarController.tabBar setHidden:NO];
    self.tabBarController.tabBar.bounds = CGRectMake(0, 0, ScreenSize.width, 49);
}
/*!
 *  @brief 隐藏工具栏
 *
 *  @since 1.0
 */
-(void)hiddenNavigator{
    [self.navigationController setNavigationBarHidden:YES];
}
/*!
 *  @brief 显示工具栏
 *
 *  @since 1.0
 */
-(void)showNavigator{
    [self.navigationController setNavigationBarHidden:NO];
}
#pragma mark---键盘操作
/*!
 *  @brief 初始化要缩回的键盘集合
 *
 *  @param views 要添加的textfield集合
 *
 *  @since 1.0
 */
-(void)initTextFieldArray:(UIView*)views, ...{
    textfieldArray = [[NSMutableArray alloc] init];
    
    if ([views isKindOfClass:[UITextField class]]) {
        [textfieldArray addObject:views];
        ((UITextField *)views).delegate=self;
    }
    
    UIView *v;
    va_list arg_list;
    va_start(arg_list, views);
    while ((v = va_arg(arg_list, UIView *))) {
        if (v==nil) {
            continue;
        }
        if ([v isKindOfClass:[UITextField class]]) {
            [textfieldArray addObject:v];
            ((UITextField *)v).delegate=self;
        }
    }
    va_end(arg_list);
}
/*!
 *  @brief 按下返回键
 *
 *  @param textField 当前响应键盘
 *
 *  @return 是否执行成功
 *
 *  @since 1.0
 */
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
/*!
 *  @brief 屏幕触摸
 *
 *  @param touches 触摸点集合
 *  @param event   事件
 *
 *  @since 1.0
 */
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (keyboardIsShow) {
        if (textfieldArray!=nil) {
            for (UIView* textfield in textfieldArray) {
                [textfield resignFirstResponder];
            }
        }
    }
}

/**
 关闭弹出键盘
 */
-(void)hiddenKeyBoard{
    if (keyboardIsShow) {
        if (textfieldArray!=nil) {
            for (UIView* textfield in textfieldArray) {
                [textfield resignFirstResponder];
            }
            
            UIWindow *currentWindow = [[UIApplication sharedApplication] keyWindow];
            currentWindow.frame=[[UIScreen mainScreen] bounds];
            
            keyboardIsShow =NO;
        }
    }
}
/*!
 *  @brief 文本框获取焦点
 *
 *  @param textField 当前响应文本狂
 *
 *  @return 是否响应成功
 *
 *  @since 1.0
 */
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    currentResponser = textField;
    return YES;
}
/*!
 *  @brief 键盘显示
 *
 *  @param sender 通知
 *
 *  @since 1.0
 */
-(void)keyboardWillShow:(NSNotification *)sender{
    NSDictionary *userInfo = [sender userInfo];
    
    // Get the origin of the keyboard when it's displayed.
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    
    CGRect keyboardRect = [aValue CGRectValue];
    
    [self keyboardStateChanged:YES view:currentResponser rect:keyboardRect];
}
/*!
 *  @brief 键盘隐藏
 *
 *  @param sender 通知
 *
 *  @since 1.0
 */
-(void)keyboardWillHidden:(NSNotification *)sender{
    [self keyboardStateChanged:NO view:currentResponser rect:CGRectMake(0, 0, 0, 0)];
}
/*!
 *  @brief 键盘状态更回调
 *
 *  @param ishow 显示：YES，隐藏：NO
 *  @param view  当前相应键盘的文本域
 *  @param rect  keyboard弹起的矩形区域
 *
 *  @since 1.0
 */
-(void)keyboardStateChanged:(BOOL)ishow view:(UIView *)view rect:(CGRect)rect{
    if (view!=nil) {
        if (ishow) {
            
            UIWindow *currentWindow = [[UIApplication sharedApplication] keyWindow];
//            UIView *superView = [view superview];
            CGPoint originSuper = [currentWindow convertPoint:CGPointZero fromView:view];
            
            double restHeight = currentWindow.frame.size.height - originSuper.y - view.bounds.size.height;
            
            if (rect.size.height > restHeight) {
                
//                double navbarheight = 0;
//                
//                if(self.navigationController!=nil && self.navigationController.navigationBar!=nil){
//                    navbarheight = self.navigationController.navigationBar.frame.size.height;
//                }
//                self.view.frame=CGRectMake(0,0 - rect.size.height + navbarheight, self.view.frame.size.width, self.view.frame.size.height);
                
                currentWindow.frame=CGRectMake(0, 0 - rect.size.height + restHeight, currentWindow.frame.size.width, currentWindow.frame.size.height);
                
                
            }
            
            keyboardIsShow = YES;
            
        }else{
            
//            double navbarheight = 0;
//            
//            if(self.navigationController!=nil && self.navigationController.navigationBar!=nil){
//                navbarheight = self.navigationController.navigationBar.frame.size.height;
//            }
            
            UIWindow *currentWindow = [[UIApplication sharedApplication] keyWindow];
            currentWindow.frame=[[UIScreen mainScreen] bounds];
            
            keyboardIsShow =NO;
//            self.view.frame=CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height + navbarheight);
        }
    }
}

#pragma mark---用户相关
/*!
 *  @brief 获取当前登录用户
 *
 *  @return 登录用户
 *
 *  @since 1.0
 */
-(UserModel *)currentUser{
    UserModel *model = [ArchiverCache getFromFile:CACHE_LOGINMODEL];
    return model;
}

@end
