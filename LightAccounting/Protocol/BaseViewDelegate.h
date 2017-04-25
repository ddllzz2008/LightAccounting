//
//  BaseViewDelegate.h
//  DLZProject
//
//  Created by ddllzz on 16/11/22.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AppdelegateKeyboardState

@optional
-(void)keyboardWillShow:(NSNotification *)sender;
@optional
-(void)keyboardWillHidden:(NSNotification *)sender;

@end

@protocol UIViewcontrollerArgument

@optional
-(void)receiveDataFromViewController:(UIViewController *)controller argument:(id)argument;

@end

@protocol UIViewControllerKeyboardDelegate

@optional
-(void)viewcontrollerKeyboardChanged:(CGRect)rect ifshow:(BOOL)ifshow;

@end
