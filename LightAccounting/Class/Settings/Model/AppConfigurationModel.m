//
//  AppConfigurationModel.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/14.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "AppConfigurationModel.h"

@implementation AppConfigurationModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"VERSION":@"VERSION",
             @"BACKGROUND":@"BACKGROUND",
             @"ALERTSTATUS":@"ALERTSTATUS",
             @"TOUCHPASSWORD":@"TOUCHPASSWORD",
             @"IFPASSWORD":@"IFPASSWORD",
             @"STARTDATE":@"STARTDATE",
             @"LASTDATE":@"LASTDATE",
             @"CTYPE":@"CTYPE",
             @"BILLDATE":@"BILLDATE"};
}

@end
