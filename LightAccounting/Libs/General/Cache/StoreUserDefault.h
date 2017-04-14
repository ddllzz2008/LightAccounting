//
//  StoreUserDefault.h
//  DLZHelpers
//
//  Created by ddllzz on 16/4/22.
//  Copyright © 2016年 李方超. All rights reserved.
//
#import "DLZBaseStore.h"

@interface StoreUserDefault : NSObject<DLZBaseStore>

+(StoreUserDefault*)instance;

-(BOOL)saveData:(NSArray *)keyAndData;

-(NSData*)getDataWithNSData:(NSString *)key;

-(NSString *)getDataWithString:(NSString *)key;

-(NSArray *)getDataWithArray:(NSString *)key;

-(NSDictionary *)getDataWithDictionary:(NSString *)key;

-(void)setData:(NSString *)key data:(id)data;

@end
