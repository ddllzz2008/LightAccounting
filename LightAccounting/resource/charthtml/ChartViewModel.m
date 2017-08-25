//
//  ChartViewModel.m
//  LightAccounting
//
//  Created by ddllzz on 17/8/18.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "ChartViewModel.h"

@interface ChartViewModel()

@property (nonatomic,copy,readwrite) NSString *totalIncome;

@property (nonatomic,copy,readwrite) NSString *totalExpend;

@end

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

/**
 获取图表详情数据

 @param startdate 开始时间
 @param enddate 结束时间
 */
- (void)loadChartsDetail:(NSDate *)startdate enddate:(NSDate *)enddate{
    
    @try {
        
        NSArray *source = [[ExpenditureDAL Instance] getAccountDetail:startdate end:enddate categoryid:categories minspend:minvalue maxspend:maxvalue outlet:isoutlet isprivate:isprivate];
        
        if (source!=nil&&source.count>0) {
            NSArray *totalArray = [[MTLJSONAdapter modelsOfClass:[BusExpenditure class] fromJSONArray:source error:nil] mutableCopy];
            
            //日期分组
            NSArray *datearray = [totalArray valueForKey:@"CREATETIME"];
            //日期筛选
            NSSet *dateset = [NSSet setWithArray:datearray];
            NSArray *sortDesc = @[[[NSSortDescriptor alloc] initWithKey:nil ascending:NO]];
            NSArray *sortSetArray = [dateset sortedArrayUsingDescriptors:sortDesc];
            //用于存放类别分组的对象
            NSMutableArray *dateresultArray = [[NSMutableArray alloc] init];
            
            for (NSString *date in sortSetArray){
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"CREATETIME == %@",date];
                NSArray *indexArray = [totalArray filteredArrayUsingPredicate:predicate];
                // 将查询结果加入到resultArray中
                [dateresultArray addObject:[indexArray mutableCopy]];
            }
            
            self.chartdetailsource = dateresultArray;
            
            //设置总共支出，收入
            NSPredicate *incomepredicate = [NSPredicate predicateWithFormat:@" TYPE==1 "];
            NSArray *incomearray = [totalArray filteredArrayUsingPredicate:incomepredicate];
            self.totalIncome = [[incomearray valueForKeyPath:@"@sum.EVALUE"] stringValue];
            self.totalIncome = [NSString stringWithFormat:@"%.1f",fabs([self.totalIncome floatValue])];
            
            NSPredicate *expendpredicate = [NSPredicate predicateWithFormat:@" TYPE==0 "];
            NSArray *expendarray = [totalArray filteredArrayUsingPredicate:expendpredicate];
            self.totalExpend = [[expendarray valueForKeyPath:@"@sum.EVALUE"] stringValue];
            self.totalExpend = [NSString stringWithFormat:@"%.1f",fabs([self.totalExpend floatValue])];
            
        }else{
            
            self.chartdetailsource = [[NSMutableArray alloc] init];
            self.totalIncome = @"0";
            self.totalExpend = @"0";
            
        }
        
    } @catch (NSException *exception) {
        DDLogDebug(@"BillViewModel  Error:%@",exception);
    } @finally {
        
    }
    
}

/**
 删除账单

 @param bid 账单id
 @param deletevalue 删除的消费值
 @param type 账单类型，0：支出，1：收入
 @return 执行是否成功
 */
- (BOOL)deleteBill:(NSString *)bid deletevalue:(CGFloat)deletevalue type:(int)type{
    
    BOOL hresult = NO;
    if (type==0) {
        //支出
        hresult = [[ExpenditureDAL Instance] deleteExpenditure:bid];
    }else{
        //收入
        hresult = [[IncomeDAL Instance] deleteIncome:bid];
    }
    
    if (hresult) {
        
        [self setCurrentType:self.currentType];
        
        if (type==0) {
            self.totalExpend = [NSString stringWithFormat:@"%.1f",fabs([self.totalExpend floatValue]) - fabs(deletevalue)];
        }else{
            self.totalIncome = [NSString stringWithFormat:@"%.1f",fabs([self.totalExpend floatValue]) - fabs(deletevalue)];
        }
        
    }
    
    return hresult;
    
}

@end
