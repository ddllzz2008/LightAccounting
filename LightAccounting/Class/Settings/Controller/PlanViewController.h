//
//  PlanViewController.h
//  LightAccounting
//
//  Created by ddllzz on 2017/4/28.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewController.h"
#import "PlanView.h"
#import "NSDate+ExtMethod.h"
#import "NewPlanViewController.h"
#import "PlanTableViewCell.h"

@interface PlanViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    UITableView *tableview;
    
    PlanView *planview;
    
    //滚动监听
    CGFloat lasty;
    
    CGFloat planviewHeight;
    
}

@end
