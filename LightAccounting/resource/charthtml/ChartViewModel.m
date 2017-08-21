//
//  ChartViewModel.m
//  LightAccounting
//
//  Created by ddllzz on 17/8/18.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "ChartViewModel.h"

@implementation ChartViewModel

- (NSString *)minvalue{
    
    return minvalue;
    
}
- (NSString *)maxvalue{
    
    return maxvalue;
    
}
- (NSArray<NSString *> *)categories{
    
    return categories;
    
}
- (BOOL)isoutlet{
    
    return isoutlet;
    
}
- (BOOL)isprivate{
    
    return isprivate;
    
}
/**
 设置筛选条件
 
 @param min 最低消费
 @param max 最大消费
 @param cids 类别
 */
- (void)setFilter:(NSInteger)type min:(NSString *)min max:(NSString *)max cids:(NSArray<NSString *> *)cids outlet:(BOOL)outlet private:(BOOL)private{
    
    _currentType = type;
    minvalue = min;
    maxvalue = max;
    categories = cids;
    isoutlet = outlet;
    isprivate = private;
    
}

/**
 加载类别
 
 @return 类别集合
 */
-(NSMutableArray *)loadCategory{
    
    return [[CategoryDAL Instance] getCategory:-1];
    
}


/**
 获取账单汇总

 @param startdate 开始日期
 @param enddate 结束日期
 */
-(void)loadExpendByCategory:(NSDate *)startdate enddate:(NSDate *)enddate{
    
    @try {
        
        NSArray *source = [[ExpenditureDAL Instance] getAccountDetail:startdate end:enddate categoryid:categories minspend:minvalue maxspend:maxvalue outlet:isoutlet isprivate:isprivate];
        
        if (source!=nil&&source.count>0) {
            NSArray *totalArray = [[MTLJSONAdapter modelsOfClass:[BusExpenditure class] fromJSONArray:source error:nil] mutableCopy];
            //类型分组
            NSPredicate *typepredicate = [NSPredicate predicateWithFormat:@"TYPE==%d",0];
            NSArray *nameallarray = [totalArray filteredArrayUsingPredicate:typepredicate];
            NSArray *namearray = [nameallarray valueForKey:@"CNAME"];
            //类型筛选
            NSSet *nameset = [NSSet setWithArray:namearray];
            //用于存放类别分组的对象
            NSMutableArray *nameresultArray = [NSMutableArray array];
            
            [[nameset allObjects] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"CNAME == %@",obj];
                NSArray *indexArray = [nameallarray filteredArrayUsingPredicate:predicate];
                if (indexArray.count>0) {
                    // 将查询结果加入到resultArray中
                    [nameresultArray addObject:indexArray];
                }
                
            }];
            
            NSMutableArray *leftdictionry = [[NSMutableArray alloc] init];
            
            for (NSArray *leftarray in nameresultArray) {
                BusExpenditure *model = [leftarray objectAtIndex:0];
                NSNumber *total = [leftarray valueForKeyPath:@"@sum.EVALUE"];
                [leftdictionry addObject:@{@"name":model.CNAME,@"evalue":total}];
            }
            
            self.chart1source = leftdictionry;
            
        }else{
            self.chart1source = [[NSMutableArray alloc] init];
        }
        
    } @catch (NSException *exception) {
        DDLogDebug(@"BillViewModel  Error:%@",exception);
    } @finally {
        
    }
    
}

@end
