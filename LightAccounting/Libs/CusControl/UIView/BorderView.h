//
//  BorderView.h
//  DLZProject
//
//  Created by ddllzz on 16/12/26.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface BorderView : UIView

@property(nonatomic,strong) IBInspectable UIColor *borderColor;

@property(nonatomic,assign) IBInspectable CGFloat borderLeft;

@property(nonatomic,assign) IBInspectable CGFloat borderTop;

@property(nonatomic,assign) IBInspectable CGFloat borderRight;

@property(nonatomic,assign) IBInspectable CGFloat borderBottom;

@end
