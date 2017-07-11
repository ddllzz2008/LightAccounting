//
//  ExpendVoiceView.h
//  LightAccounting
//
//  Created by ddllzz on 17/3/8.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpendVoiceViewModel.h"
#import "CategoryModel.h"

@interface ExpendVoiceView : UIView<ExpendVoiceViewModelDelegate>

/**
 收入支出点击事件，type==0：收入，type==1：支出
 */
@property (nonatomic,copy) void(^addnewAccount)(int type);

@property (nonatomic,weak) ExpendVoiceViewModel *viewmodel;

-(void)addNotification;

- (void)removeNotification;

@end
