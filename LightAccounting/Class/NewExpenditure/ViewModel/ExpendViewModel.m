//
//  ExpendViewModel.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/5.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "ExpendViewModel.h"

@implementation ExpendViewModel


/**
 检查收入数据合法性

 @return <#return value description#>
 */
-(NSString *)checkIncomeData{
    return @"保存失败";
}

/**
 检查支出数据合法性

 @return <#return value description#>
 */
-(NSString *)checkExpendData{
    return @"保存失败";
}

/**
 保存收入

 @return <#return value description#>
 */
-(BOOL)saveIncome{
    return YES;
}

/**
 保存支出

 @return <#return value description#>
 */
-(BOOL)saveExpend{
    return YES;
}

@end
