//
//  MainPageViewModel.m
//  LightAccounting
//
//  Created by ddllzz on 17/3/22.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "MainPageViewModel.h"

@implementation MainPageViewModel

-(void)initFilters:(NSDate*)start end:(NSDate*)end categoryid:(NSString*)categoryid packageid:(NSString *)packageid minexpend:(NSString *)minexpend maxexpend:(NSString *)maxexpend{
    filterStartDate = start;
    filterEndDate=end;
    filterCategoryID = categoryid;
    filterMinExpend=minexpend;
    filterMaxExpend=maxexpend;
}

/**
 获取账单日

 @return <#return value description#>
 */
-(int)getBillDay{
    
    AppConfigurationModel *model = [[AppConfigurationDAL Instance] getAppConfiguration];
    if (model!=nil) {
        return model.BILLDATE;
    }else{
        return 1;
    }
    
}

-(NSMutableArray *)loadData{
    NSMutableArray *returnsource = [[NSMutableArray alloc] init];
    NSArray *expends = [[ExpenditureDAL Instance] getExpenditure:filterStartDate end:filterEndDate categoryid:filterCategoryID minspend:filterMinExpend maxspend:filterMaxExpend];
    if(expends!=nil && expends.count>0){
        
        NSArray *returnArray = [MTLJSONAdapter modelsOfClass:[MainExpendModel class] fromJSONArray:expends error:nil];
        
        NSArray *indexArray = [returnArray valueForKey:@"CREATETIME"];
        
        NSSet *setindex = [NSSet setWithArray:indexArray];
        
        NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:YES]];
        NSArray *sortSetArray = [setindex sortedArrayUsingDescriptors:sortDesc];
        
        for (NSString *date in sortSetArray) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"CREATETIME==%@",date];
            NSArray *sourcearray = [returnArray filteredArrayUsingPredicate:predicate];
            MainGroupModel *groupmodel = [[MainGroupModel alloc] init];
            groupmodel.groupDate =date;
            groupmodel.groupExpend = [[sourcearray valueForKeyPath:@"@sum.EVALUE"] floatValue];
            groupmodel.groupSource = sourcearray;
            [returnsource addObject:groupmodel];
        }
        
    }
    return returnsource;
}

/**
 获取本月预算

 @return <#return value description#>
 */
-(CGFloat)getCurrentBudget{
    NSDate *date = [NSDate dateWithZone];
    return [[BusBudgetDAL Instance] getBudgetInfo:[NSString stringWithFormat:@"%ld",(long)[date year]] month:[NSString stringWithFormat:@"%ld",(long)[date month]]];
    
}

-(void)updateExpendPhoto:(NSString *)eid photo:(NSString *)photo{
    [[ExpenditureDAL Instance] updateExpenditurePhoto:eid photo:photo];
}

@end
