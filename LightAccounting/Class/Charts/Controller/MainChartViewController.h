//
//  MainChartViewController.h
//  LightAccounting
//
//  Created by ddllzz on 2017/8/15.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ChartsMainView.h"
#import "FilterUIView.h"
#import "ChartViewModel.h"
#import "ChartDetailViewController.h"

@interface MainChartViewController : BaseViewController<FilterUIViewDelegate,UIWebViewDelegate>{
    
    ChartsMainView *chartview;
    
    UIWindow *chooseWindow;
    UIWindow *chooseWindow1;
    FilterUIView *filterview;
    
}

@property (nonatomic,strong) ChartViewModel *viewmodel;

@end
