//
//  AccountChooseView.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/5.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Style.h"
#import "FamilyPerson.h"

@protocol AccountChooseViewDelegate <NSObject>

@optional
-(void)AccountChooseView:(id)sender didSelectedChanged:(FamilyPerson *)person;

@end

@interface AccountChooseView : UIView{
    
    UIView *container;
    
    UIPanGestureRecognizer *panmove;
    
    bool uicanTouch;
    
}

@property (nonatomic,strong) FamilyPerson *selectedValue;

@property (nonatomic,strong) NSArray *source;

@property (nonatomic,strong) UIColor *containerColor;

@property (nonatomic,strong) UIColor *textColor;

@property (nonatomic,assign) CGRect oriFrame;

@property (nonatomic,weak) id<AccountChooseViewDelegate> delegate;

@end
