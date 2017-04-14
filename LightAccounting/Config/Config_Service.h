//
//  Config_Service.h
//  DLZProject
//
//  Created by ddllzz on 16/11/21.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#ifndef Config_Service_h
#define Config_Service_h

//网络请求
//生产环境
//#define NETWORKSERVICE_DOMAIN @"139.224.64.50"
//#define NETWORKSERVICE_PORT @"8081"
//开发环境
#define NETWORKSERVICE_DOMAIN @"139.196.215.187"
#define NETWORKSERVICE_PORT @"8081"

#define NETWORK_URL(API) [NSString stringWithFormat:@"http://%@:%@/%@",NETWORKSERVICE_DOMAIN,NETWORKSERVICE_PORT,API]

#pragma mark---user moudle
#define WEBAPI_RegisterUserByPhone @"api/UserAsync/RegisterUserByPhone"
#define WEBAPI_SendSMS @"api/SmsAsync/SendSMS"
#define WEBAPI_LOGIN @"api/Account/Login"
#define WEBAPI_STATICDATA @"api/BasicInfo/StaticData"

#pragma mark---request states
#define REQUEST_START @"start"
#define REQUEST_END @"end"
#define REQUEST_SUCCESS @"success"
#define REQUEST_ASYNC @"async"
#define REQUEST_ERROR @"error"
#define REQUEST_TIMEOUT @"timeout"

#pragma mark---cache file
#define CACHE_CURRENTUSER @"CACHE_CURRENTUSER"
#define CACHE_LOGINCREDENTIAL @"logincredential.plist"
#define CACHE_LOGINMODEL @"loginmodel.plist"
#define CACHE_STATICDATA @"staticdata.plist"
//#define CACHE_LOGINCREDENTIAL @"logincredential.plist"
//#define CACHE_LOGINCREDENTIAL @"logincredential.plist"

#endif /* Config_Service_h */
