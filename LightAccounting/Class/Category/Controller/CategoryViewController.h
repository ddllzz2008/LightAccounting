//
//  CategoryViewController.h
//  LightAccounting
//
//  Created by ddllzz on 17/3/8.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewController.h"
#import "CategoryTableCell.h"
#import "CategoryViewCell.h"

@interface CategoryViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>{
    
    BOOL ifIncome;
    
    
    UITextField *textfield;
}

-(id)initWithType:(BOOL)ifIncome;

@end
