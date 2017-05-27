//
//  RadarSearchButton.h
//  LightAccounting
//
//  Created by ddllzz on 2017/5/27.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Style.h"

@protocol RadarSearchButtonDelegate <NSObject>

@optional
    -(void)RadarSearchButtonTouchEnd;

@end

@interface RadarSearchButton : UIView
    
@property(nonatomic,weak) id<RadarSearchButtonDelegate> delegate;

@end
