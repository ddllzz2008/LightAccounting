//
//  BudgetViewController.h
//  LightAccounting
//
//  Created by ddllzz on 2017/4/25.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewController.h"
#import "BudgetTableViewCell.h"
#import "TouchTableView.h"

@interface BudgetViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,TouchTableViewDelegate,UIViewControllerKeyboardDelegate>{
    
    TouchTableView *tableview;
    
    
    NSDictionary *colorDictionary;
}

@end
