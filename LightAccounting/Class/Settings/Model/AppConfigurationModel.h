//
//  AppConfigurationModel.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/14.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface AppConfigurationModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy,readwrite) NSString *VERSION;

@property (nonatomic,copy,readwrite) NSString *BACKGROUND;

@property (nonatomic,assign) int ALERTSTATUS;

@property (nonatomic,copy,readwrite) NSString *TOUCHPASSWORD;

@property (nonatomic,assign) int IFPASSWORD;

@property (nonatomic,copy,readwrite) NSString *STARTDATE;

@property (nonatomic,readwrite) NSString *LASTDATE;

@property (nonatomic,readwrite) NSInteger CTYPE;

@property (nonatomic,assign) int BILLDATE;

@end
