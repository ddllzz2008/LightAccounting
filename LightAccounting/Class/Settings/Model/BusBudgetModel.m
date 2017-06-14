//
//  BusBudgetModel.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/14.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BusBudgetModel.h"

@implementation BusBudgetModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"BID":@"BID",
             @"BYEAR":@"BYEAR",
             @"BMONTH":@"BMONTH",
             @"BVALUE":@"BVALUE"};
}

@end
