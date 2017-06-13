//
//  CategoryDAL.h
//  HomeAPP
//
//  Created by ddllzz on 16/4/19.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoryModel.h"
#import "FmdbHelper.h"
#import "MTLJSONAdapter.h"
#import "NSString+ExtMethod.h"

@interface CategoryDAL : NSObject

+(CategoryDAL*)Instance;

-(NSMutableArray *)getCategory:(NSInteger)type;

/*
 *---------------------------添加类别---------------------------------------------*
 */
-(CategoryModel *)addCategory:(CategoryModel *)model;
/*
 *---------------------------修改类别---------------------------------------------*
 */
-(BOOL)updateCategory:(CategoryModel *)model;
/*
 *---------------------------删除类别---------------------------------------------*
 */
-(BOOL)deleteCategory:(NSString*)cid;

@end
