//
//  IncomeDAL.h
//  HomeAPP
//
//  Created by ddllzz on 16/4/29.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BusIncome.h"
#import "FmdbHelper.h"
#import "NSString+ExtMethod.h"
#import "SpendDetail.h"
#import "NSDate+ExtMethod.h"
#import "NewExpendModel.h"
#import "FamilyPerson.h"

@interface IncomeDAL : NSObject

+(IncomeDAL*)Instance;

/*
 *---------------------------插入收入---------------------------------------------*
 */
-(BOOL)addIncome:(NewExpendModel *)model;
/*
 *---------------------------修改收入---------------------------------------------*
 */
-(BOOL)updateIncome:(NSString *)eid evalue:(double)evalue oldvalue:(double)oldvalue cid:(NSString *)cid fid:(NSString *)fid pid:(NSString *)pid createtime:(NSString *)createtime eyear:(NSString *)eyear emonth:(NSString *)emonth eday:(NSString *)eday imark:(NSString *)imark;
/*
 *-----------获取收入汇总-------------*
 */
-(NSDictionary*)getTotal:(NSString*)cid start:(NSDate*)start end:(NSDate*)end;
/**
 获取年度收入汇总
 
 @param year <#year description#>
 @param categoryids <#categoryids description#>
 @param minspend <#minspend description#>
 @param maxspend <#maxspend description#>
 @param outlet <#outlet description#>
 @param isprivate <#isprivate description#>
 @return <#return value description#>
 */
-(NSArray *)getIncomeByYear:(NSString *)year categoryid:(NSArray<NSString *>*)categoryids minspend:(NSString*)minspend maxspend:(NSString*)maxspend isprivate:(BOOL)isprivate;
/*
 *---------------------------获取收入详细信息---------------------------------------------*
 */
-(NSMutableArray*)getIncomeDetail:(NSString*)cid sort:(NSInteger)sort start:(NSDate*)start end:(NSDate*)end;

/*
 *-----------获取支出详细-------------*
 */
-(BusIncome*)getIncomeDetail:(NSString*)iid;

/*
 *---------------------------删除收入---------------------------------------------*
 */
-(BOOL)deleteIncome:(NSString *)eid pid:(NSString*)pid evalue:(double)evalue;
/*
 *---------------------------获取消费汇总---------------------------------------------*
 */
-(NSMutableArray*)SelectIncome:(NSDate*)start end:(NSDate*)end;

@end
