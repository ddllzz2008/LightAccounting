//
//  DLPopView.h
//  DLZProject
//
//  Created by ddllzz on 16/12/16.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface DLPopView : UIView{
    
    UIView *pointSender;
    
    UIView *viewhidden;
    
}

@property (nonatomic,assign,readwrite) IBInspectable BOOL isShow;

@property (nonatomic,strong,readwrite) IBInspectable UIColor* borderColor;

@property (nonatomic,assign,readwrite) IBInspectable NSInteger arrowHeight;

@property (nonatomic,assign,readwrite) IBInspectable NSInteger borderRadius;

@property (nonatomic,assign,readwrite) IBInspectable NSInteger borderWidth;

@property (nonatomic,strong,readwrite) IBInspectable UIColor *contentBackground;

-(void)show:(__weak UIView *)sender;

@end
