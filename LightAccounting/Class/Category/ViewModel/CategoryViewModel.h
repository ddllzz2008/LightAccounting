//
//  CategoryViewModel.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/13.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewModel.h"
#import "CategoryModel.h"
#import "CategoryDAL.h"

@interface CategoryViewModel : BaseViewModel

@property (nonatomic,strong) CategoryModel *model;

/**
 获取收入类别

 @return <#return value description#>
 */
-(NSMutableArray *)getIncomeCategory;

/**
 获取支出类别

 @return <#return value description#>
 */
-(NSMutableArray *)getExpendCategory;

/**
 检查类别

 @return <#return value description#>
 */
-(NSString *)checkCategory;
/**
 增加收入类别

 @return <#return value description#>
 */
-(CategoryModel *)addCategory;

/**
 修改类别

 @return <#return value description#>
 */
-(BOOL)updateCategory;

/**
 删除类别

 @return <#return value description#>
 */
-(BOOL)deleteCategory;

@end
