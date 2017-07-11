//
//  BillViewModel.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/21.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewModel.h"
#import "NSDate+ExtMethod.h"
#import "NSString+ExtMethod.h"
#import "AppConfigurationDAL.h"
#import "AppConfigurationModel.h"
#import "CategoryDAL.h"
#import "ExpenditureDAL.h"
#import "IncomeDAL.h"
#import "BusExpenditure.h"
#import "MTLJSONAdapter.h"

@interface BillViewModel : BaseViewModel{
    
    NSArray *totalArray;
    
    NSString *minvalue;
    NSString *maxvalue;
    BOOL isoutlet;
    BOOL isprivate;
    NSArray<NSString *> *categories;
    
}

@property (nonatomic,assign) NSInteger currentType;

@property (nonatomic,copy) NSArray *leftsource;

@property (nonatomic,strong) NSMutableArray *rightsource;

@property (nonatomic,copy,readonly) NSString *totalIncome;

@property (nonatomic,copy,readonly) NSString *totalExpend;

@property (nonatomic,copy,readonly) NSArray *yearForExpend;

@property (nonatomic,copy,readonly) NSArray *yearForIncome;


/**
 设置筛选条件
 
 @param type <#min description#>
 @param min <#min description#>
 @param max <#max description#>
 @param cids <#cids description#>
 @param outlet <#outlet description#>
 @param private <#private description#>
 */
- (void)setFilter:(NSInteger)type min:(NSString *)min max:(NSString *)max cids:(NSArray<NSString *> *)cids outlet:(BOOL)outlet private:(BOOL)private;

- (NSString *)minvalue;
- (NSString *)maxvalue;
- (NSArray<NSString *> *)categories;
- (BOOL)isoutlet;
- (BOOL)isprivate;
/**
 加载类别
 
 @return 类别数组
 */
-(NSMutableArray *)loadCategory;
/**
 删除账单
 
 @param bid 账单ID
 @param type 类型，0：支出，1：收入
 */
- (BOOL)deleteBill:(NSString *)bid type:(int)type;

/**
 加载账单

 @param date <#date description#>
 */
-(void)loadBill:(NSDate *)date;
/**
 获取详细账单
 
 @param date 当前日期
 */
- (void)loadDetailBill:(NSDate *)date;

@end
