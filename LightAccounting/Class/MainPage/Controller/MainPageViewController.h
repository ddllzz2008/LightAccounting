//
//  MainPageViewController.h
//  LightAccounting
//
//  Created by ddllzz on 17/3/19.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewController.h"
#import "MainPageView.h"
#import "MainPageViewModel.h"
#import "NewExpenditureViewController.h"
#import "Constants.h"

@interface MainPageViewController : BaseViewController

@property (nonatomic,readonly) MainPageViewModel *viewmodel;

@end
