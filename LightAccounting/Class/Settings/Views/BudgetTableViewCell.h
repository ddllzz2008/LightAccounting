//
//  BudgetTableViewCell.h
//  LightAccounting
//
//  Created by ddllzz on 2017/4/25.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Style.h"

@interface BudgetView : UIView

@property (nonatomic,strong,readwrite) UIColor *headerColor;

@end

@interface BudgetTableViewCell : UITableViewCell{
    
    BudgetView *budget;
    
    UIButton *month;
    
    UILabel *actualLabel;
    
    UILabel *budgetLabel;
    
    UILabel *actualNumber;
    
    UILabel *budgetNumber;
    
}

@property (nonatomic,strong,readwrite) UIColor *headerColor;

@property (nonatomic,strong,readwrite) UITextField *inputmoney;

@property (nonatomic,strong,readwrite) NSString *title;

@property (nonatomic,assign,readwrite) double actualValue;

@property (nonatomic,assign,readwrite) double budgetValue;

@end
