//
//  BudgetViewModel.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/14.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BudgetViewModel.h"

@implementation BudgetViewModel

-(id)init{
    if (self==[super init]) {
        
        AppConfigurationModel *appconfig = [[AppConfigurationDAL Instance] getAppConfiguration];
        if (appconfig!=nil) {
            self.billDate = [NSString stringWithFormat:@"%d",appconfig.BILLDATE];
        }else{
            self.billDate = @"1";
        }
    }
    return self;
}

/**
 通过年份获取预算
 */
-(void)getBudgetsByYear{
    
    NSArray *expendarray = [[ExpenditureDAL Instance] getExpenditureByMonth:self.currentYear];
    
    NSArray *array = [[BusBudgetDAL Instance] getBudgetInfos:self.currentYear];
    if (array!=nil&&array.count>0) {
        
        NSPredicate *pre;
        NSArray *newarray;
        for (BusBudgetModel *model in array) {
            pre = [NSPredicate predicateWithFormat:@"EMONTH in {%@}",model.BMONTH];
            newarray = [expendarray filteredArrayUsingPredicate:pre];
            if (newarray!=nil && newarray.count>0) {
                double expend = [[[newarray objectAtIndex:0] objectForKey:@"EVALUE"] doubleValue];
                model.ACTUALVALUE = expend;
                model.LEFTVALUE = model.BVALUE - expend;
            }else{
                model.ACTUALVALUE = 0;
                model.LEFTVALUE = model.BVALUE;
            }
        }
        
        self.budgetArray = array;
    }else{
        NSMutableArray *arraymutable = [[NSMutableArray alloc] init];
        
        NSPredicate *pre;
        NSArray *newarray;
        for (int i=1; i<=12; i++) {
            BusBudgetModel *model = [[BusBudgetModel alloc] init];
            model.BVALUE = 0;
            model.BYEAR = self.currentYear;
            model.BMONTH = [NSString stringWithFormat:@"%d",i];
            pre = [NSPredicate predicateWithFormat:@"EMONTH in {%@}",model.BMONTH];
            newarray = [expendarray filteredArrayUsingPredicate:pre];
            if (newarray!=nil && newarray.count>0) {
                double expend = [[[newarray objectAtIndex:0] objectForKey:@"EVALUE"] doubleValue];
                model.ACTUALVALUE = expend;
                model.LEFTVALUE = model.BVALUE - expend;
            }else{
                model.ACTUALVALUE = 0;
                model.LEFTVALUE = model.BVALUE;
            }
            [arraymutable addObject:model];
        }
        array = [[NSArray alloc] initWithArray:arraymutable];
        self.budgetArray = array;
    }
    
}

/**
 保存预算

 @return <#return value description#>
 */
-(NSString *)setBudgetsByYear{
    NSString *errorstring = @"";
    for (BusBudgetModel *model in self.budgetArray) {
        if (![model.BVALUEString isInt] && ![model.BVALUEString isFloat] && model.BVALUEString!=nil && ![model.BVALUEString isEqualToString:@""]) {
            errorstring = [NSString stringWithFormat:@"%@月的预算输入不合法，请输入有效数值",model.BMONTH];
            return errorstring;
            break;
        }
        if (model.BVALUEString==nil||[model.BVALUEString isEqualToString:@""]) {
            model.BVALUE = 0;
        }else{
            model.BVALUE = [model.BVALUEString doubleValue];
        }
        
    }
    
    BOOL hresult = [[BusBudgetDAL Instance] setBudgetInfos:self.currentYear source:self.budgetArray];
    if (hresult) {
        errorstring =@"";
    }else{
        errorstring =@"保存失败";
    }
    return errorstring;
}
/**
 设置账单日

 @return <#return value description#>
 */
-(NSString *)setBillDate{
    
    NSString *errorstring = @"";
    if (self.billDate==nil || [CommonFunc isBlankString:self.billDate]) {
        return @"请输入账单日";
    }else if(![self.billDate isInt] || [self.billDate intValue]<1 || [self.billDate intValue]>31){
        return @"账单日必须为整数且有效范围为1至31";
    }
    
    BOOL hresult = [[AppConfigurationDAL Instance] updateBillDate:[self.billDate intValue]];
    
    if (hresult) {
        errorstring =@"";
    }else{
        errorstring =@"保存失败";
    }
    return errorstring;
    
}

@end
