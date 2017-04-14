//
//  ArchiverCache.m
//  DLZProject
//
//  Created by ddllzz on 16/12/22.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "ArchiverCache.h"

@implementation ArchiverCache

/*!
 *  @brief 归档对象
 *
 *  @param cacheName 缓存文件名称
 *  @param obj       缓存目标对象
 *
 *  @since 1.0
 */
+(void)saveToFile:(nonnull NSString *)cacheName obj:(nonnull NSObject *)obj{
    NSString *docpath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *targetpath = [NSString stringWithFormat:@"%@/%@",docpath,cacheName];
    NSLog(@"缓存文件路径%@",targetpath);
    [NSKeyedArchiver archiveRootObject:obj toFile:targetpath];
}
/*!
 *  @brief 解档文件
 *
 *  @param cacheName 缓存文件名称
 *
 *  @return 被解档的对象
 *
 *  @since 1.0
 */
+(nullable id)getFromFile:(nonnull NSString *)cacheName{
    NSString *docpath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *targetpath = [NSString stringWithFormat:@"%@/%@",docpath,cacheName];
    NSLog(@"缓存文件路径%@",targetpath);
    return [NSKeyedUnarchiver unarchiveObjectWithFile:targetpath];
}
/*!
 *  @brief 删除缓存文件
 *
 *  @param cacheName 缓存文件名称
 *
 *  @since 1.0
 */
+(void)deleteCache:(nonnull NSString *)cacheName{
    NSString *docpath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *targetpath = [NSString stringWithFormat:@"%@/%@",docpath,cacheName];
    NSLog(@"缓存文件路径%@",targetpath);
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    [fileMgr removeItemAtPath:targetpath error:nil];
}

@end
