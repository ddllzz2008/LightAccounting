//
//  ChartViewModel.m
//  LightAccounting
//
//  Created by ddllzz on 17/8/18.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "ChartViewModel.h"

@implementation ChartViewModel

- (NSString *)minvalue{
    
    return minvalue;
    
}
- (NSString *)maxvalue{
    
    return maxvalue;
    
}
- (NSArray<NSString *> *)categories{
    
    return categories;
    
}
- (BOOL)isoutlet{
    
    return isoutlet;
    
}
- (BOOL)isprivate{
    
    return isprivate;
    
}
/**
 设置筛选条件
 
 @param min 最低消费
 @param max 最大消费
 @param cids 类别
 */
- (void)setFilter:(NSInteger)type min:(NSString *)min max:(NSString *)max cids:(NSArray<NSString *> *)cids outlet:(BOOL)outlet private:(BOOL)private{
    
    _currentType = type;
    minvalue = min;
    maxvalue = max;
    categories = cids;
    isoutlet = outlet;
    isprivate = private;
    
}

/**
 加载类别
 
 @return 类别集合
 */
-(NSMutableArray *)loadCategory{
    
    return [[CategoryDAL Instance] getCategory:-1];
    
}

@end
