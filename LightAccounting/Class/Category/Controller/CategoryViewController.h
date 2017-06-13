//
//  CategoryViewController.h
//  LightAccounting
//
//  Created by ddllzz on 17/3/8.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewController.h"
#import "AlertController.h"
#import "NSDate+ExtMethod.h"
#import "CategoryTableCell.h"
#import "CategoryViewCell.h"
#import "CategoryViewModel.h"

@interface CategoryViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>{
    
    UICollectionView *_collectionView;
    
    UITableView *tableview;
    
    BOOL ifIncome;
    
    UITextField *textfield;
    //数据源
    NSMutableArray *categoryarray;
    
}

@property (nonatomic,strong) CategoryViewModel *viewmodel;

-(id)initWithType:(BOOL)ifIncome;

@end
