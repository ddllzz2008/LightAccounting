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
        NSDate *today = [NSDate dateWithZone];
        long day = [today getDateFormatter:@"dd"];
        int billday = config.BILLDATE;
        long startyear = [today getDateFormatter:@"yyyy"];
        long endyear = startyear;
        long startmonth = [today getDateFormatter:@"MM"];
        long endmonth = startmonth;
        if (day>=billday) {
            if (startmonth==12) {
                endyear = startyear+1;
                startmonth = 12;
                endmonth = 1;
            }else{
                endmonth = startmonth+1;
            }
        }else{
            if(startmonth==1){
                startyear = startyear-1;
                startmonth = 12;
                endmonth = 1;
            }else{
                startmonth = startmonth - 1;
            }
        }
        
        NSString *startday = [NSString stringWithFormat:@"%ld-%ld-%d 00:00:00",startyear,startmonth,billday];
        NSString *endday = [NSString stringWithFormat:@"%ld-%ld-%d 00:00:00",endyear,endmonth,billday];
    }
    
}

/**
 加载类别

 @return <#return value description#>
 */
-(NSMutableArray *)loadCategory{
    
    return [[CategoryDAL Instance] getCategory:-1];
    
}

@end
