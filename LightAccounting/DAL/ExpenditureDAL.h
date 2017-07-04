//
//  ExpenditureDAL.h
//  HomeAPP
//
//  Created by ddllzz on 16/4/21.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FmdbHelper.h"
#import "SpendDetail.h"
#import "BusExpenditure.h"
#import "NSString+ExtMethod.h"
#import "NSDate+ExtMethod.h"
#import "NewExpendModel.h"
#import "FamilyPerson.h"
#import "FamilyPersonDAL.h"

@interface ExpenditureDAL : NSObject

+(ExpenditureDAL*)Instance;

/**
 获取消费列表
 
 @param start 开始时间
 @param end 结束时间
 @param categoryid 类别
 @param minspend 最低消费
 @param maxspend 最高消费
 @return 消费列表
 */
-(NSArray *)getExpenditure:(NSDate*)start end:(NSDate *)end categoryid:(NSString *)categoryid minspend:(NSString*)minspend maxspend:(NSString*)maxspend;
/**
 获取消费明细
 
 @param start 开始时间
 @param end 结束时间
 @param categoryids 类别ID
 @param minspend 最低消费
 @param maxspend 最大消费
 @return 消费汇总
 */
-(NSArray *)getAccountDetail:(NSDate*)start end:(NSDate *)end categoryid:(NSArray<NSString *>*)categoryids minspend:(NSString*)minspend maxspend:(NSString*)maxspend outlet:(BOOL)outlet isprivate:(BOOL)isprivate;
/**
 获取消费汇总
 
 @param year <#year description#>
 @return <#return value description#>
 */
-(NSArray *)getExpenditureByMonth:(NSString *)year;
/**
 更新消费照片
 
 @param eid 消费主键
 @param photo 照片路径（名称）
 @return 是否执行成功
 */
-(BOOL)updateExpenditurePhoto:(NSString *)eid photo:(NSString *)photo;
/*
 *---------------------------插入消费---------------------------------------------*
 */
-(BOOL)addExpenditure:(NewExpendModel *)model;
/*
 *---------------------------修改消费---------------------------------------------*
 */
-(BOOL)updateExpenditure:(NSString *)eid evalue:(double)evalue oldvalue:(double)oldvalue cid:(NSString *)cid fid:(NSString *)fid pid:(NSString *)pid createtime:(NSString *)createtime eyear:(NSString *)eyear emonth:(NSString *)emonth eday:(NSString *)eday imark:(NSString *)imark bdx:(NSString *)bdx bdy:(NSString *)bdy address:(NSString *)address;
/*
 *---------------------------获取支出详细信息---------------------------------------------*
 */
-(NSMutableArray*)getExpenditureDetail:(NSString*)cid sort:(NSInteger)sort start:(NSDate*)start end:(NSDate*)end;

-(NSDictionary*)getTotal:(NSString*)cid start:(NSDate*)start end:(NSDate*)end;
/*
 *-----------获取支出详细-------------*
 */
-(BusExpenditure*)getExpendDetail:(NSString*)eid;
/*
 *---------------------------删除消费---------------------------------------------*
 */
-(BOOL)deleteExpenditure:(NSString *)eid pid:(NSString*)pid evalue:(double)evalue;
/*
 *---------------------------获取消费汇总---------------------------------------------*
 */
-(NSMutableArray*)SelectExpenditure:(NSDate*)start end:(NSDate*)end;
@end
