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

@interface BillViewModel : BaseViewModel

@property (nonatomic,strong) NSArray *source;

/**
 加载类别
 
 @return <#return value description#>
 */
-(NSMutableArray *)loadCategory;

@end
