//
//  LoginViewModel.h
//  DLZProject
//
//  Created by ddllzz on 16/11/21.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject{
    
    
    
}

#pragma mark---UI相关

-(void)loadLoginModel;

#pragma mark---输入
@property(nonatomic,strong,readwrite) NSString *telphone;

@property(nonatomic,strong,readwrite) NSString *telcode;

@property (nonatomic,strong,readwrite) NSString *userName;

@property (nonatomic,strong,readwrite) NSString *userpassword;

#pragma mark---RAC
@property(nonatomic, strong) RACSignal *codeValidSignal;

@property (nonatomic,strong) RACCommand *loginCommand;

@property (nonatomic,strong,readwrite) RACCommand *getCodeCommand;

@property (nonatomic,assign) NSInteger codeGetTime;

@property (nonatomic,strong,readwrite) NSString *output;

@property (nonatomic,readwrite) NSInteger loginType;

-(void)dealloc;

@end
