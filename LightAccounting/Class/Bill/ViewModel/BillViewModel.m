//
//  BillViewModel.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/21.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BillViewModel.h"

@interface BillViewModel()

@property (nonatomic,copy,readwrite) NSString *totalIncome;

@property (nonatomic,copy,readwrite) NSString *totalExpend;

@end

@implementation BillViewModel

-(void)loadBill:(NSDate *)date{
    
    @try {
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
            
            NSArray *source = [[ExpenditureDAL Instance] getAccountDetail:[startday convertDateFromString:@"yyyy-MM-dd HH:mm:ss"] end:[endday convertDateFromString:@"yyyy-MM-dd HH:mm:ss"] categoryid:categories minspend:minvalue maxspend:maxvalue outlet:isoutlet isprivate:isprivate];
            
            if (source!=nil&&source.count>0) {
                NSArray *returnArray = [MTLJSONAdapter modelsOfClass:[BusExpenditure class] fromJSONArray:source error:nil];
                //类型分组
                NSArray *namearray = [returnArray valueForKey:@"CNAME"];
                //类型筛选
                NSSet *nameset = [NSSet setWithArray:namearray];
                //用于存放类别分组的对象
                NSMutableArray *nameresultArray = [NSMutableArray array];
                
                [[nameset allObjects] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"CNAME == %@",obj];
                    NSArray *indexArray = [returnArray filteredArrayUsingPredicate:predicate];
                    // 将查询结果加入到resultArray中
                    [nameresultArray addObject:indexArray];
                }];
                
                //日期分组
                NSArray *datearray = [returnArray valueForKey:@"CNAME"];
                //日期筛选
                NSSet *dateset = [NSSet setWithArray:datearray];
                NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:NO]];
                NSArray *sortSetArray = [dateset sortedArrayUsingDescriptors:sortDesc];
                //用于存放类别分组的对象
                NSMutableArray *dateresultArray = [NSMutableArray array];
                
                for (NSString *date in sortSetArray){
                    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"CREATETIME == %@",date];
                    NSArray *indexArray = [returnArray filteredArrayUsingPredicate:predicate];
                    // 将查询结果加入到resultArray中
                    [dateresultArray addObject:indexArray];
                }
                
                self.leftsource = nameresultArray;
                
                self.rightsource = dateresultArray;
                
                //设置总共支出，收入
                NSPredicate *incomepredicate = [NSPredicate predicateWithFormat:@" TYPE==0 "];
                NSArray *incomearray = [returnArray filteredArrayUsingPredicate:incomepredicate];
                self.totalIncome = [[incomearray valueForKeyPath:@"@sum.EVALUE"] stringValue];
                
                NSPredicate *expendpredicate = [NSPredicate predicateWithFormat:@" TYPE==0 "];
                NSArray *expendarray = [returnArray filteredArrayUsingPredicate:expendpredicate];
                self.totalIncome = [[expendarray valueForKeyPath:@"@sum.EVALUE"] stringValue];
                
            }
            
        }
        
    } @catch (NSException *exception) {
        DDLogDebug(@"BillViewModel  Error:%@",exception);
    } @finally {
        
    }
    
}

/**
 加载类别

 @return <#return value description#>
 */
-(NSMutableArray *)loadCategory{
    
    return [[CategoryDAL Instance] getCategory:-1];
    
}

/**
 设置筛选条件
 
 @param min <#min description#>
 @param max <#max description#>
 @param cids <#cids description#>
 */
- (void)setFilter:(NSString *)min max:(NSString *)max cids:(NSArray<NSString *> *)cids outlet:(BOOL)outlet private:(BOOL)private{
    
    minvalue = min;
    maxvalue = max;
    categories = cids;
    isoutlet = outlet;
    isprivate = private;
    
}

@end
