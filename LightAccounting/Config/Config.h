//
//  Config.h
//  DLZProject
//
//  Created by ddllzz on 16/11/16.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#ifndef Config_h
#define Config_h

static const double request_download_timeout = 60;

#define currentVersion @"1.0"

#define windowSize [UIScreen mainScreen].bounds;

#define ScreenSize [UIScreen mainScreen].bounds.size

#define StatusSize [[UIApplication sharedApplication] statusBarFrame].size

#define systemversion [[[UIDevice currentDevice] systemVersion] floatValue]
/*!
 *  @brief 十六进制long整型转颜色UIColor值
 *
 *  @param rgbValue 要转换的十六进制数值
 *
 *  @return UIColor对象
 *
 *  @since 1.0
 */
#define UIColorFromRGB(rgbValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]
/*!
 *  @brief 判断ios当前版本是否大于某个版本
 *
 *  @param version 被比较的版本
 *
 *  @return 大于返回YES
 *
 *  @since 1.0
 */
#define compareSystemVersion(version) [[[UIDevice currentDevice] systemVersion] floatValue] >= version


#endif /* Config_h */
