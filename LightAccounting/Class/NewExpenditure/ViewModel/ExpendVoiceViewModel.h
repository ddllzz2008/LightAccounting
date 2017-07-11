//
//  ExpendVoiceViewModel.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/12.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewModel.h"
#import "CategoryDAL.h"
#import "CategoryModel.h"
#import <iflyMSC/IFlyMSC.h>
#import <iflyMSC/IFlyRecognizerViewDelegate.h>
#import <iflyMSC/IFlySpeechRecognizer.h>
#import <iflyMSC/IFlySpeechConstant.h>
#import "IATConfig.h"
#import "ISRDataHelper.h"


@protocol ExpendVoiceViewModelDelegate

@optional
-(void)voiceresult:(NSString *)result iferror:(BOOL)iferror;

@end

@interface ExpendVoiceViewModel : BaseViewModel<IFlySpeechRecognizerDelegate>{
    
    NSString *_result;
    
}

@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;

@property (nonatomic,strong) NSArray *categoryArray;

@property (nonatomic,weak) id<ExpendVoiceViewModelDelegate> delegate;

/**
 加载类别
 */
- (void)loadCategory;
/**
 启动语音识别
 */
-(void)startRecognize;
/**
 结束监听
 */
- (void)stopRecognie;

@end
