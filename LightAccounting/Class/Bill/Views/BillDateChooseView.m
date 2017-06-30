//
//  BillDateChooseView.m
//  LightAccounting
//
//  Created by ddllzz on 17/4/11.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BillDateChooseView.h"

@implementation BillDateChooseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        
        [self initlayout];
    }
    return self;
}

-(id)init{
    if (self==[super init]) {
        self.backgroundColor=[UIColor whiteColor];
        
        [self initlayout];
    }
    return self;
}

-(void)refreshTheme{
    
    UIColor *themecolor = get_theme_color;
    [viewleft setBackgroundColor:themecolor];
    [viewright setBackgroundColor:themecolor];
    [chooseDate setTextColor:themecolor];
    
}

-(void)initlayout{
    
    chooseDate = [[UILabel alloc] initWithFrame:CGRectMake((self.frame.size.width/3),0 , self.frame.size.width/3, self.frame.size.height)];
    [chooseDate setTextColor:get_theme_color];
    [chooseDate setTextAlignment:NSTextAlignmentCenter];
    [chooseDate setFont:fontsize_18];
    [chooseDate setText:@"10月 | 2016"];
    [self addSubview:chooseDate];
    
//    [chooseDate mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(ScreenSize.width/3, 60));
//        make.centerX.equalTo(self);
//        make.centerY.equalTo(self);
//    }];
    int width = 30;
    int space = 30;
    viewleft = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width-chooseDate.frame.size.width-space*2-width*2)/2, (self.frame.size.height-30)/2, width, width)];
    viewleft.layer.cornerRadius=15;
    viewleft.layer.masksToBounds=YES;
    viewleft.backgroundColor=get_theme_color;
    viewleft.userInteractionEnabled = YES;
    UITapGestureRecognizer *lefttap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftPress:)];
    [viewleft addGestureRecognizer:lefttap];
    [self addSubview:viewleft];
    
//    [viewleft mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//        make.centerY.equalTo(self);
//        make.right.equalTo(chooseDate.mas_left).with.offset(-30);
//    }];
    
    
    UIImageView *imgleft = [[UIImageView alloc] initWithFrame:CGRectMake((width-12)/2, (width-12)/2, 12, 12)];
    [imgleft setImage:[UIImage imageNamed:@"icon_left"]];
    [viewleft addSubview:imgleft];
    
//    __weak __typeof(viewleft) weakviewleft = viewleft;
//    [imgleft mas_makeConstraints:^(MASConstraintMaker *make) {
//        __strong __typeof(weakviewleft) strongviewleft = weakviewleft;
//        make.size.mas_equalTo(CGSizeMake(12, 12));
//        make.centerX.equalTo(strongviewleft);
//        make.centerY.equalTo(strongviewleft);
//    }];
    
    viewright = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width-viewleft.frame.origin.x-width, (self.frame.size.height-30)/2, width, width)];
    viewright.layer.cornerRadius=15;
    viewright.layer.masksToBounds=YES;
    viewright.backgroundColor=get_theme_color;
    viewright.userInteractionEnabled = YES;
    UITapGestureRecognizer *righttap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightPress:)];
    [viewright addGestureRecognizer:righttap];
    [self addSubview:viewright];
    
//    [viewright mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//        make.centerY.equalTo(self);
//        make.left.equalTo(chooseDate.mas_right).with.offset(30);
//    }];
    
    
    UIImageView *imgright = [[UIImageView alloc] initWithFrame:CGRectMake((width-12)/2, (width-12)/2, 12, 12)];
    [imgright setImage:[UIImage imageNamed:@"icon_right"]];
    [viewright addSubview:imgright];
    
//    __weak __typeof(viewright) weakviewright = viewright;
//    [imgright mas_makeConstraints:^(MASConstraintMaker *make) {
//        __strong __typeof(weakviewright) strongviewright = weakviewright;
//        make.size.mas_equalTo(CGSizeMake(12, 12));
//        make.centerX.equalTo(strongviewright);
//        make.centerY.equalTo(strongviewright);
//    }];
    
}

-(void)setCurrentDate:(NSDate *)currentDate{
    
    _currentDate = currentDate;
    
    switch (_mode) {
        case BillDateChooseModeYear:
            [chooseDate setText:[currentDate formatWithCode:@"yyyy年"]];
            break;
        case BillDateChooseModeYearMonth:
            [chooseDate setText:[currentDate formatWithCode:@"MM月 | yyyy"]];
            break;
    }
    
}

-(void)setMode:(BillDateChooseMode)mode{
    
    _mode = mode;
    
    switch (_mode) {
        case BillDateChooseModeYear:
            [chooseDate setText:[_currentDate formatWithCode:@"yyyy年"]];
            break;
        case BillDateChooseModeYearMonth:
            [chooseDate setText:[_currentDate formatWithCode:@"MM月 | yyyy"]];
            break;
    }
    
}

#pragma mark---交互事件
-(void)leftPress:(UITapGestureRecognizer *)recognizer{
    
    switch (_mode) {
        case BillDateChooseModeYear:
            self.currentDate = [[_currentDate dateForLastYear] objectAtIndex:0];
            break;
        case BillDateChooseModeYearMonth:
            self.currentDate = [[_currentDate dateForLastMonth] objectAtIndex:0];
            break;
    }
    
    if (self.delegate) {
        __weak typeof(self) weakself = self;
        [self.delegate BillDateChoose:weakself prebuttonPressed:self.currentDate];
    }
    
}
-(void)rightPress:(UITapGestureRecognizer *)recognizer{
    
    switch (_mode) {
        case BillDateChooseModeYear:
            self.currentDate = [[_currentDate dateForNextYear] objectAtIndex:0];
            break;
        case BillDateChooseModeYearMonth:
            self.currentDate = [[_currentDate dateForNextMonth] objectAtIndex:0];
            break;
    }
    
    if (self.delegate) {
        __weak typeof(self) weakself = self;
        [self.delegate BillDateChoose:weakself prebuttonPressed:self.currentDate];
    }
    
}

@end
