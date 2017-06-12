//
//  ExpendViewModel.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/5.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewModel.h"
#import "NSString+ExtMethod.h"
#import "NewExpendModel.h"
#import "IncomeDAL.h"
#import "ExpenditureDAL.h"
#import "CategoryDAL.h"

@interface ExpendViewModel : BaseViewModel

@property (nonatomic,strong) NewExpendModel *model;

/**
 检查收入数据合法性
 
 @return <#return value description#>
 */
-(NSString *)checkIncomeData;

/**
 检查支出数据合法性
 
 @return <#return value description#>
 */
-(NSString *)checkExpendData;

/**
 保存收入
 
 @return <#return value description#>
 */
-(BOOL)saveIncome;

/**
 保存支出
 
 @return <#return value description#>
 */
-(BOOL)saveExpend;
/**
 获取收入类别
 type：0--支出，1--收入
 @return <#return value description#>
 */
-(NSMutableArray *)getIncomeCategory;
/**
 获取支出类别
 type：0--支出，1--收入
 @return <#return value description#>
 */
-(NSMutableArray *)getExpendCategory;
    
@end
