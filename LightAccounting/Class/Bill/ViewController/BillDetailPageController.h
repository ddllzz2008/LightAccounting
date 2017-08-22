//
//  BillDetailViewController.h
//  LightAccounting
//
//  Created by ddllzz on 2017/4/19.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "UITableView+EmptyPhoto.h"
#import "BaseViewController.h"
#import "BillDateChooseView.h"
#import "BillChartView.h"
#import "BillDetailView.h"
#import "BillTableCell.h"
#import "BillDetailSectionCell.h"
#import "BillDetailTableCell.h"
#import "TouchTableView.h"
#import "FilterUIView.h"
#import "BillViewModel.h"
#import "AlertController.h"
#import "BusExpenditure.h"

@interface BillDetailPageController : BaseViewController<UITableViewDelegate,UITableViewDataSource,BillDateChooseDelegate,FilterUIViewDelegate,BillDetailViewDelegate,CAAnimationDelegate>{
    
    BillDateChooseView *choosedateview;
    
    UIView *viewright;
    
    UILabel *detailmoney;
    UITableView *righttableview;
    
    UIWindow *chooseWindow;
    FilterUIView *filterview;
    BillDetailView *detailview;
    
}

@property(nonatomic,strong) BillViewModel *viewmodel;

@property(nonatomic,strong) NSDate *currentDate;

@end
