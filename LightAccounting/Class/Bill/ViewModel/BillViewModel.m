//
//  BillViewModel.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/21.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BillViewModel.h"

@implementation BillViewModel

-(void)loadBill:(NSDate *)date{
    
    AppConfigurationModel *config = [[AppConfigurationDAL Instance] getAppConfiguration];
    if (config!=nil) {
        int billday = config.BILLDATE;
        long currentday = [date day];
        if (currentday>=billday) {
            //表示当前日期处于当前账单月
        }else{
            //表示当前日期处于上月账单日
        }
    }
    
}

@end
