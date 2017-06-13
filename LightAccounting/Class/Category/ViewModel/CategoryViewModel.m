//
//  CategoryViewModel.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/13.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "CategoryViewModel.h"

@implementation CategoryViewModel

/**
 获取收入类别
 
 @return <#return value description#>
 */
-(NSMutableArray *)getIncomeCategory{
    
    NSMutableArray *array = [[CategoryDAL Instance] getCategory:1];
    return array;
}

/**
 获取支出类别
 
 @return <#return value description#>
 */
-(NSMutableArray *)getExpendCategory{
    NSMutableArray *array = [[CategoryDAL Instance] getCategory:0];
    return array;
}

/**
 检查类别
 
 @return <#return value description#>
 */
-(NSString *)checkCategory{
    
    NSString *errorstring = @"";
//    if (self.model.CID==nil || [CommonFunc isBlankString:self.model.CID]) {
//        self.model.CID = [CommonFunc NewGUID];
//    }
    if (self.model.CNAME==nil || [CommonFunc isBlankString:self.model.CNAME]) {
        errorstring = @"请输入分类名称";
    }else if(self.model.CCOLOR==nil || [CommonFunc isBlankString:self.model.CCOLOR]){
        errorstring = @"请选择分类图标";
    }
    return errorstring;
    
}

/**
 增加类别
 
 @return <#return value description#>
 */
-(CategoryModel *)addCategory{
    
    self.model.CID = [CommonFunc NewGUID];
    CategoryModel *newmodel = [[CategoryDAL Instance] addCategory:self.model];
    return newmodel;
    
}

/**
 修改类别
 
 @return <#return value description#>
 */
-(BOOL)updateCategory{
    
    return [[CategoryDAL Instance] updateCategory:self.model];
    
}

/**
 删除类别
 
 @return <#return value description#>
 */
-(BOOL)deleteCategory{
    
    return [[CategoryDAL Instance] deleteCategory:self.model.CID];
    
}
@end
