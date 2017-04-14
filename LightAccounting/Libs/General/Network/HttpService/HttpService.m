//
//  HttpService.m
//  DLZHelpers
//
//  Created by 李方超 on 15/12/14.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import "HttpService.h"

@implementation HttpService

-(instancetype)initWithClass:(Class)targetClass{
    self = [self init];
    if (self) {
        modelClass = targetClass;
    }
    return self;
}

#pragma mark---get请求
//get方式请求网络
-(void)downloadData:(NSString *)path identify:(NSString*)identify{
    @try {
        path = NETWORK_URL(path);
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        //自动增加uid的get参数
//        APP_USER_MODEL *currentUser = [[NSUserDefaults standardUserDefaults] rm_customObjectForKey:CONST_USERDEFAULT_APPUSERINFO];
//        NSString *uid=@"";
//        if (currentUser) {
//            if (currentUser.User) {
//                uid = currentUser.User.UID;
//            }
//        }
//        NSRange range = [path rangeOfString:@"uid="];
//        if (range.location==NSNotFound) {
//            NSRange rangeLastChar = [path rangeOfString:@"?"];
//            if (rangeLastChar.location==NSNotFound) {
//                path = [path stringByAppendingFormat:@"?uid=%@",uid];
//            }
//            else{
//                path = [path stringByAppendingFormat:@"&uid=%@",uid];
//            }
//        }
        [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            DDLogDebug(@"请求时间:%@,请求地址:%@",[CommonFunc getCurrentDate],path);
            //            NSData *data = [completedOperation responseData];
            //            NSDictionary *resDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSError *error = nil;
            id obj = [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:responseObject error:&error];
            if (error!=nil && obj!=nil) {
                if(self.requestDelegate){
                    [self.requestDelegate dealWithResponse:obj identify:identify];
                }
            }else{
                if(self.requestDelegate){
                    [self.requestDelegate dealWithResponse:nil identify:identify];
                }
//                DDLogDebug(@"请求错误:%@,请求地址:%@,错误消息:%@",[CommonFunc getCurrentDate],path,obj.Message);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if(self.requestDelegate){
                [self.requestDelegate dealWithResponse:nil identify:identify];
            }
            DDLogDebug(@"请求错误:%@,请求地址:%@,错误消息:%@",[CommonFunc getCurrentDate],path,error);
        }];
        
        
    }
    @catch (NSException *exception) {
        DDLogDebug(@"请求错误:%@,错误消息:%@",[CommonFunc getCurrentDate],exception);
    }
    @finally {
        
    }
}

//get方式请求网络,带回调代码快
-(void)downloadDataWithCallBack:(NSString *)path identify:(NSString*)identify callCompleted:(void (^)(ServiceModel * data,NSString * identify))callCompleted{
    @try {
        path = NETWORK_URL(path);
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        //自动增加uid的get参数
//        APP_USER_MODEL *currentUser = [[NSUserDefaults standardUserDefaults] rm_customObjectForKey:CONST_USERDEFAULT_APPUSERINFO];
//        NSString *uid=@"";
//        if (currentUser) {
//            if (currentUser.User) {
//                uid = currentUser.User.UID;
//            }
//        }
//        NSRange range = [path rangeOfString:@"uid="];
//        if (range.location==NSNotFound) {
//            NSRange rangeLastChar = [path rangeOfString:@"?"];
//            if (rangeLastChar.location==NSNotFound) {
//                path = [path stringByAppendingFormat:@"?uid=%@",uid];
//            }
//            else{
//                path = [path stringByAppendingFormat:@"&uid=%@",uid];
//            }
//        }
        //end
        
        [manager GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            DDLogDebug(@"请求时间:%@,请求地址:%@",[CommonFunc getCurrentDate],path);
            //            NSData *data = [completedOperation responseData];
            //            NSDictionary *resDict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
            NSError *error = nil;
            id obj = [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:responseObject error:&error];
            if (error!=nil && obj!=nil) {
                if(callCompleted){
                    callCompleted(obj,identify);
                }
            }else{
                if(callCompleted){
                    callCompleted(nil,identify);
                }
//                DDLogDebug(@"请求错误:%@,请求地址:%@,错误消息:%@",[CommonFunc getCurrentDate],path,obj.Message);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if(callCompleted){
                callCompleted(nil,identify);
            }
            DDLogDebug(@"请求错误:%@,请求地址:%@,错误消息:%@",[CommonFunc getCurrentDate],path,error);
        }];
    }
    @catch (NSException *exception) {
        DDLogDebug(@"请求错误:%@,错误消息:%@",[CommonFunc getCurrentDate],exception);
        if(callCompleted){
            callCompleted(nil,identify);
        }
    }
    @finally {
    }
}

#pragma mark---post请求
//post方式请求网络
-(void)downloadData:(NSString *)path params:(NSMutableDictionary*) params identify:(NSString*)identify
{
    @try {
        path = NETWORK_URL(path);
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        //自动增加uid的get参数
//        APP_USER_MODEL *currentUser = [[NSUserDefaults standardUserDefaults] rm_customObjectForKey:CONST_USERDEFAULT_APPUSERINFO];
//        NSString *uid=@"";
//        if (currentUser) {
//            if (currentUser.User) {
//                uid = currentUser.User.UID;
//            }
//        }
//        id range = [params objectForKey:@"uid"];
//        if (range == nil) {
//            [params setObject:uid forKey:@"uid"];
//        }
        //end
        [manager POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            DDLogDebug(@"请求时间:%@,请求地址:%@",[CommonFunc getCurrentDate],path);
            //            NSData *data = [operation responseData];
            //            NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:	
            //                                     NSJSONReadingAllowFragments error:nil];
            NSError *error = nil;
            id obj = [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:responseObject error:&error];
            if (error!=nil && obj!=nil) {
                if(self.requestDelegate){
                    [self.requestDelegate dealWithResponse:obj identify:identify];
                }
            }else{
                if(self.requestDelegate){
                    [self.requestDelegate dealWithResponse:nil identify:identify];
                }
//                DDLogDebug(@"请求错误:%@,请求地址:%@,错误消息:%@",[CommonFunc getCurrentDate],path,obj.Message);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if(self.requestDelegate){
                [self.requestDelegate dealWithResponse:nil identify:identify];
            }
            DDLogDebug(@"请求错误:%@,请求地址:%@,错误消息:%@",[CommonFunc getCurrentDate],path,error);
        }];
    }
    @catch (NSException *exception) {
        if(self.requestDelegate){
            [self.requestDelegate dealWithResponse:nil identify:identify];
        }
        DDLogDebug(@"请求错误:%@,错误消息:%@",[CommonFunc getCurrentDate],exception);
    }
    @finally {
        
    }
}

//post方式请求网络,带回调代码块
-(void)downloadDataWithCallBack:(NSString *)path params:(NSMutableDictionary*) params identify:(NSString*)identify callCompleted:(void (^)(id data,NSString * identify))callCompleted
{
    @try {
        path = NETWORK_URL(path);
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        //自动增加uid的get参数
//        APP_USER_MODEL *currentUser = [[NSUserDefaults standardUserDefaults] rm_customObjectForKey:CONST_USERDEFAULT_APPUSERINFO];
//        NSString *uid=@"";
//        if (currentUser) {
//            if (currentUser.User && currentUser.User.UID) {
//                uid = currentUser.User.UID;
//            }
//        }
//        id range = [params objectForKey:@"uid"];
//        if (range == nil) {
//            [params setObject:uid forKey:@"uid"];
//        }
        //end
        [manager POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            DDLogDebug(@"请求时间:%@,请求地址:%@",[CommonFunc getCurrentDate],path);
            //            NSData *data = [operation responseData];
            //            NSDictionary *resDict = [NSJSONSerialization JSONObjectWithData:data options:
            //                                     NSJSONReadingAllowFragments error:nil];
            NSError *error = nil;
            id obj = [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:responseObject error:&error];
            if (error==nil && obj!=nil) {
                if(callCompleted){
                    callCompleted(obj,identify);
                }
            }else{
                if(callCompleted){
                    callCompleted(nil,identify);
                }
//                DDLogDebug(@"请求错误:%@,请求地址:%@,错误消息:%@",[CommonFunc getCurrentDate],path,obj.Message);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if(callCompleted){
                callCompleted(nil,identify);
            }
            DDLogDebug(@"请求错误:%@,请求地址:%@,错误消息:%@",[CommonFunc getCurrentDate],path,error);
        }];
    }
    @catch (NSException *exception) {
        DDLogDebug(@"请求错误:%@,错误消息:%@",[CommonFunc getCurrentDate],exception);
    }
    @finally {
        
    }
}

#pragma mark---普通上传
-(void)uploadRequestWithCallBack:(NSString *)path params:(NSMutableDictionary*) params datas:(NSData *)datas fileName:(NSString *)fileName fileType:(NSString *)fileType identify:(NSString*)identify callCompleted:(void (^)(ServiceModel * data,NSString * identify))callCompleted{
    @try {
        path = NETWORK_URL(path);
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        //自动增加uid的get参数
//        APP_USER_MODEL *currentUser = [[NSUserDefaults standardUserDefaults] rm_customObjectForKey:CONST_USERDEFAULT_APPUSERINFO];
//        NSString *uid=@"";
//        if (currentUser) {
//            if (currentUser.User && currentUser.User.UID) {
//                uid = currentUser.User.UID;
//            }
//        }
//        id range = [params objectForKey:@"uid"];
//        if (range == nil) {
//            [params setObject:uid forKey:@"uid"];
//        }
        [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:datas name:@"file" fileName:fileName mimeType:fileType];
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError *error = nil;
            id obj = [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:responseObject error:&error];
            if (error!=nil && obj!=nil) {
                if(callCompleted){
                    callCompleted(obj,identify);
                }
            }else{
                if(callCompleted){
                    callCompleted(nil,identify);
                }
//                DDLogDebug(@"请求错误:%@,请求地址:%@,错误消息:%@",[CommonFunc getCurrentDate],path,obj.Message);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if(callCompleted){
                callCompleted(nil,identify);
            }
            DDLogDebug(@"请求错误:%@,请求地址:%@,错误消息:%@",[CommonFunc getCurrentDate],path,error);
        }];
    }
    @catch (NSException *exception) {
        DDLogDebug(@"请求错误:%@,错误消息:%@",[CommonFunc getCurrentDate],exception);
    }
    @finally {
        
    }
}

-(void)uploadRequest:(NSString *)path params:(NSMutableDictionary*) params datas:(NSData *)datas fileName:(NSString *)fileName fileType:(NSString *)fileType identify:(NSString*)identify{
    @try {
        path = NETWORK_URL(path);
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        //自动增加uid的get参数
//        APP_USER_MODEL *currentUser = [[NSUserDefaults standardUserDefaults] rm_customObjectForKey:CONST_USERDEFAULT_APPUSERINFO];
//        NSString *uid=@"";
//        if (currentUser) {
//            if (currentUser.User && currentUser.User.UID) {
//                uid = currentUser.User.UID;
//            }
//        }
//        id range = [params objectForKey:@"uid"];
//        if (range == nil) {
//            [params setObject:uid forKey:@"uid"];
//        }
        [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:datas name:@"file" fileName:fileName mimeType:fileType];
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError *error = nil;
            id obj = [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:responseObject error:&error];
            if (error!=nil && obj!=nil) {
                if(self.requestDelegate){
                    [self.requestDelegate dealWithResponse:obj identify:identify];
                }
            }else{
                if(self.requestDelegate){
                    [self.requestDelegate dealWithResponse:nil identify:identify];
                }
//                DDLogDebug(@"请求错误:%@,请求地址:%@,错误消息:%@",[CommonFunc getCurrentDate],path,obj.Message);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if(self.requestDelegate){
                [self.requestDelegate dealWithResponse:nil identify:identify];
            }
            DDLogDebug(@"请求错误:%@,请求地址:%@,错误消息:%@",[CommonFunc getCurrentDate],path,error);
        }];
    }
    @catch (NSException *exception) {
        DDLogDebug(@"请求错误:%@,调用方法:BGHttpService.uploadRequest,错误消息:%@",[CommonFunc getCurrentDate],exception);
    }
    @finally {
        
    }
}

#pragma mark---带有进度条的上传
-(void)uploadRequestWithProgress:(NSString *)path params:(NSMutableDictionary*) params datas:(NSData *)datas fileName:(NSString *)fileName fileType:(NSString *)fileType identify:(NSString*)identify index:(int)index{
    @try {
        path = NETWORK_URL(path);
        //自动增加uid的get参数
//        APP_USER_MODEL *currentUser = [[NSUserDefaults standardUserDefaults] rm_customObjectForKey:CONST_USERDEFAULT_APPUSERINFO];
//        NSString *uid=@"";
//        if (currentUser) {
//            if (currentUser.User && currentUser.User.UID) {
//                uid = currentUser.User.UID;
//            }
//        }
//        id range = [params objectForKey:@"uid"];
//        if (range == nil) {
//            [params setObject:uid forKey:@"uid"];
//        }
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        AFHTTPRequestOperation *operation = [manager POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            [formData appendPartWithFileData:datas name:@"file" fileName:fileName mimeType:fileType];
            
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError *error = nil;
            id obj = [MTLJSONAdapter modelOfClass:modelClass fromJSONDictionary:responseObject error:&error];
            if (error!=nil && obj!=nil) {
                if(self.requestDelegate){
                    [self.requestDelegate dealWithProgressCompleted:obj identify:identify index:index];
                }
            }else{
                if(self.requestDelegate){
                    [self.requestDelegate dealWithProgressCompleted:nil identify:identify index:index];
                }
//                DDLogDebug(@"请求错误:%@,请求地址:%@,错误消息:%@",[CommonFunc getCurrentDate],path,obj.Message);
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            if(self.requestDelegate){
                [self.requestDelegate dealWithResponse:nil identify:identify];
            }
            DDLogDebug(@"请求错误:%@,请求地址:%@,错误消息:%@",[CommonFunc getCurrentDate],path,error);
        }];
        [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
            if (self.requestDelegate) {
                if (totalBytesWritten<totalBytesExpectedToWrite) {
                    [self.requestDelegate dealWithProgress:NO progress:(double)totalBytesWritten/totalBytesExpectedToWrite identify:identify index:index];
                }
                else{
                    [self.requestDelegate dealWithProgress:YES progress:1 identify:identify index:index];
                }
            }
        }];
        [operation start];
    }
    @catch (NSException *exception) {
        DDLogDebug(@"请求错误:%@,调用方法:BGHttpService.uploadRequestWithProgress,错误消息:%@",[CommonFunc getCurrentDate],exception);
    }
    @finally {
        
    }
}

#pragma mark---文件下载
-(void)downloadFile:(NSString *)path identify:(NSString*)identify{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSString *fpath = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle]resourcePath],response.suggestedFilename];
        NSURL *fileURL = [NSURL fileURLWithPath:fpath];
        return fileURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        DDLogDebug(@"请求下载:%@,请求地址:%@,错误消息:%@",[CommonFunc getCurrentDate],path,error);
        if(self.requestDelegate){
            [self.requestDelegate dealWithCallback:filePath identify:identify];
        }
    }];
    [task resume];
}

-(void)downloadFile:(NSString *)path identify:(NSString*)identify callCompleted:(void (^)(NSURLResponse *response, NSURL *filePath))callCompleted{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:path];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        BOOL isDir = NO;
        BOOL isDirExist = [fileManager fileExistsAtPath:[NSString stringWithFormat:@"%@/data",[[NSBundle mainBundle] resourcePath]] isDirectory:&isDir];
        if(!(isDirExist && isDir))
            
        {
            BOOL bCreateDir = [fileManager createDirectoryAtPath:[NSString stringWithFormat:@"%@/data",[[NSBundle mainBundle] resourcePath]] withIntermediateDirectories:YES attributes:nil error:nil];
            if(!bCreateDir){
                DDLogDebug(@"Create data Directory Failed.");
            }
        }
        
        NSString *fpath = [NSString stringWithFormat:@"%@/%@/%@",[[NSBundle mainBundle]resourcePath],@"data",response.suggestedFilename];
        NSURL *fileURL = [NSURL fileURLWithPath:fpath];
        return fileURL;
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        DDLogDebug(@"请求下载:%@,请求地址:%@,错误消息:%@",[CommonFunc getCurrentDate],path,error);
        if(callCompleted){
            callCompleted(response,filePath);
        }
    }];
    [task resume];
}

+ (NSData *) httpGetData:(NSString *)url{
    NSMutableURLRequest *myRequest = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString:url] ];
    //[myRequest setValue:[self getCookie] forHTTPHeaderField:@"Cookie"];
    
    NSData *returnData = [ NSURLConnection sendSynchronousRequest:myRequest returningResponse:nil error:nil];
    return returnData;
}
+ (void) httpGetData:(NSString *)url complete:(void(^)(id result))doWhat {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 耗时的操作
        NSData *returnData = [HttpService httpGetData:url];
        dispatch_async(dispatch_get_main_queue(), ^{
            doWhat(returnData);
        });
    });
}

@end
