//
//  ExpendVoiceViewModel.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/12.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "ExpendVoiceViewModel.h"

@implementation ExpendVoiceViewModel

-(void)startRecognize{
    
    if (self.iFlySpeechRecognizer==nil) {
        self.iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    }
    [self.iFlySpeechRecognizer setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
    //asr_audio_path 是录音文件名，设置value为nil或者为空取消保存，默认保存目录在Library/cache下。
    [self.iFlySpeechRecognizer setParameter:@"iat.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    self.iFlySpeechRecognizer.delegate=self;
    //启动识别服务
    [self.iFlySpeechRecognizer startListening];
    
//    [self.iFlySpeechRecognizer stopListening];
    
}

//识别结果返回代理
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    NSLog(@"%@",results);
    
    NSLog(@"说完了...");
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    
    NSDictionary *dic = results[0];
    
    for (NSString *key in dic) {
        
        [resultString appendFormat:@"%@",key];
        
    }
    
    NSString * resultFromJson =  [ISRDataHelper    stringFromJson:resultString];
    
    self.voiceStr = [NSString stringWithFormat:@"%@%@",    self.voiceStr,resultFromJson];
    
    if (isLast){//是否是最后一次回调 因为此方法会调用多次
        
        NSLog(@"听写结果(json)：%@测试",  self.voiceStr);
        
        if (self.voiceStr.length>0) {
            
        }
        
        else{
            
            NSLog(@"未检测到");
            
        }
        
    }
    
}

- (void)onError: (IFlySpeechError *) error{
    
}

@end
