//
//  BudgetViewController.h
//  LightAccounting
//
//  Created by ddllzz on 2017/4/25.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewController.h"
#import "AlertController.h"
#import "BillDateChooseView.h"
#import "BudgetTableViewCell.h"
#import "TouchTableView.h"
#import "BudgetViewModel.h"
#import "NSDate+ExtMethod.h"

@interface BudgetViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,TouchTableViewDelegate,UIViewControllerKeyboardDelegate,BillDateChooseDelegate>{
    
    BillDateChooseView *choosedateview;
    TouchTableView *tableview;
    
    
    NSDictionary *colorDictionary;
    NSArray *budgetarray;
    //更改账单日
    UIWindow *chooseWindow;
    UIView *accountView;
    UIView *rootview;
}

@property (nonatomic,strong) BudgetViewModel *viewmodel;

@end
