//
//  BaseTableViewController.m
//  DLZProject
//
//  Created by ddllzz on 16/12/12.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "BaseTableViewController.h"

@implementation BaseTableViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    fbkvo = [FBKVOController controllerWithObserver:self];
    
    [self initControls];
    
    [self initViewStyle];
    
    [self initContraints];
    
    [self initWithViewModel];
    
    [self addObservObject];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    self.hub = nil;
    if (fbkvo!=nil) {
        [fbkvo unobserveAll];
    }
    fbkvo = nil;
    currentResponser = nil;
}
-(void)viewWillDisappear:(BOOL)animated{
    DDLogDebug(@"baseviewcontroller被挂起");
    
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark---UI模式
/*!
 *  @brief 初始化当前ViewController的viewmodel
 *
 *  @param viewModel 当前界面的viewmodel
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
    
    if (textfieldArray.count>0) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHidden:) name:UIKeyboardWillHideNotification object:nil];
    }
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
    if (textfieldArray!=nil) {
        for (UIView* textfield in textfieldArray) {
            [textfield resignFirstResponder];
        }
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
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
            //            UIView *superView = [view superview];
            CGPoint originSuper = [self.view convertPoint:CGPointZero fromView:view];
            if (rect.size.height + originSuper.y + view.bounds.size.height > ScreenSize.height) {
                self.view.frame=CGRectMake(0,0 - rect.size.height, self.view.frame.size.width, self.view.frame.size.height);
            }
        }else{
            self.view.frame=CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
        }
    }
}

@end
