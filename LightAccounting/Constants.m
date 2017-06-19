//
//  Constants.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/19.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "Constants.h"

@implementation Constants

static Constants *instance = nil;

+(Constants*)Instance{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instance = [[self alloc]init];
    });
    return instance;
}

@end
