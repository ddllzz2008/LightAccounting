//
//  DLPickerView.m
//  DLZProject
//
//  Created by ddllzz on 16/12/28.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "DLDatePickerView.h"

static const float kButtonHeight = 40.0f;
static const float kContentHeight = 180.0f;

@implementation DLDatePickerView

+(id)sharedInstance{
    static DLDatePickerView *sharedAlert = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAlert = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return sharedAlert;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (picker==nil) {
        CGRect contentFrame = CGRectMake(0, ScreenSize.height-kContentHeight, ScreenSize.width, kContentHeight);
        
        UIView *hiddenview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height-kContentHeight)];
        hiddenview.backgroundColor=[UIColor grayColor];
        hiddenview.alpha=0.3;
        [self addSubview:hiddenview];
        
        backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenSize.height, ScreenSize.width, kContentHeight)];
        picker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, kButtonHeight, contentFrame.size.width, contentFrame.size.height - kButtonHeight)];
        [picker addTarget:self action:@selector(changeDate:) forControlEvents:UIControlEventValueChanged];
        NSLocale *locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh-Hans"];
        picker.locale = locale;
        [backgroundView setBackgroundColor:[UIColor whiteColor]];
        [backgroundView addSubview:picker];
        
        UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentFrame.size.width, kButtonHeight)];
        headerview.backgroundColor=[UIColor whiteColor];
        
        UIButton *cancelbutton = [[UIButton alloc] initWithFrame:CGRectMake(12, 7.5, 70, 25)];
        UIButton *confirmbutton = [[UIButton alloc] initWithFrame:CGRectMake(contentFrame.size.width-70-12, 7.5, 70, 25)];
        [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelbutton setBackgroundColor:get_theme_color];
        [cancelbutton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [headerview addSubview:cancelbutton];
        
        [confirmbutton setTitle:@"确定" forState:UIControlStateNormal];
        [confirmbutton setBackgroundColor:get_theme_color];
        [confirmbutton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        [headerview addSubview:confirmbutton];
        [backgroundView addSubview:headerview];
        
        [self addSubview:backgroundView];
        
    }
    return self;
}

-(void)setDateMode:(UIDatePickerMode)dateMode{
    _dateMode = dateMode;
    picker.datePickerMode = dateMode;
}

-(void)setMinDate:(NSDate *)minDate{
    _minDate = minDate;
    picker.minimumDate = minDate;
}

-(void)setMaxDate:(NSDate *)maxDate{
    _maxDate = maxDate;
    picker.maximumDate=maxDate;
}

-(void)show{
    
    self.windowLevel=UIWindowLevelAlert+1000;
    self.backgroundColor=[UIColor clearColor];
    self.alpha = 1;
    self.hidden = NO;
    
    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    //改变它的frame的x,y的值
    backgroundView.frame=CGRectMake(0, ScreenSize.height-kContentHeight, ScreenSize.width, kContentHeight);
    [UIView commitAnimations];
}

-(void)confirm{
    
    if (self.delegate) {
        selectedDate = [picker date];
        [self.delegate DLDatePickerView:self.tag didSelectDate:selectedDate];
    }
    [self close];
}

-(void)close{
    self.hidden=YES;
    
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenSize.height, ScreenSize.width, kContentHeight)];
}
/*!
 *  @brief 更改日期
 *
 *  @param datePicker <#datePicker description#>
 *
 *  @since <#version number#>
 */
-(void)changeDate:(UIDatePicker*)datePicker
{
    NSTimeZone *timeZone=[NSTimeZone systemTimeZone];
    NSInteger seconds=[timeZone secondsFromGMTForDate:datePicker.date];
    selectedDate=[datePicker.date dateByAddingTimeInterval:seconds];
}

@end
