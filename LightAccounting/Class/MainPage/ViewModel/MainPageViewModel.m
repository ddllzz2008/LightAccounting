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
        
//        [[setindex allObjects] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"CREATETIME==%@",obj];
//            NSArray *sourcearray = [returnArray filteredArrayUsingPredicate:predicate];
//            MainGroupModel *groupmodel = [[MainGroupModel alloc] init];
//            groupmodel.groupDate =obj;
//            groupmodel.groupExpend = [[sourcearray valueForKeyPath:@"@sum.EVALUE"] floatValue];
//            groupmodel.groupSource = sourcearray;
//            [returnsource addObject:groupmodel];
//        }];
        
    }
    return returnsource;
}

-(void)updateExpendPhoto:(NSString *)eid photo:(NSString *)photo{
    [[ExpenditureDAL Instance] updateExpenditurePhoto:eid photo:photo];
}

@end
