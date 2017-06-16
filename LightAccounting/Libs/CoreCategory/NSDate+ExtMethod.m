//
//  NSDate+ExtMethod.m
//  DLZHelpers
//
//  Created by ddllzz on 16/4/8.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "NSDate+ExtMethod.h"

@implementation NSDate (ExtMethod)

/**
 * 格式化日期
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSString *)formatWithCode:(NSString*)format{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormat setDateFormat:format];
    return [dateFormat stringFromDate:self];
}

/**
 * 获取当前星期范围
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSArray *)dateForCurrentWeek{
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSCalendarUnitDay | NSDayCalendarUnit | NSCalendarUnitTimeZone fromDate:self];
    
    [components setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSInteger dayofweek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:self]weekday];
    [components setDay:([components day] - ((dayofweek) - 2))];// for beginning of the week.
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    [components setDay:([components day]+(7-dayofweek)+1)];// for end day of the week
    NSDate *enddingOfWeek = [gregorian dateFromComponents:components];
    
    NSArray *weekArray = [NSArray arrayWithObjects:beginningOfWeek,enddingOfWeek,nil];
    
    return weekArray;
}

/**
 * 获取上星期范围
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSArray *)dateForLastWeek{
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSCalendarUnitDay | NSDayCalendarUnit | NSCalendarUnitTimeZone fromDate:self];
    
    [components setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSInteger dayofweek = [[[NSCalendar currentCalendar] components:NSWeekdayCalendarUnit fromDate:self]weekday];
    [components setDay:([components day] - ((dayofweek) - 2) - 7)];// for beginning of the week.
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    [components setDay:([components day]+(7-dayofweek)+1 - 7)];// for end day of the week
    NSDate *enddingOfWeek = [gregorian dateFromComponents:components];
    
    NSArray *weekArray = [NSArray arrayWithObjects:beginningOfWeek,enddingOfWeek,nil];
    
    return weekArray;
}

/**
 * 获取本月范围
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSArray *)dateForCurrentMonth{
    
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    double interval = 0;
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    BOOL ok = [gregorian rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:self];
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        
    }
    
    NSArray *weekArray = [NSArray arrayWithObjects:beginDate,endDate,nil];
    
    return weekArray;
}

/**
 * 获取本月范围
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSArray *)dateForLastMonth{
    
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    double interval = 0;
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSCalendarUnitDay | NSDayCalendarUnit | NSCalendarUnitTimeZone fromDate:self];
    
    [components setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    [components setMonth:([components month] - 1)];
    
    [components setDay:5];
    
    NSDate *lastMonth = [gregorian dateFromComponents:components];
    
    BOOL ok = [gregorian rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:lastMonth];
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        
    }
    
    NSArray *weekArray = [NSArray arrayWithObjects:beginDate,endDate,nil];
    
    return weekArray;
}

/**
 * 获取下月范围
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSArray *)dateForNextMonth{
    
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    double interval = 0;
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSCalendarUnitDay | NSDayCalendarUnit | NSCalendarUnitTimeZone fromDate:self];
    
    [components setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    [components setMonth:([components month] + 1)];
    
    [components setDay:5];
    
    NSDate *lastMonth = [gregorian dateFromComponents:components];
    
    BOOL ok = [gregorian rangeOfUnit:NSMonthCalendarUnit startDate:&beginDate interval:&interval forDate:lastMonth];
    if (ok) {
        endDate = [beginDate dateByAddingTimeInterval:interval-1];
    }else {
        
    }
    
    NSArray *weekArray = [NSArray arrayWithObjects:beginDate,endDate,nil];
    
    return weekArray;
}

/**
 * 获取本年范围
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSArray *)dateForCurrentYear{
    
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSCalendarUnitDay | NSDayCalendarUnit | NSCalendarUnitTimeZone fromDate:self];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    [components setYear:dateComponents.year];
    [components setMonth:1];
    [components setDay:1];
    
    beginDate = [gregorian dateFromComponents:components];
    
    [components setYear:dateComponents.year];
    [components setMonth:12];
    [components setDay:31];
    
    endDate = [gregorian dateFromComponents:components];
    
    NSArray *weekArray = [NSArray arrayWithObjects:beginDate,endDate,nil];
    
    return weekArray;
}

/**
 * 获取本年范围
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSArray *)dateForLastYear{
    
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSCalendarUnitDay | NSDayCalendarUnit | NSCalendarUnitTimeZone fromDate:self];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    [components setYear:dateComponents.year-1];
    [components setMonth:1];
    [components setDay:1];
    
    beginDate = [gregorian dateFromComponents:components];
    
    [components setYear:dateComponents.year-1];
    [components setMonth:12];
    [components setDay:31];
    
    endDate = [gregorian dateFromComponents:components];
    
    NSArray *weekArray = [NSArray arrayWithObjects:beginDate,endDate,nil];
    
    return weekArray;
}

/**
 * 获取明年范围
 * @format 格式
 * @return 格式化的日期字符串
 */
- (NSArray *)dateForNextYear{
    
    NSDate *beginDate = nil;
    NSDate *endDate = nil;
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [gregorian components:NSYearCalendarUnit | NSMonthCalendarUnit | NSCalendarUnitDay | NSDayCalendarUnit | NSCalendarUnitTimeZone fromDate:self];
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    [components setYear:dateComponents.year+1];
    [components setMonth:1];
    [components setDay:1];
    
    beginDate = [gregorian dateFromComponents:components];
    
    [components setYear:dateComponents.year+1];
    [components setMonth:12];
    [components setDay:31];
    
    endDate = [gregorian dateFromComponents:components];
    
    NSArray *weekArray = [NSArray arrayWithObjects:beginDate,endDate,nil];
    
    return weekArray;
}

/**
 * 获取对应天数间隔的日期
 * @days 相隔天数
 * @return 固定的日期
 */
-(NSDate *)dateForDays:(NSInteger)days{
    NSDate *resultDay = [self initWithTimeInterval:(days * 24 * 60 * 60) sinceDate:self];
    return resultDay;
}

/**
 计算日期相差天数

 @param date <#date description#>
 @return <#return value description#>
 */
-(int)dateDiff:(NSDate*)date{
    //计算时间间隔（单位是秒）
    NSTimeInterval time = [self timeIntervalSinceDate:date];
    //计算天数、时、分、秒
    int days = ((int)time)/(3600*24);
    return days;
}

/**
 获取当前日期对应的星期几

 @return 星期几
 */
-(NSInteger)weekday{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:self];
    return [comps weekday];
}

/**
 返回天数

 @return 返回day
 */
-(NSInteger)day{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:self];
    return [comps day];
}

/**
 返回月
 
 @return 返回月
 */
-(NSInteger)month{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:self];
    return [comps month];
}

/**
 返回年
 
 @return 返回年
 */
-(NSInteger)year{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:self];
    return [comps year];
}

/**
 获取没有时差的当前日期

 @return 没有时差的日期
 */
+(NSDate *)dateWithZone{
    NSDate *currentDate = [[NSDate date] dateByAddingTimeInterval:[[NSTimeZone systemTimeZone] secondsFromGMTForDate:[NSDate date]]];
    return currentDate;
}

@end
