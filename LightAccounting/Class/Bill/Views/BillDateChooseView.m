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

-(void)initlayout{
    
    UILabel *chooseDate = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width/3, 60)];
    [chooseDate setTextColor:UIColorFromRGB(color_theme_green)];
    [chooseDate setTextAlignment:NSTextAlignmentCenter];
    [chooseDate setFont:fontsize_22];
    [chooseDate setText:@"10月 | 2016"];
    [self addSubview:chooseDate];
    
    [chooseDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width/3, 60));
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
    
    UIView *viewleft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    viewleft.layer.cornerRadius=15;
    viewleft.layer.masksToBounds=YES;
    viewleft.backgroundColor=UIColorFromRGB(color_theme_green);
    [self addSubview:viewleft];
    
    [viewleft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(self);
        make.right.equalTo(chooseDate.mas_left).with.offset(-30);
    }];
    
    
    UIImageView *imgleft = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [imgleft setImage:[UIImage imageNamed:@"icon_left"]];
    [viewleft addSubview:imgleft];
    
    @weakify(viewleft);
    [imgleft mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(viewleft);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.centerX.equalTo(viewleft);
        make.centerY.equalTo(viewleft);
    }];
    
    UIView *viewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    viewright.layer.cornerRadius=15;
    viewright.layer.masksToBounds=YES;
    viewright.backgroundColor=UIColorFromRGB(color_theme_green);
    [self addSubview:viewright];
    
    [viewright mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(self);
        make.left.equalTo(chooseDate.mas_right).with.offset(30);
    }];
    
    
    UIImageView *imgright = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 18, 18)];
    [imgright setImage:[UIImage imageNamed:@"icon_right"]];
    [viewright addSubview:imgright];
    
    @weakify(viewright);
    [imgright mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(viewright);
        make.size.mas_equalTo(CGSizeMake(18, 18));
        make.centerX.equalTo(viewright);
        make.centerY.equalTo(viewright);
    }];
    
}

@end
