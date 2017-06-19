//
//  MainPageViewModel.h
//  LightAccounting
//
//  Created by ddllzz on 17/3/22.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExpenditureDAL.h"
#import "BusBudgetDAL.h"
#import "NSDate+ExtMethod.h"
#import "MainExpendModel.h"
#import "MTLJSONAdapter.h"

@interface MainPageViewModel : NSObject{
    
    NSDate *filterStartDate;
    NSDate *filterEndDate;
    NSString *filterCategoryID;
    NSString *filterMinExpend;
    NSString *filterMaxExpend;
    
}

/**
 初始化筛选参数

 @param start 开始日期
 @param end 结束日期
 @param categoryid 类别
 @param packageid 钱包
 @param minexpend 最小消费
 @param maxexpend 最大消费
 */
-(void)initFilters:(NSDate*)start end:(NSDate*)end categoryid:(NSString*)categoryid packageid:(NSString *)packageid minexpend:(NSString *)minexpend maxexpend:(NSString *)maxexpend;


/**
 加载数据

 @return 数据列表
 */
-(NSMutableArray *)loadData;
/**
 获取本月预算
 
 @return <#return value description#>
 */
-(CGFloat)getCurrentBudget;
/**
 更新消费记录照片

 @param eid 消费记录ID
 @param photo 照片名称
 */
-(void)updateExpendPhoto:(NSString *)eid photo:(NSString *)photo;

@end
