//
//  AppConfigurationDAL.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/14.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppConfigurationModel.h"
#import "FmdbHelper.h"

@interface AppConfigurationDAL : NSObject

+(AppConfigurationDAL*)Instance;
/**
 更新账单日
 
 @param day <#day description#>
 @return <#return value description#>
 */
-(BOOL)updateBillDate:(int)day;
/**
 获取app配置信息
 
 @return <#return value description#>
 */
-(AppConfigurationModel *)getAppConfiguration;

@end
