//
//  NewExpendModel.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/5.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewExpendModel : NSObject

@property (nonatomic,strong) NSString *eid;

@property (nonatomic,assign) NSString *evalue;

@property (nonatomic,strong) NSString *cid;

@property (nonatomic,strong) NSString *fid;

@property (nonatomic,strong) NSDate *createtime;

@property (nonatomic,strong) NSString *eyear;

@property (nonatomic,strong) NSString *emonth;

@property (nonatomic,strong) NSString *eday;

@property (nonatomic,strong) NSString *imark;

@property (nonatomic,strong) NSString *pid;

@property (nonatomic,strong) NSString *bdx;

@property (nonatomic,strong) NSString *bdy;

@property (nonatomic,strong) NSString *bdaddress;

@property (nonatomic,assign) int outbudget;

@property (nonatomic,assign) int isprivate;

@end
