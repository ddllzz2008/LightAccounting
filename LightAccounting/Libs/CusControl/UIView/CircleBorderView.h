//
//  CircleBorderView.h
//  DLZProject
//
//  Created by ddllzz on 16/12/27.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface CircleBorderView : UIView

@property (nonatomic,assign) IBInspectable CGFloat bottomHeight;

@property (nonatomic,strong) IBInspectable UIColor *borderColor;

@property (nonatomic,assign) IBInspectable NSInteger borderWidth;

@property (nonatomic,strong,readwrite) IBInspectable UIColor *topBackground;

@property (nonatomic,strong,readwrite) IBInspectable UIColor *bottomBackground;

@property (nonatomic,strong) IBInspectable NSString *title;

@property (nonatomic,strong) IBInspectable UIImage *image;

@property (nonatomic,strong) IBInspectable UIFont* font;

@property (nonatomic,strong,readwrite) IBInspectable UIColor *tintColor;

@end
