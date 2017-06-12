//
//  BaseViewModel.h
//  DLZProject
//
//  Created by ddllzz on 16/11/22.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FamilyPerson.h"
#import "FamilyPersonDAL.h"

@interface BaseViewModel : NSObject

/**
 获取账本列表
 
 @return <#return value description#>
 */
-(NSArray *)getFamilyAccounts;
/**
 获取默认账本
 
 @return <#return value description#>
 */
-(FamilyPerson *)getDefaultFamily;

/**
 设置默认账本
 
 @param familyid <#familyid description#>
 @return <#return value description#>
 */
-(BOOL)setDefaultFamily:(NSString *)familyid;

@end
