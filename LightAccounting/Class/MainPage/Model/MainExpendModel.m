//
//  MainExpendModel.m
//  LightAccounting
//
//  Created by ddllzz on 17/3/22.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "MainExpendModel.h"

@implementation MainGroupModel

@end

@implementation MainExpendModel

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"EID":@"EID",
             @"EVALUE":@"EVALUE",
             @"CID":@"CID",
             @"FID":@"FID",
             @"PID":@"PID",
             @"CREATETIME":@"CREATETIME",
             @"EYEAR":@"EYEAR",
             @"EMONTH":@"EMONTH",
             @"EDAY":@"EDAY",
             @"IMARK":@"IMARK",
             @"BDX":@"BDX",
             @"BDY":@"BDY",
             @"BDADDRESS":@"BDADDRESS",
             @"CNAME":@"CNAME",
             @"CCOLOR":@"CCOLOR"};
}

@end
