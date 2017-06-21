//
//  BillDetailViewController.h
//  LightAccounting
//
//  Created by ddllzz on 2017/4/19.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewController.h"
#import "BillDateChooseView.h"
#import "BillDetailTableCell.h"
#import "BillDetailSectionCell.h"
#import "BillViewModel.h"

@interface BillDetailViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>{
    
    BillDateChooseView *choosedateview;
    UILabel *totalmoney;
    
}

@property(nonatomic,strong) BillViewModel *viewmodel;

@property(nonatomic,strong) NSDate *currentDate;

@end
