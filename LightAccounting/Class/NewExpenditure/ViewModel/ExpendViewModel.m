//
//  ExpendViewModel.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/5.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "ExpendViewModel.h"

@implementation ExpendViewModel


/**
 检查收入数据合法性

 @return <#return value description#>
 */
-(NSString *)checkIncomeData{
    NSString *errorstring = @"";
    if (self.model.eid==nil || [CommonFunc isBlankString:self.model.eid]) {
        self.model.eid = [CommonFunc NewGUID];
    }
    if (self.model.cid==nil || [CommonFunc isBlankString:self.model.cid]) {
        errorstring = @"请选择收入类别";
    }else if(self.model.evalue==nil || (!([self.model.evalue isInt]) && !([self.model.evalue isFloat]))){
        errorstring = @"请输入有效金额";
    }else if(self.model.createtime==nil){
        errorstring = @"请选择记账时间";
    }
    return errorstring;
}

/**
 检查支出数据合法性

 @return <#return value description#>
 */
-(NSString *)checkExpendData{
    NSString *errorstring = @"";
    if (self.model.eid==nil || [CommonFunc isBlankString:self.model.eid]) {
        self.model.eid = [CommonFunc NewGUID];
    }
    if (self.model.cid==nil || [CommonFunc isBlankString:self.model.cid]) {
        errorstring = @"请选择支出类别";
    }else if(self.model.evalue==nil || (!([self.model.evalue isInt]) && !([self.model.evalue isFloat]))){
        errorstring = @"请输入有效金额";
    }else if(self.model.createtime==nil){
        errorstring = @"请选择记账时间";
    }
    return errorstring;
}

/**
 保存收入

 @return <#return value description#>
 */
-(BOOL)saveIncome{
    
    BOOL hresult = [[IncomeDAL Instance] addIncome:self.model];
    
    return hresult;
}

/**
 保存支出

 @return <#return value description#>
 */
-(BOOL)saveExpend{
    
    BOOL hresult = [[ExpenditureDAL Instance] addExpenditure:self.model];
    
    return hresult;
}

/**
 获取支出明细

 @param id <#id description#>
 @return <#return value description#>
 */
-(NewExpendModel *)getExpendModel:(NSString *)id{
    return nil;
}

/**
 获取收入明细

 @param id <#id description#>
 @return <#return value description#>
 */
-(NewExpendModel *)getIncomeModel:(NSString *)id{
    return nil;
}

/**
 获取收入类别
 type：0--支出，1--收入
 @return <#return value description#>
 */
-(NSMutableArray *)getIncomeCategory{
    NSMutableArray *array = [[CategoryDAL Instance] getCategory:1];
    return array;
}
/**
 获取支出类别
 type：0--支出，1--收入
 @return <#return value description#>
 */
-(NSMutableArray *)getExpendCategory{
    NSMutableArray *array = [[CategoryDAL Instance] getCategory:0];
    return array;
}

@end
