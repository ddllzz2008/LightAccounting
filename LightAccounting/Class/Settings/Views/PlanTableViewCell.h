//
//  PlanTableViewCell.h
//  LightAccounting
//
//  Created by ddllzz on 2017/5/8.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Style.h"
#import "BudgetTableViewCell.h"

@interface PlanTableViewCell : UITableViewCell{
    
    BudgetView *budget;
    
    UIImageView *categoryView;
    
    UILabel *categoryLabel;
    
    UILabel *planAccount;
    
    UILabel *planRemark;
    
    UIImageView *alertView;
    
}

@property (nonatomic,strong,readwrite) UIColor *headerColor;

@property (nonatomic,strong) UIImage *categoryImage;

@property (nonatomic,strong) NSString *categoryTtile;

@property (nonatomic,strong) NSString *accountString;

@property (nonatomic,strong) NSString *remarkString;

@property (nonatomic,assign) BOOL ifAlert;

@end
