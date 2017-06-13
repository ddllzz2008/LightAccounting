//
//  BaseViewModel.m
//  DLZProject
//
//  Created by ddllzz on 16/11/22.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "BaseViewModel.h"

@implementation BaseViewModel

static NSString *familycachestring = @"familycachestring";

/**
 获取账本列表

 @return <#return value description#>
 */
-(NSArray *)getFamilyAccounts{
    NSArray *array = [[FamilyPersonDAL Instance] getFamilyPersons];
    return array;
}
/**
 获取默认账本

 @return <#return value description#>
 */
-(FamilyPerson *)getDefaultFamily{
    
    NSData *data = [[StoreUserDefault instance] getDataWithNSData:familycachestring];
    
    if (data!=nil) {
        FamilyPerson *person = [NSKeyedUnarchiver unarchiveObjectWithData:data] ;
        return person;
    }else{
        NSArray *array = [[FamilyPersonDAL Instance] getFamilyPersons];
        if (array!=nil && array.count>0) {
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[array objectAtIndex:0]];
            
            [[StoreUserDefault instance] setData:familycachestring data:data];
            return [array objectAtIndex:0];
        }else{
            return nil;
        }
    }

}

/**
 设置默认账本

 @param familyid <#familyid description#>
 @return <#return value description#>
 */
-(BOOL)setDefaultFamily:(NSString *)familyid{
    
    NSArray *array = [[FamilyPersonDAL Instance] getFamilyPersons];
    if (array!=nil && array.count>0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fid==%@",familyid];
        NSArray *result = [array filteredArrayUsingPredicate:predicate];
        if (result!=nil && result.count>0) {
            
            NSData *data = [NSKeyedArchiver archivedDataWithRootObject:[result objectAtIndex:0]];
            
            [[StoreUserDefault instance] setData:familycachestring data:data];
            
        }
        return YES;
        
    }else{
        return NO;
    }
    
}

@end
