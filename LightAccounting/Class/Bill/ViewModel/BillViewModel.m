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

@property (nonatomic,copy,readwrite) NSArray *yearForExpend;

@property (nonatomic,copy,readwrite) NSArray *yearForIncome;

@end

@implementation BillViewModel

/**
 获取总账单

 @param date 当前日期
 */
-(void)loadBill:(NSDate *)date{
    
    @try {
        
        NSArray<NSDate *> *monthrange = [super getBillDateRange:date];
            
        NSArray *source = [[ExpenditureDAL Instance] getAccountDetail:[monthrange objectAtIndex:0] end:[monthrange objectAtIndex:1] categoryid:categories minspend:minvalue maxspend:maxvalue outlet:isoutlet isprivate:isprivate];
        
        if (source!=nil&&source.count>0) {
            totalArray = [[MTLJSONAdapter modelsOfClass:[BusExpenditure class] fromJSONArray:source error:nil] mutableCopy];
            //类型分组
            NSPredicate *typepredicate = [NSPredicate predicateWithFormat:@"TYPE==%d",_currentType];
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
            
            self.rightsource = dateresultArray;
            
            //设置总共支出，收入
            NSPredicate *incomepredicate = [NSPredicate predicateWithFormat:@" TYPE==1 "];
            NSArray *incomearray = [totalArray filteredArrayUsingPredicate:incomepredicate];
            self.totalIncome = [[incomearray valueForKeyPath:@"@sum.EVALUE"] stringValue];
            
            NSPredicate *expendpredicate = [NSPredicate predicateWithFormat:@" TYPE==0 "];
            NSArray *expendarray = [totalArray filteredArrayUsingPredicate:expendpredicate];
            self.totalExpend = [[expendarray valueForKeyPath:@"@sum.EVALUE"] stringValue];
            
            NSMutableArray *leftdictionry = [[NSMutableArray alloc] init];
            CGFloat totalvalue = _currentType==0?[self.totalExpend floatValue]:[self.totalIncome floatValue];
            for (NSArray *leftarray in nameresultArray) {
                BusExpenditure *model = [leftarray objectAtIndex:0];
                NSNumber *total = [leftarray valueForKeyPath:@"@sum.EVALUE"];
                NSString *percent = [NSString stringWithFormat:@"%.1f%%",[total floatValue]/totalvalue];
                [leftdictionry addObject:@{@"name":model.CNAME,@"percent":percent,@"evalue":total}];
            }
            
            self.leftsource = leftdictionry;
            
        }else{
            
            self.leftsource = nil;
            self.rightsource = nil;
            self.totalIncome=@"0";
            self.totalExpend=@"0";
            
        }
        
        //获取年度总数
        self.yearForExpend = [[ExpenditureDAL Instance] getExpenditureByYear:[date formatWithCode:@"yyyy"] categoryid:categories minspend:minvalue maxspend:maxvalue outlet:isoutlet isprivate:isprivate];
        self.yearForIncome = [[IncomeDAL Instance] getIncomeByYear:[date formatWithCode:@"yyyy"] categoryid:categories minspend:minvalue maxspend:maxvalue isprivate:isprivate];
        
        
    } @catch (NSException *exception) {
        DDLogDebug(@"BillViewModel  Error:%@",exception);
    } @finally {
        
    }
    
}

/**
 获取详细账单

 @param date 当前日期
 */
- (void)loadDetailBill:(NSDate *)date{
    
    @try {
        
        NSArray<NSDate *> *monthrange = [super getBillDateRange:date];
        
        NSArray *source = [[ExpenditureDAL Instance] getAccountDetail:[monthrange objectAtIndex:0] end:[monthrange objectAtIndex:1] categoryid:categories minspend:minvalue maxspend:maxvalue outlet:isoutlet isprivate:isprivate];
        
        if (source!=nil&&source.count>0) {
            totalArray = [MTLJSONAdapter modelsOfClass:[BusExpenditure class] fromJSONArray:source error:nil];
            
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
            
            self.rightsource = dateresultArray;
            
            //设置总共支出，收入
            NSPredicate *incomepredicate = [NSPredicate predicateWithFormat:@" TYPE==1 "];
            NSArray *incomearray = [totalArray filteredArrayUsingPredicate:incomepredicate];
            self.totalIncome = [[incomearray valueForKeyPath:@"@sum.EVALUE"] stringValue];
            
            NSPredicate *expendpredicate = [NSPredicate predicateWithFormat:@" TYPE==0 "];
            NSArray *expendarray = [totalArray filteredArrayUsingPredicate:expendpredicate];
            self.totalExpend = [[expendarray valueForKeyPath:@"@sum.EVALUE"] stringValue];
            
        }else{
            
            self.leftsource = nil;
            self.rightsource = nil;
            self.totalIncome=@"0";
            self.totalExpend=@"0";
            
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
 删除账单

 @param bid 账单ID
 @param type 类型，0：支出，1：收入
 */
- (BOOL)deleteBill:(NSString *)bid type:(int)type{
    
    BOOL hresult = NO;
    if (type==0) {
        //支出
        hresult = [[ExpenditureDAL Instance] deleteExpenditure:bid];
    }else{
        //收入
        hresult = [[IncomeDAL Instance] deleteIncome:bid];
    }
    
    if (hresult) {
        //从totalarray中删除
        NSPredicate *totalpredicate = [NSPredicate predicateWithFormat:@" EID==%@ ",bid];
        NSArray *deletemodel = [totalArray filteredArrayUsingPredicate:totalpredicate];
        if (deletemodel&&deletemodel.count>0) {
            [totalArray removeObject:[deletemodel objectAtIndex:0]];
        }
        
        [self setCurrentType:self.currentType];
        
        //设置总共支出，收入
        NSPredicate *incomepredicate = [NSPredicate predicateWithFormat:@" TYPE==1 "];
        NSArray *incomearray = [totalArray filteredArrayUsingPredicate:incomepredicate];
        self.totalIncome = [[incomearray valueForKeyPath:@"@sum.EVALUE"] stringValue];
        
        NSPredicate *expendpredicate = [NSPredicate predicateWithFormat:@" TYPE==0 "];
        NSArray *expendarray = [totalArray filteredArrayUsingPredicate:expendpredicate];
        self.totalExpend = [[expendarray valueForKeyPath:@"@sum.EVALUE"] stringValue];

    }
    
    return hresult;
    
}

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
 
 @param min <#min description#>
 @param max <#max description#>
 @param cids <#cids description#>
 */
- (void)setFilter:(NSInteger)type min:(NSString *)min max:(NSString *)max cids:(NSArray<NSString *> *)cids outlet:(BOOL)outlet private:(BOOL)private{
    
    _currentType = type;
    minvalue = min;
    maxvalue = max;
    categories = cids;
    isoutlet = outlet;
    isprivate = private;
    
}

-(void)setCurrentType:(NSInteger)currentType{
    
    _currentType = currentType;
    
    if (totalArray!=nil) {
        //类型分组
        NSPredicate *typepredicate = [NSPredicate predicateWithFormat:@"TYPE==%d",_currentType];
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
        CGFloat totalvalue = _currentType==0?[self.totalExpend floatValue]:[self.totalIncome floatValue];
        for (NSArray *leftarray in nameresultArray) {
            BusExpenditure *model = [leftarray objectAtIndex:0];
            NSNumber *total = [leftarray valueForKeyPath:@"@sum.EVALUE"];
            NSString *percent = [NSString stringWithFormat:@"%.1f%%",[total floatValue]/totalvalue];
            [leftdictionry addObject:@{@"name":model.CNAME,@"percent":percent,@"evalue":total}];
        }
        
        self.leftsource = leftdictionry;
    }
    
}

@end
