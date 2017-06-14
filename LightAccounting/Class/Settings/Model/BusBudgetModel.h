//
//  BusBudgetModel.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/14.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface BusBudgetModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,assign) int BID;

@property (nonatomic,copy,readwrite) NSString *BYEAR;

@property (nonatomic,copy,readwrite) NSString *BMONTH;

@property (nonatomic,assign) double BVALUE;

@property (nonatomic,strong) NSString *BVALUEString;

@property (nonatomic,assign) double ACTUALVALUE;

@property (nonatomic,assign) double LEFTVALUE;

@end
