//
//  ExpendVoiceViewModel.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/12.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "ExpendVoiceViewModel.h"

@implementation ExpendVoiceViewModel

/**
 加载类别
 */
- (void)loadCategory{
    
    self.categoryArray = [[CategoryDAL Instance] getCategory:-1];
    
}

/**
 开始监听
 */
-(void)startRecognize{
    
    if (self.iFlySpeechRecognizer==nil) {
        self.iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    }
    [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
    //设置听写模式
    [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
//    [self.iFlySpeechRecognizer setParameter: @"iat" forKey: [IFlySpeechConstant IFLY_DOMAIN]];
//    //asr_audio_path 是录音文件名，设置value为nil或者为空取消保存，默认保存目录在Library/cache下。
//    [self.iFlySpeechRecognizer setParameter:@"iat.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
    self.iFlySpeechRecognizer.delegate=self;
    if (_iFlySpeechRecognizer != nil) {
        IATConfig *instance = [IATConfig sharedInstance];
        
        //设置最长录音时间
        [_iFlySpeechRecognizer setParameter:instance.speechTimeout forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [_iFlySpeechRecognizer setParameter:instance.vadEos forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [_iFlySpeechRecognizer setParameter:instance.vadBos forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        
        //设置采样率，推荐使用16K
        [_iFlySpeechRecognizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
        
        if ([instance.language isEqualToString:[IATConfig chinese]]) {
            //设置语言
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
            //设置方言
            [_iFlySpeechRecognizer setParameter:instance.accent forKey:[IFlySpeechConstant ACCENT]];
        }else if ([instance.language isEqualToString:[IATConfig english]]) {
            [_iFlySpeechRecognizer setParameter:instance.language forKey:[IFlySpeechConstant LANGUAGE]];
        }
        //设置是否返回标点符号
        [_iFlySpeechRecognizer setParameter:instance.dot forKey:[IFlySpeechConstant ASR_PTT]];
        
    }
    //启动识别服务
    [self.iFlySpeechRecognizer startListening];
    
//    [self.iFlySpeechRecognizer stopListening];
    
}

/**
 结束监听
 */
- (void)stopRecognie{
    [self.iFlySpeechRecognizer stopListening];
}

//识别结果返回代理
- (void) onResults:(NSArray *) results isLast:(BOOL)isLast{
    
//    NSArray * temp = [[NSArray alloc]init];
//    NSString * str = [[NSString alloc]init];
//    NSMutableString *result = [[NSMutableString alloc] init];
//    NSDictionary *dic = results[0];
//    for (NSString *key in dic) {
//        [result appendFormat:@"%@",key];
//        
//    }
//    NSLog(@"听写结果：%@",result);
//    //---------讯飞语音识别JSON数据解析---------//
//    NSError * error;
//    NSData * data = [result dataUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"data: %@",data);
//    NSDictionary * dic_result =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
//    NSArray * array_ws = [dic_result objectForKey:@"ws"];
//    //遍历识别结果的每一个单词
//    for (int i=0; i<array_ws.count; i++) {
//        temp = [[array_ws objectAtIndex:i] objectForKey:@"cw"];
//        NSDictionary * dic_cw = [temp objectAtIndex:0];
//        str = [str  stringByAppendingString:[dic_cw objectForKey:@"w"]];
//        NSLog(@"识别结果:%@",[dic_cw objectForKey:@"w"]);
//    }
//    NSLog(@"最终的识别结果:%@",str);
//    //去掉识别结果最后的标点符号
//    if ([str isEqualToString:@"。"] || [str isEqualToString:@"？"] || [str isEqualToString:@"！"]) {
//        NSLog(@"末尾标点符号：%@",str);
//    }
//    else{
////        self.content.text = str;
//    }
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
//    NSString *_result =[NSString stringWithFormat:@"%@",resultString];
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:resultString];
    
    if (isLast){
        NSLog(@"听写结果：%@", resultFromJson);
        _result = resultFromJson;
        
        NSCharacterSet* nonDigits =[[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        int remainSecond =[[_result stringByTrimmingCharactersInSet:nonDigits] intValue];
        NSLog(@" num %d ",remainSecond);
        
        if (self.delegate) {
            [self.delegate voiceresult:_result iferror:NO];
        }
        _result =@"";
    }
    
}

- (void)onError: (IFlySpeechError *) error{
    
    DDLogDebug(@"听写错误,%@",error);
    
    if (_delegate) {
        if (self.delegate) {
            BOOL state = _result==nil?YES:NO;
            [self.delegate voiceresult:@"" iferror:state];
        }
    }
    
}

@end
