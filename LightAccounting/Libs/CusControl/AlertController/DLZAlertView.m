//
//  DLZAlertView.m
//  DLZControls
//
//  Created by ddllzz on 16/5/10.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "DLZAlertView.h"

@implementation DLZAlertView

CGFloat view_height;
CGFloat view_width;
CGFloat margin_left;

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height)]){
        
        self = [super initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height)];
        
        self.backgroundColor=[UIColor clearColor];
        
        hiddenView = [[UIView alloc] init];
        
        hiddenView.backgroundColor = [UIColor grayColor];
        hiddenView.alpha = 0.5;
        [self addSubview:hiddenView];
        
        contentView = [[UIView alloc] init];
        contentView.layer.cornerRadius = 5;
        contentView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:contentView];
        
        closeView = [[UIImageView alloc] init];
        [closeView setImage:[UIImage imageNamed:@"DLZControlsResource.bundle/common_close"]];
        [contentView addSubview:closeView];
        
        viewTitle = [[UILabel alloc] init];
        viewTitle.textAlignment = NSTextAlignmentCenter;
        [viewTitle setStyle:fontsize_14 color:UIColorFromRGB(0xbbbbbb)];
        [contentView addSubview:viewTitle];
        
        viewContent = [[UILabel alloc] init];
        viewContent.textAlignment = NSTextAlignmentCenter;
        [viewContent setStyle:fontsize_14 color:UIColorFromRGB(0x333333)];
        viewContent.lineBreakMode=NSLineBreakByWordWrapping;
        viewContent.numberOfLines = 0;
        [contentView addSubview:viewContent];
    }
    
    view_height = 120;
    view_width = ScreenSize.width -50.0f;
    margin_left = 25.0f;
    
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    hiddenView.frame=CGRectMake(0, 0, ScreenSize.width, ScreenSize.height);
    
    closeView.frame=CGRectMake(view_width-5-15, 5, 15, 15);
    
    CGSize size = CGSizeMake(view_width-40, MAXFLOAT);
    CGSize actualSize = [viewTitle getLabelSize:size];
    viewTitle.frame=CGRectMake(10, 20, view_width-40, actualSize.height+10);
    
    CGRect rect = viewTitle.frame;
    
    size = CGSizeMake(view_width-20, MAXFLOAT);
    actualSize = [viewContent getmutliLineSize:size];
    viewContent.frame =CGRectMake(10, rect.origin.y+rect.size.height+5, view_width-20, actualSize.height+20);
    
    if (leftButton==nil && rightButton==nil) {
        contentView.frame = CGRectMake(margin_left, (ScreenSize.height-view_height)/2-150, view_width, viewContent.frame.origin.y+viewContent.frame.size.height+10+20);
        
    }
    else{
        if (leftButton!=nil) {
            rect = viewContent.frame;
            leftButton.frame=CGRectMake(25, rect.origin.y+rect.size.height+10, view_width-margin_left*2, 30);
            contentView.frame = CGRectMake(margin_left, (ScreenSize.height-view_height)/2-150, view_width, leftButton.frame.origin.y+leftButton.frame.size.height+10+20);
        }
        
        if (rightButton!=nil) {
            rect = viewContent.frame;
            if (leftButton!=nil) {
                leftButton.frame=CGRectMake(25, rect.origin.y+rect.size.height+10, (view_width-25*2-10)/2, 30);
            }
            rightButton.frame=CGRectMake(25+leftButton.frame.size.width+10, leftButton.frame.origin.y, (view_width-25*2-10)/2, 30);
            contentView.frame = CGRectMake(margin_left, (ScreenSize.height-view_height)/2-150, view_width, rightButton.frame.origin.y+rightButton.frame.size.height+10+20);
        }
    }
    
    //设置动画
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.autoreverses = NO;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.repeatCount = 1;
    scaleAnimation.duration = 0.2;
    
    //开演
    [contentView.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    
    //注册事件
    UITapGestureRecognizer *closeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closePanel:)];
    closeTap.numberOfTapsRequired = 1;
    closeTap.delegate=self;
    closeView.userInteractionEnabled=YES;
    [closeView addGestureRecognizer:closeTap];
}

#pragma mark---设置属性
/*
 *-----------------设置标题------------------*
 */
-(void)setTitle:(NSString*)title{
    [viewTitle setText:title];
}
/*
 *-----------------设置内容------------------*
 */
-(void)setContent:(NSString*)content{
    [viewContent setText:content];
}
/*
 *-----------------设置左按钮------------------*
 */
-(void)setLeftButton:(NSString*)content{
    
    if (leftButton==nil) {
        
        leftButton = [[UIButton alloc] init];
        leftButton.layer.cornerRadius = 5;
        
        [leftButton setTitle:content forState:UIControlStateNormal];
        [leftButton.titleLabel setStyle:fontsize_14 color:UIColorFromRGB(0xffffff)];
        [leftButton setBackgroundColor:get_theme_color];
        [contentView addSubview:leftButton];
        
        [leftButton addTarget:self action:@selector(leftBtnTap) forControlEvents:UIControlEventTouchUpInside];
    }
}
/*
 *-----------------设置右按钮------------------*
 */
-(void)setRightButton:(NSString*)content{
    
    if (rightButton==nil) {
        
//        UIColor *savecolor = get_theme_color;

        rightButton = [[UIButton alloc] init];
        rightButton.layer.cornerRadius = 5;
        
        [rightButton setTitle:content forState:UIControlStateNormal];
        [rightButton.titleLabel setStyle:fontsize_14 color:UIColorFromRGB(0xffffff)];
        [rightButton setBackgroundColor:get_theme_color];
        [contentView addSubview:rightButton];
        
        [rightButton addTarget:self action:@selector(rightBtnTap) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark---交互事件
-(void)close{
    [self removeFromSuperview];
}

-(void)closePanel:(UITapGestureRecognizer*)sender{
    [self removeFromSuperview];
}

-(void)leftBtnTap{
    if (self.leftButtonAction!=nil) {
        __weak DLZAlertView *view = self;
        self.leftButtonAction(view);
    }
}

-(void)rightBtnTap{
    if (self.rightButtonAction!=nil) {
        __weak DLZAlertView *view = self;
        self.rightButtonAction(view);
    }
}

#pragma mark---弹出提示框
+(void)showAlertMessage:(UIViewController*)controller title:(NSString*)title content:(NSString*)content leftButton:(NSString*)leftButton leftaction:(void (^)(id sender))leftaction rightButton:(NSString*)rightButton rightaction:(void (^)(id sender))rightaction{
    DLZAlertView *view = [[DLZAlertView alloc] init];
    [view setTitle:title];
    [view setContent:content];
    if (leftButton!=nil && ![leftButton isEqualToString:@""]){
        [view setLeftButton:leftButton];
        if (leftaction!=nil) {
            view.leftButtonAction = leftaction;
        }
        
        if (rightButton!=nil && ![rightButton isEqualToString:@""]) {
            [view setRightButton:rightButton];
            if (rightaction!=nil) {
                view.rightButtonAction = rightaction;
            }
        }
    }

    
    if (controller.navigationController!=nil) {
        [controller.navigationController.view addSubview:view];
        [controller.navigationController.view bringSubviewToFront:view];
    }else{
        [controller.view addSubview:view];
        [controller.view bringSubviewToFront:view];
    }
    
}

+(void)showAlertMessage:(UIViewController*)controller title:(NSString*)title content:(NSString*)content callback:(void (^)())callback{
    DLZAlertView *view = [[DLZAlertView alloc] init];
    [view setTitle:title];
    [view setContent:content];
    [view setLeftButton:@"关闭"];
    view.leftButtonAction =^(id sender){
        DLZAlertView *alertview = sender;
        [alertview removeFromSuperview];
        
        if (callback!=nil) {
            callback();
        }
        
    };
    if (controller.navigationController!=nil) {
        [controller.navigationController.view addSubview:view];
        [controller.navigationController.view bringSubviewToFront:view];
    }else{
        [controller.view addSubview:view];
        [controller.view bringSubviewToFront:view];
    }
}

+(void)showAlertMessage:(UIViewController*)controller title:(NSString*)title content:(NSString*)content{
    [DLZAlertView showAlertMessage:controller title:title content:content callback:nil];
}

@end
