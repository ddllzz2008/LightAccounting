//
//  BillViewController.h
//  LightAccounting
//
//  Created by ddllzz on 17/4/11.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "UITableView+EmptyPhoto.h"
#import "BaseViewController.h"
#import "BillDateChooseView.h"
#import "BillChartView.h"
#import "BillTableCell.h"
#import "BillDetailSectionCell.h"
#import "BillDetailTableCell.h"
#import "TouchTableView.h"
#import "FilterUIView.h"
#import "BillViewModel.h"
#import "BillDetailView.h"
#import "AlertController.h"
#import "BusExpenditure.h"

@interface BillViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,BillDateChooseDelegate,FilterUIViewDelegate,TouchTableViewDelegate,BillDetailViewDelegate,CAAnimationDelegate>{
    
    NSDate *currentDate;
    
    BillDateChooseView *choosedateview;
    
    BillChartView *chartview;
    
    UISegmentedControl *segmentControl;
    
    UILabel *totalmoney;
    
    TouchTableView *lefttableview;
    
    UIView *viewleft;
    UIView *viewright;
    
    UILabel *detailmoney;
    TouchTableView *righttableview;
    
    UIWindow *chooseWindow;
    FilterUIView *filterview;
    BillDetailView *detailview;
    
    //最后滑动的方向
    int lastdirection;
    BOOL isscroll;
    
}

@property (nonatomic,strong) BillViewModel *viewmodel;

@end
