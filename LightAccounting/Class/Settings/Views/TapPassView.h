//
//  TapPassView.h
//  LightAccounting
//
//  Created by ddllzz on 17/4/19.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PassCircleView.h"

@protocol TapPassViewDelegate <NSObject>

@optional
-(void)tappassviewdidfinished:(NSString *)resultstring;

@end

@interface TapPassView : UIView{
    
    NSMutableArray *arrayCircleList;
    CGPoint movestartpoint;
    CGPoint moveendpoint;
    NSMutableArray *arrayPassword;
    NSMutableArray *arrayImageView;
}

@property (nonatomic,weak) id<TapPassViewDelegate> delegate;

-(void)showError;

@end
