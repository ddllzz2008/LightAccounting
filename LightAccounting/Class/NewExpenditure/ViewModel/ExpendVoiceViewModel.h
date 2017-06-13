//
//  ExpendVoiceViewModel.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/12.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewModel.h"
#import <iflyMSC/IFlyRecognizerViewDelegate.h>
#import <iflyMSC/IFlySpeechRecognizer.h>
#import <iflyMSC/IFlySpeechConstant.h>
//#import <iflyMSC/ISRDataHelper.h>

@interface ExpendVoiceViewModel : BaseViewModel<IFlySpeechRecognizerDelegate>

@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;


/**
 启动语音识别
 */
-(void)startRecognize;

@end
