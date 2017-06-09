//
//  AccountChooseView.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/5.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Style.h"

@interface AccountChooseView : UIView{
    
    UIView *container;
    
    UIPanGestureRecognizer *panmove;
    
    bool uicanTouch;
    
}

@property (nonatomic,strong) NSString *selectedValue;

@property (nonatomic,strong) NSMutableArray *source;

@property (nonatomic,strong) UIColor *containerColor;

@property (nonatomic,strong) UIColor *textColor;

@property (nonatomic,assign) CGRect oriFrame;

@end
