//
//  AppConfigurationDAL.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/14.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "AppConfigurationDAL.h"

@implementation AppConfigurationDAL

static AppConfigurationDAL *instance = nil;

+(AppConfigurationDAL*)Instance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

/**
 更新账单日

 @param day <#day description#>
 @return <#return value description#>
 */
-(BOOL)updateBillDate:(int)day{
    
    NSString *sqlupdate = [NSString stringWithFormat:@"UPDATE APP_CONFIGURATION SET BILLDATE=%d",day];
    
    BOOL result = [[FmdbHelper Instance] executeSql:sqlupdate];
    
    return result;
    
}

/**
 获取app配置信息

 @return <#return value description#>
 */
-(AppConfigurationModel *)getAppConfiguration{
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM APP_CONFIGURATION"];
    NSMutableArray *array = [[FmdbHelper Instance] querySql:sql];
    NSArray *result = [MTLJSONAdapter modelsOfClass:[AppConfigurationModel class] fromJSONArray:array error:nil];
    if (result!=nil &&result.count>0) {
        return [result objectAtIndex:0];
    }else{
        return nil;
    }
}

@end
