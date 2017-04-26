//
//  Config_Style.h
//  DLZProject
//
//  Created by ddllzz on 16/11/18.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#ifndef Config_Style_h
#define Config_Style_h

//define style
#define color_theme_green 0xA6D157
#define get_theme_color [[StoreUserDefault instance] getDataWithString:appcache_themecolor]==nil?UIColorFromRGB(0xA6D157):[UIColor colorWithHexString:[[StoreUserDefault instance] getDataWithString:appcache_themecolor]]
//define color
#define color_blue_01 0x347aea
#define color_blue_02 0x3667b7
#define color_blue_03 0x84a4d8
#define color_blue_04 0x19254f//左侧菜单背景颜色
#define color_blue_05 0x2f395d//左侧菜单边框颜色
#define color_blue_06 0x35bcf8
#define color_white_01 0xffffff
#define color_gray_01 0x91a2bc
#define color_gray_02 0x9fa9b5
#define color_gray_03 0xd8d8d8
#define color_gray_04 0xeeeeee
#define color_gray_05 0xcccccc
#define color_gray_06 0xf2f2f2
#define color_yellow_01 0xfab807
#define color_black_01 0x333333
#define color_red_01 0xee2d4a

#define color_font_01 0x916a01
#define color_font_02 0xffffff
#define color_font_03 0x3667b7
#define color_font_04 0x333333
#define color_font_05 0xbed0f8
#define color_font_06 0x343434
#define color_font_07 0x6d9cee
#define color_font_08 0xcccccc
#define color_font_09 0xed2c4b
#define color_font_10 0x35bcf8

#define fontsize_32 [UIFont fontWithName:@"Arial" size:32]
#define fontsize_26 [UIFont fontWithName:@"Arial" size:26]
#define fontsize_24 [UIFont fontWithName:@"Arial" size:24]
#define fontsize_22 [UIFont fontWithName:@"Arial" size:22]
#define fontsize_20 [UIFont fontWithName:@"Arial" size:20]
#define fontsize_18 [UIFont fontWithName:@"Arial" size:18]
#define fontsize_16 [UIFont fontWithName:@"Arial" size:16]
#define fontsize_14 [UIFont fontWithName:@"Arial" size:14]
#define fontsize_13 [UIFont fontWithName:@"Arial" size:13]

#define color_navigation_bar 0x347aea

/*----------------全局文件存储key----------------------*/
#define datastore_familyArray @"datastore_familyArray"
#define appcache_themecolor @"appcache_themecolor"

/*-------------------date format-----------------------*/
#define dateformat_01 @"yyyy年MM月"
#define dateformat_02 @"yyyy年"
#define dateformat_03 @"yyyy-MM-dd"
#define dateformat_04 @"yyyy"
#define dateformat_05 @"yyyyMM"
#define dateformat_06 @"yyyyMMdd"
#define dateformat_07 @"yyyy-MM-dd HH:mm:ss"
#define dateformat_08 @"yyyy-MM-dd 00:00:00"
#define dateformat_09 @"yyyy-MM-dd 23:59:59"
#define dateformat_10 @"yyyy年MM月dd日"
#define dateformat_11 @"MM-dd HH:mm"


#endif /* Config_Style_h */
