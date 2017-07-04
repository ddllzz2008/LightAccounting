//
//  BillViewController.h
//  LightAccounting
//
//  Created by ddllzz on 17/4/11.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewController.h"
#import "BillDateChooseView.h"
#import "BillChartView.h"
#import "BillTableCell.h"
#import "BillDetailSectionCell.h"
#import "BillDetailTableCell.h"
#import "FilterUIView.h"
#import "BillViewModel.h"
#import "AlertController.h"
#import "BusExpenditure.h"

@interface BillViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,BillDateChooseDelegate,FilterUIViewDelegate>{
    
    BillDateChooseView *choosedateview;
    
    UISegmentedControl *segmentControl;
    
    UILabel *totalmoney;
    
    UITableView *lefttableview;
    
    UIView *viewleft;
    UIView *viewright;
    
    UILabel *detailmoney;
    UITableView *righttableview;
    
    UIWindow *chooseWindow;
    FilterUIView *filterview;
    
    //最后滑动的方向
    int lastdirection;
    BOOL isscroll;
    
}

@property (nonatomic,strong) BillViewModel *viewmodel;

@end
