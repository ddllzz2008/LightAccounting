//
//  LoginViewModel.m
//  DLZProject
//
//  Created by ddllzz on 16/11/21.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "LoginViewModel.h"
#import "LoginModel.h"
#import "HttpService.h"
#import "ArchiverCache.h"
#import "NSString+ExtMethod.h"

@implementation LoginViewModel

- (id)init {
    self = [super init];
    if (self) {
        //[self loadLoginModel];
        
    }
    return self;
}

-(void)loadLoginModel{
    UserModel *model = [ArchiverCache getFromFile:CACHE_LOGINMODEL];
    if (model) {
        self.userName = model.Code;
    }
}

/*!
 *  @brief 获取验证码
 *
 *  @return 验证码信号
 *
 *  @since 1.0
 */
-(RACCommand *)getCodeCommand{
    if(!_getCodeCommand){
        @weakify(self);
        _getCodeCommand = [[RACCommand alloc] initWithEnabled:self.codeValidSignal signalBlock:^RACSignal *(id input) {
            @strongify(self);
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                DDLogDebug(@"loginstart");
                [subscriber sendNext:REQUEST_START];
                
                NSString *url = [NSString stringWithFormat:@"api/sms/GenerateSmsCode?mobile=%@",self.telphone];
                
                HttpService *service = [HttpService new];
                [service downloadDataWithCallBack:url params:nil identify:nil callCompleted:^(ServiceModel *data, NSString *identify) {
                    @try {
                        if (data!=nil&&[data.Code isEqualToString:@"100"]) {
                            
                        }else{
                            [subscriber sendNext:data.Message];
                        }
                    }
                    @catch (NSException *exception) {
                        DDLogError(@"%@",exception);
                    }
                    @finally {
                        [subscriber sendNext:REQUEST_END];
                        [subscriber sendCompleted];
                    }
                }];
                
                            
//                dispatch_queue_t httpQue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//                dispatch_async(httpQue, ^{
//                    
//                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), httpQue, ^{
//                       
//                       
//                       DDLogDebug(@"loginfinished");
//                       
//                       [subscriber sendNext:@"over"];
//                       [subscriber sendCompleted];
//                       
//                   });
//                    
//                });
                
                
                return nil;
            }];
        }];
    }
    return _getCodeCommand;
}

- (RACSignal *)codeValidSignal {
    if (!_codeValidSignal) {
        _codeValidSignal = [RACObserve(self, codeGetTime) map:^id(NSNumber *code) {
            return @(code.intValue == 0);
        }];
    }
    return _codeValidSignal;
}

/*!
 *  @brief 用户登录
 *
 *  @return 登录信号
 *
 *  @since 1.0
 */
-(RACCommand*)loginCommand{
    if(!_loginCommand){
        @weakify(self);
        _loginCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                if(self.loginType==0){
                    
                    [subscriber sendNext:REQUEST_SUCCESS];
                    [subscriber sendCompleted];
                    
                    return nil;
                    
                    //用户名密码登录
                    if ([self.userName isBlankString]) {
                        [subscriber sendNext:@"请输入用户名"];
                        [subscriber sendCompleted];
                    }else if ([self.userpassword isBlankString]){
                        [subscriber sendNext:@"请输入密码"];
                        [subscriber sendCompleted];
                    }else{
                        HttpService *service = [[HttpService alloc] initWithClass:[LoginModel class]];
                        
                        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
                        [dic setObject:self.userName forKey:@"UserName"];
                        [dic setObject:self.userpassword forKey:@"Password"];
                        [dic setObject:@"123" forKey:@"IMEI"];
                        [dic setObject:@"1.0" forKey:@"Version"];
                        [dic setObject:@"ios" forKey:@"Platform"];
                        [dic setObject:@"false" forKey:@"isMD5"];
                        
                        
                        [service downloadDataWithCallBack:WEBAPI_LOGIN params:dic identify:WEBAPI_LOGIN callCompleted:^(id result, NSString *identify) {
                            @try {
//                                LoginModel *data = (LoginModel *)result;
//                                if (data!=nil&&[data.Code isEqualToString:@"100"]) {
//                                    
//                                    [dic setObject:data.Data.Password forKey:@"Password"];
//                                    [dic setObject:@"true" forKey:@"isMD5"];
//                                    
//                                    [ArchiverCache saveToFile:CACHE_LOGINCREDENTIAL obj:dic];
//                                    
//                                    [ArchiverCache saveToFile:CACHE_LOGINMODEL obj:data.Data];
//                                    
//                                    [[StoreUserDefault instance] setData:CACHE_CURRENTUSER data:data.Data];
//                                    
//                                    HttpService *staticservice = [[HttpService alloc] initWithClass:[StaticDataModel class]];
//                                    
//                                    [staticservice downloadDataWithCallBack:WEBAPI_STATICDATA params:dic identify:WEBAPI_STATICDATA callCompleted:^(id mdata, NSString *identify) {
//                                        @try {
//                                            StaticDataModel *model = (StaticDataModel *)mdata;
//                                            [ArchiverCache saveToFile:CACHE_STATICDATA obj:model.Data];
//                                            [subscriber sendNext:REQUEST_SUCCESS];
//                                        }
//                                        @catch (NSException *exception) {
//                                            DDLogError(@"%@",exception);
//                                            [subscriber sendNext:REQUEST_ERROR];
//                                        }
//                                        @finally {
//                                            [subscriber sendCompleted];
//                                        }
//                                    }];
//                                    
//                                    [subscriber sendNext:REQUEST_ASYNC];
//                                }else{
//                                    [subscriber sendNext:data.Message];
//                                }
                            }
                            @catch (NSException *exception) {
                                DDLogError(@"%@",exception);
                                [subscriber sendNext:REQUEST_ERROR];
                                [subscriber sendCompleted];
                            }
                            @finally {

                            }
                        }];
                        
                        [subscriber sendNext:REQUEST_START];
                    }
                }else{
                    //手机号验证码登录
                }
                
                return nil;
            }];
        }];
    }
    return _loginCommand;
}

#pragma mark---UI相关

/*!
 *  @brief 销毁
 *
 *  @since 1.0
 */
-(void)dealloc{
    
}

@end
