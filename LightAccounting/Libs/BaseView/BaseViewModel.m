//
//  BaseViewModel.m
//  DLZProject
//
//  Created by ddllzz on 16/11/22.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

static NSString *familycachestring = @"familycachestring";

/**
 获取账本列表

 @return <#return value description#>
 */
-(NSArray *)getFamilyAccounts{
    NSArray *array = [[FamilyPersonDAL Instance] getFamilyPersons];
    return array;
}
/**
 获取默认账本

 @return <#return value description#>
 */
-(FamilyPerson *)getDefaultFamily{
    
    NSData *data = [[StoreUserDefault instance] getDataWithNSData:familycachestring];
    
    if (data!=nil) {
        FamilyPerson *person = [NSKeyedUnarchiver unarchiveObjectWithData:data] ;
        return person;
    }else{
        NSArray *array = [[FamilyPersonDAL Instance] getFamilyPersons];
        if (array!=nil && array.count>0) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[array objectAtIndex:0]];
            
            [[StoreUserDefault instance] setData:familycachestring data:data];
            return [array objectAtIndex:0];
        }else{
            return nil;
        }
    }

}

/**
 设置默认账本

 @param familyid <#familyid description#>
 @return <#return value description#>
 */
-(BOOL)setDefaultFamily:(NSString *)familyid{
    
    NSArray *array = [[FamilyPersonDAL Instance] getFamilyPersons];
    if (array!=nil && array.count>0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fid==%@",familyid];
        NSArray *result = [array filteredArrayUsingPredicate:predicate];
        if (result!=nil && result.count>0) {
            
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[result objectAtIndex:0]];
            
            [[StoreUserDefault instance] setData:familycachestring data:data];
            
        }
        return YES;
        
    }else{
        return NO;
    }
    
}

/**
 获取月账单范围

 @param currentDate 当前日期
 @return 起始日期
 */
-(NSArray<NSDate *> *)getBillDateRange:(NSDate *)currentDate{
    
    AppConfigurationModel *config = [[AppConfigurationDAL Instance] getAppConfiguration];
    if (config!=nil) {
        long day = [currentDate getDateFormatter:@"dd"];
        int billday = config.BILLDATE;
        long startyear = [currentDate getDateFormatter:@"yyyy"];
        long endyear = startyear;
        long startmonth = [currentDate getDateFormatter:@"MM"];
        long endmonth = startmonth;
        if (day>=billday) {
            //当前月账单
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
        NSString *endday = [NSString stringWithFormat:@"%ld-%ld-%d 23:59:59",endyear,endmonth,billday-1];
        
        return [NSArray arrayWithObjects:[startday convertDateFromString:@"yyyy-MM-dd HH:mm:ss"],[endday convertDateFromString:@"yyyy-MM-dd HH:mm:ss"], nil];
        
    }else{
        return [currentDate dateForCurrentMonth];
    }
}

/**
 将当前日期转换为实际账单日期

 @return 转换后的日期
 */
- (NSDate *)getCurrentDate{
    
    NSDate *date = [NSDate dateWithZone];
    
    AppConfigurationModel *config = [[AppConfigurationDAL Instance] getAppConfiguration];
    if (config!=nil) {
        int billday = config.BILLDATE;
        if ([date day]>=billday) {
            //当月账单周期
        }else{
            //上月账单周期
            date = [[NSString stringWithFormat:@"%ld-%ld-%d 00:00:00",[date year],[date month]-1,billday+1] convertDateFromString:@"yyyy-MM-dd HH:mm:ss"];
        }
    }
    return date;
}

/**
 封装基于GCD的线程操作

 @param loadingtitle 加载提示
 @param successtitle 成功提示
 @param errortitle 成功提示
 @param threadaction 子线程操作
 @param mainuiaction UI主线程操作
 */
- (void)runThreadAction:(NSString * __nullable)loadingtitle successtitle:(NSString * __nullable)successtitle errortitle:(NSString * __nullable)errortitle threadaction:(BOOL (^)())threadaction mainuiaction:(void (^)(BOOL))mainuiaction{
    
    if (loadingtitle!=nil&&![loadingtitle isEqualToString:@""]) {
        [[AlertController sharedInstance] showMessage:loadingtitle];
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL hresult = YES;
        
        if (threadaction!=nil) {
            hresult = threadaction();
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            if (mainuiaction!=nil) {
                mainuiaction(hresult);
            }
            
            if (hresult) {
                if (successtitle!=nil&&![successtitle isEqualToString:@""]) {
                    [[AlertController sharedInstance] closeMessage];
                    
                    [[AlertController sharedInstance] showMessageAutoClose:successtitle];
                }else{
                    [[AlertController sharedInstance] closeMessage];
                }
            }else{
                if (errortitle!=nil&&![errortitle isEqualToString:@""]) {
                    [[AlertController sharedInstance] closeMessage];
                    
                    [[AlertController sharedInstance] showMessageAutoClose:errortitle];
                }else{
                    [[AlertController sharedInstance] closeMessage];
                }
            }

        });
    });
    
}

@end
