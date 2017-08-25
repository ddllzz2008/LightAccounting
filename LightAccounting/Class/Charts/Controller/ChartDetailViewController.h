//
//  ChartViewDetailControllerViewController.h
//  LightAccounting
//
//  Created by ddllzz on 2017/8/22.
//  Copyright © 2017年 ddllzz. All rights reserved.
//
#import "UITableView+EmptyPhoto.h"
#import "NSDate+ExtMethod.h"
#import "BaseViewController.h"
#import "BillChartView.h"
#import "BillDetailView.h"
#import "BillTableCell.h"
#import "BillDetailSectionCell.h"
#import "BillDetailTableCell.h"
#import "TouchTableView.h"
#import "FilterUIView.h"
#import "ChartViewModel.h"
#import "AlertController.h"
#import "BusExpenditure.h"

@interface ChartDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,FilterUIViewDelegate,BillDetailViewDelegate,CAAnimationDelegate>{
    
    UILabel *choosedateview;
    
    UIView *viewright;
    
    UILabel *detailmoney;
    UITableView *righttableview;
    
    UIWindow *chooseWindow;
    FilterUIView *filterview;
    BillDetailView *detailview;
    
}

@property(nonatomic,strong) ChartViewModel *viewmodel;

@property (nonatomic,strong) NSArray *dateRange;

//@property(nonatomic,strong) NSDate *currentDate;

@end
