//
//  ArchiverCache.h
//  DLZProject
//
//  Created by ddllzz on 16/12/22.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArchiverCache : NSObject

+(void)saveToFile:(nonnull NSString *)cacheName obj:(nonnull NSObject *)obj;

+(nullable id)getFromFile:(nonnull NSString *)cacheName;

+(void)deleteCache:(nonnull NSString *)cacheName;

@end
