//
//  ChartViewModel.h
//  LightAccounting
//
//  Created by ddllzz on 17/8/18.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewModel.h"
#import "CategoryDAL.h"

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

@end
