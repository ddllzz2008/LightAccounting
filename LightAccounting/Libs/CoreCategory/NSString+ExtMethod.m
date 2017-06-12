//
//  NSString+ExtMethod.m
//  DLZHelpers
//
//  Created by ddllzz on 16/3/31.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "NSString+ExtMethod.h"

@implementation NSString (ExtMethod)

-(BOOL) isBlankString{
    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

/*
 *-------------------字符串转NSDate--------------------------------*
 *-------------------本月或上月点击中间内容无反应-------------------*
 */
- (NSDate*) convertDateFromString:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:format];
    NSDate *date=[formatter dateFromString:self];
    return date;
}

/*
 *-------------------字符串补位--------------------------------*
 */
- (NSString*)padLeftWithChar:(int)maxlength charstring:(NSString*)charstring
{
    NSInteger len = self.length;
    if (len >=maxlength) {
        return self;
    }else{
        NSMutableString *mutableString = [[NSMutableString alloc] init];
        NSInteger dis = maxlength - len;
        for (int i = 0; i<dis; i++) {
            [mutableString appendString:charstring];
        }
        [mutableString appendString:self];
        return [mutableString copy];
    }
}

/*
 *-------------------字符串补位--------------------------------*
 */
- (NSString*)padRightWithChar:(int)maxlength charstring:(NSString*)charstring
{
    int len = (int)self.length;
    if (len >=maxlength) {
        return self;
    }else{
        NSMutableString *mutableString = [[NSMutableString alloc] init];
        int dis = maxlength - len;
        [mutableString appendString:self];
        for (int i = 0; i<dis; i++) {
            [mutableString appendString:charstring];
        }
        return [mutableString copy];
    }
}

/**
 判断字符串是否为整数

 @return YES OR NO
 */
-(BOOL)isInt{
    NSScanner *scan = [NSScanner scannerWithString:self];
    int val;
    return [scan scanInt:&val] && [scan isAtEnd];
}

/**
 判断字符串是否为浮点数

 @return YES OR NO
 */
-(BOOL)isFloat{
    NSScanner *scan = [NSScanner scannerWithString:self];
    float val;
    return [scan scanFloat:&val] && [scan isAtEnd];
}

/**
 替换sql中的关键字符

 @return <#return value description#>
 */
-(NSString *)replaceSqlString{
    NSString *result = self;
    NSArray *array = @[@"'",@"\""];
    NSArray *emtryarray = @[@"insert",@"update",@"delete",@"remove",@"create"];
    for (NSString *str in array) {
        result = [result stringByReplacingOccurrencesOfString:str withString:[NSString stringWithFormat:@"%@%@",str,str]];
    }
    for (NSString *str in emtryarray) {
        result = [result stringByReplacingOccurrencesOfString:str withString:@""];
    }
    return result;
}

@end
