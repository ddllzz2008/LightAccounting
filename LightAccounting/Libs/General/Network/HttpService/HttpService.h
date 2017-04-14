//
//  HttpService.h
//  DLZHelpers
//
//  Created by 李方超 on 15/12/14.
//  Copyright (c) 2015年 李方超. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceModel.h"
#import "HttpServiceCompleted.h"
#import "AFNetworking.h"
#import "HttpServiceAssistant.h"

@interface HttpService : NSObject{
    
    Class modelClass;
    
}

-(instancetype)initWithClass:(Class)targetClass;

//get方式请求网络
-(void)downloadData:(NSString *)path identify:(NSString*)identify;
//get方式请求网络,带回调代码快
-(void)downloadDataWithCallBack:(NSString *)path identify:(NSString*)identify callCompleted:(void (^)(ServiceModel * data,NSString * identify))callCompleted;
//post方式请求网络
-(void)downloadData:(NSString *)path params:(NSMutableDictionary*) params identify:(NSString*)identify;
//post方式请求网络,带回调代码块
-(void)downloadDataWithCallBack:(NSString *)path params:(NSMutableDictionary*) params identify:(NSString*)identify callCompleted:(void (^)(id data,NSString * identify))callCompleted;
//上传图片
-(void)uploadRequest:(NSString *)path params:(NSMutableDictionary*) params datas:(NSData *)datas fileName:(NSString *)fileName fileType:(NSString *)fileType identify:(NSString*)identify;

-(void)uploadRequestWithCallBack:(NSString *)path params:(NSMutableDictionary*) params datas:(NSData *)datas fileName:(NSString *)fileName fileType:(NSString *)fileType identify:(NSString*)identify callCompleted:(void (^)(ServiceModel * data,NSString * identify))callCompleted;
-(void)uploadRequestWithProgress:(NSString *)path params:(NSMutableDictionary*) params datas:(NSData *)datas fileName:(NSString *)fileName fileType:(NSString *)fileType identify:(NSString*)identify index:(int)index;
//下载文件
-(void)downloadFile:(NSString *)path identify:(NSString*)identify;
-(void)downloadFile:(NSString *)path identify:(NSString*)identify callCompleted:(void (^)(NSURLResponse *response, NSURL *filePath))callCompleted;

+ (NSData *) httpGetData:(NSString *)url;
+ (void) httpGetData:(NSString *)url complete:(void(^)(id result))doWhat;

@property (nonatomic, weak) id <HttpServiceCompleted> requestDelegate;

@end
