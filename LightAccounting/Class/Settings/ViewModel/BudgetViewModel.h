//
//  BudgetViewModel.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/14.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewModel.h"
#import "AppConfigurationModel.h"
#import "BusBudgetDAL.h"
#import "AppConfigurationDAL.h"
#import "ExpenditureDAL.h"
#import "NSString+ExtMethod.h"

@interface BudgetViewModel : BaseViewModel

@property (nonatomic,strong) NSArray *budgetArray;

@property (nonatomic,strong) NSString *currentYear;

@property (nonatomic,assign) NSString *billDate;

/**
 通过年份获取预算
 */
-(void)getBudgetsByYear;
/**
 设置预算
 
 @return <#return value description#>
 */
-(NSString *)setBudgetsByYear;
/**
 设置账单日
 
 @return <#return value description#>
 */
-(NSString *)setBillDate;

@end
