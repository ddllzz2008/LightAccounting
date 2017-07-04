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
#import "BusExpenditure.h"
#import "MTLJSONAdapter.h"

@interface BillViewModel : BaseViewModel{
    
    NSString *minvalue;
    NSString *maxvalue;
    BOOL isoutlet;
    BOOL isprivate;
    NSArray<NSString *> *categories;
    
}

@property (nonatomic,copy) NSArray *leftsource;

@property (nonatomic,copy) NSArray *rightsource;


/**
 设置筛选条件

 @param min <#min description#>
 @param max <#max description#>
 @param cids <#cids description#>
 @param outlet <#outlet description#>
 @param private <#private description#>
 */
- (void)setFilter:(NSString *)min max:(NSString *)max cids:(NSArray<NSString *> *)cids outlet:(BOOL)outlet private:(BOOL)private;
/**
 加载类别
 
 @return 类别数组
 */
-(NSMutableArray *)loadCategory;

/**
 加载账单

 @param date <#date description#>
 */
-(void)loadBill:(NSDate *)date;

@end
