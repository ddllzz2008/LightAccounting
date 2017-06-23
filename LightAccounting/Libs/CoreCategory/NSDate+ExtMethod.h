//
//  NSDate+ExtMethod.h
//  DLZHelpers
//
//  Created by ddllzz on 16/4/8.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ExtMethod)

- (NSString*) formatWithCode:(NSString*)format;

- (NSArray *)dateForCurrentWeek;

- (NSArray *)dateForLastWeek;

- (NSArray *)dateForCurrentMonth;

- (NSArray *)dateForLastMonth;

- (NSArray *)dateForNextMonth;

- (NSArray *)dateForCurrentYear;

- (NSArray *)dateForLastYear;

- (NSArray *)dateForNextYear;

-(NSDate *)dateForDays:(NSInteger)days;
/**
 计算日期相差天数
 
 @param date <#date description#>
 @return <#return value description#>
 */
-(int)dateDiff:(NSDate*)date;

-(NSInteger)weekday;

-(NSInteger)day;

-(NSInteger)month;

-(NSInteger)year;

+(NSDate *)dateWithZone;

// 格式转换
/**
 根据格式获取时间具体数值
 
 @param format <#format description#>
 @return <#return value description#>
 */
-(long)getDateFormatter:(NSString *)format;

@end
