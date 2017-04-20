//
//  PassCircleView.h
//  LightAccounting
//
//  Created by ddllzz on 17/4/19.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,PassCircleViewStatus){
    PassCircleViewStatusNormal,
    PassCircleViewStatusSelected,
    PassCircleViewStatusError
};

@interface PassCircleView : UIView

@property (nonatomic,assign,readwrite) PassCircleViewStatus Status;

@end
