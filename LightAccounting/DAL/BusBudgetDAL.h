//
//  BusBudgetDAL.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/14.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusBudgetModel.h"
#import "FmdbHelper.h"

@interface BusBudgetDAL : NSObject

+(BusBudgetDAL*)Instance;

/**
 获取预算列表
 
 @return <#return value description#>
 */
-(NSArray *)getBudgetInfos:(NSString *)year;

/**
 设置年度预算
 
 @param year <#year description#>
 @param source <#source description#>
 @return <#return value description#>
 */
-(BOOL)setBudgetInfos:(NSString *)year source:(NSArray *)source;
/**
 获取当月预算
 
 @return <#return value description#>
 */
-(CGFloat)getBudgetInfo:(NSString *)year month:(NSString *)month;

@end
