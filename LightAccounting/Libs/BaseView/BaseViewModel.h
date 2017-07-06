//
//  BaseViewModel.h
//  DLZProject
//
//  Created by ddllzz on 16/11/22.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+ExtMethod.h"
#import "NSString+ExtMethod.h"
#import "AppConfigurationDAL.h"
#import "AppConfigurationModel.h"
#import "FamilyPerson.h"
#import "FamilyPersonDAL.h"
#import "AlertController.h"

@interface BaseViewModel : NSObject

/**
 获取账本列表
 
 @return <#return value description#>
 */
-(NSArray *)getFamilyAccounts;
/**
 获取默认账本
 
 @return <#return value description#>
 */
-(FamilyPerson *)getDefaultFamily;

/**
 设置默认账本
 
 @param familyid <#familyid description#>
 @return <#return value description#>
 */
-(BOOL)setDefaultFamily:(NSString *)familyid;

/**
 获取月账单范围
 
 @param currentDate 当前日期
 @return 起始日期
 */
-(NSArray<NSDate *> *)getBillDateRange:(NSDate *)currentDate;

/**
 封装基于GCD的线程操作
 
 @param loadingtitle 加载提示
 @param successtitle 成功提示
 @param errortitle 成功提示
 @param threadaction 子线程操作
 @param mainuiaction UI主线程操作
 */
- (void)runThreadAction:(NSString * __nullable)loadingtitle successtitle:(NSString * __nullable)successtitle errortitle:(NSString * __nullable)errortitle threadaction:(BOOL (^_Nullable)())threadaction mainuiaction:(void (^_Nullable)(BOOL))mainuiaction;

@end
