//
//  ChartViewModel.h
//  LightAccounting
//
//  Created by ddllzz on 17/8/18.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewModel.h"
#import "CategoryDAL.h"
#import "ExpenditureDAL.h"
#import "BusExpenditure.h"

@interface ChartViewModel : BaseViewModel{
    
    NSString *minvalue;
    NSString *maxvalue;
    BOOL isoutlet;
    BOOL isprivate;
    NSArray<NSString *> *categories;
    
}

@property (nonatomic,assign) NSInteger currentType;

- (NSString *)minvalue;
- (NSString *)maxvalue;
- (NSArray<NSString *> *)categories;
- (BOOL)isoutlet;
- (BOOL)isprivate;

@property (nonatomic,strong) NSMutableArray *chart1source;

/**
 设置筛选条件
 
 @param min 最低消费
 @param max 最大消费
 @param cids 类别
 */
- (void)setFilter:(NSInteger)type min:(NSString *)min max:(NSString *)max cids:(NSArray<NSString *> *)cids outlet:(BOOL)outlet private:(BOOL)private;

/**
 加载类别
 
 @return 类别集合
 */
-(NSMutableArray *)loadCategory;

/**
 获取账单汇总
 
 @param startdate 开始日期
 @param enddate 结束日期
 */
-(void)loadExpendByCategory:(NSDate *)startdate enddate:(NSDate *)enddate;

@end
