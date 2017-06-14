//
//  BusBudgetDAL.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/14.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BusBudgetDAL.h"

@implementation BusBudgetDAL

static BusBudgetDAL *instance = nil;

+(BusBudgetDAL*)Instance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

/**
 获取预算列表
 
 @return <#return value description#>
 */
-(NSArray *)getBudgetInfos:(NSString *)year{
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM BUS_BUDGET WHERE BYEAR='%@'",year];
    NSMutableArray *array = [[FmdbHelper Instance] querySql:sql];
    NSArray *result = [MTLJSONAdapter modelsOfClass:[BusBudgetModel class] fromJSONArray:array error:nil];
    return result;
}

/**
 设置年度预算

 @param year <#year description#>
 @param source <#source description#>
 @return <#return value description#>
 */
-(BOOL)setBudgetInfos:(NSString *)year source:(NSArray *)source{
    
    NSArray *array = [self getBudgetInfos:year];
    
    NSMutableArray *mutableArray = [[NSMutableArray alloc] initWithCapacity:12];
    
    if (array!=nil &&array.count>0) {
        //存在当前的预算，修改
        for (BusBudgetModel *model in source) {
            NSString *sql = [NSString stringWithFormat:@"UPDATE BUS_BUDGET SET BVALUE=%lf WHERE BYEAR='%@' AND BMONTH='%@'",model.BVALUE,year,model.BMONTH];
            [mutableArray addObject:sql];
        }
        
    }else{
        //不存在当前的预算，新增
        for (BusBudgetModel *model in source) {
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO BUS_BUDGET(BYEAR,BMONTH,BVALUE) VALUES('%@','%@',%lf)",year,model.BMONTH,model.BVALUE];
            [mutableArray addObject:sql];
        }
    }
    
    BOOL result = [[FmdbHelper Instance] executeSqlWithTransaction:mutableArray];
    
    return result;
    
}

/**
 获取当月预算
 
 @return <#return value description#>
 */
-(CGFloat)getBudgetInfo:(NSString *)year month:(NSString *)month{
    NSString *sql = [NSString stringWithFormat:@"SELECT BVALUE FROM BUS_BUDGET WHERE BYEAR='%@' AND BMONTH='%@'",year,month];
    NSMutableArray *array = [[FmdbHelper Instance] querySql:sql];
    NSArray *result = [MTLJSONAdapter modelsOfClass:[BusBudgetModel class] fromJSONArray:array error:nil];
    if (result!=nil &&result.count>0) {
        return [[result objectAtIndex:0] floatValue];
    }else{
        return 0.0f;
    }
}

@end
