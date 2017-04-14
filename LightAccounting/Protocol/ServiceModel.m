//
//  ServiceModel.m
//  DLZProject
//
//  Created by ddllzz on 16/11/21.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "ServiceModel.h"

@implementation ServiceModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"Code": @"Code",
             @"Message": @"Message",
             @"Data": @"Data"
             };
}

@end
