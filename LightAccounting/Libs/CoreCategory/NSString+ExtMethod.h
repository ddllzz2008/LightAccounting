//
//  NSString+ExtMethod.h
//  DLZHelpers
//
//  Created by ddllzz on 16/3/31.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ExtMethod)

-(BOOL) isBlankString;

- (NSDate*) convertDateFromString:(NSString *)format;

/*
 *-------------------字符串补位--------------------------------*
 */
- (NSString*)padLeftWithChar:(int)maxlength charstring:(NSString*)charstring;

/*
 *-------------------字符串补位--------------------------------*
 */
- (NSString*)padRightWithChar:(int)maxlength charstring:(NSString*)charstring;
/**
 判断字符串是否为整数
 
 @return YES OR NO
 */
-(BOOL)isInt;
/**
 判断字符串是否为浮点数
 
 @return YES OR NO
 */
-(BOOL)isFloat;
/**
 替换sql中的关键字符
 
 @return <#return value description#>
 */
-(NSString *)replaceSqlString;
/**
 去掉字符串中所有空格
 
 @return <#return value description#>
 */
-(NSString *)trimSpace;

@end
