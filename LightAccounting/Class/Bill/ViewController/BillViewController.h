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
#import "BillDetailViewController.h"

@interface BillViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    BillDateChooseView *choosedateview;
    
    UISegmentedControl *segmentControl;
    
    UILabel *totalmoney;
    
    UITableView *tableview;
    
}

@end
