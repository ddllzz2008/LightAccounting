//
//  PlanView.m
//  LightAccounting
//
//  Created by ddllzz on 2017/4/28.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "PlanView.h"

@implementation PlanView

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
    
    labelMonth = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 40)];
    [labelMonth setStyle:fontsize_16 color:UIColorFromRGB(0xffffff)];
    labelMonth.textAlignment=NSTextAlignmentCenter;
    [labelMonth setText:@"2017年2月"];
    [self addSubview:labelMonth];
    
    __weak typeof(self) weakSelf = self;
    [labelMonth mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.width.equalTo(strongSelf);
        make.left.equalTo(strongSelf);
        make.height.equalTo(@40);
    }];
    
    labelsunday = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 40)];
    [labelsunday setStyle:fontsize_14 color:UIColorFromRGB(0xBBBBBB)];
    labelsunday.textAlignment=NSTextAlignmentCenter;
    [labelsunday setText:@"日"];
    [self addSubview:labelsunday];
    
    [labelsunday mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.width.equalTo(strongSelf.mas_width).multipliedBy(1/7);
        make.left.equalTo(strongSelf);
        make.height.equalTo(@20);
        make.top.equalTo(labelMonth.mas_bottom);
    }];
    
    labelmonday = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 40)];
    [labelmonday setStyle:fontsize_14 color:UIColorFromRGB(0xBBBBBB)];
    labelmonday.textAlignment=NSTextAlignmentCenter;
    [labelmonday setText:@"一"];
    [self addSubview:labelmonday];
    
    [labelmonday mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.width.equalTo(strongSelf.mas_width).multipliedBy(1/7);
        make.left.equalTo(labelsunday.mas_right);
        make.height.equalTo(@20);
        make.top.equalTo(labelMonth.mas_bottom);
    }];
    
    labeltuesday = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 40)];
    [labeltuesday setStyle:fontsize_14 color:UIColorFromRGB(0xBBBBBB)];
    labeltuesday.textAlignment=NSTextAlignmentCenter;
    [labeltuesday setText:@"二"];
    [self addSubview:labeltuesday];
    
    [labeltuesday mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.width.equalTo(strongSelf.mas_width).multipliedBy(1/7);
        make.left.equalTo(labelmonday.mas_right);
        make.height.equalTo(@20);
        make.top.equalTo(labelMonth.mas_bottom);
    }];
    
    labelwednesday = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 40)];
    [labelwednesday setStyle:fontsize_14 color:UIColorFromRGB(0xBBBBBB)];
    labelwednesday.textAlignment=NSTextAlignmentCenter;
    [labelwednesday setText:@"三"];
    [self addSubview:labelwednesday];
    
    [labelwednesday mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.width.equalTo(strongSelf.mas_width).multipliedBy(1/7);
        make.left.equalTo(labeltuesday.mas_right);
        make.height.equalTo(@20);
        make.top.equalTo(labelMonth.mas_bottom);
    }];
    
    labelthursday = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 40)];
    [labelthursday setStyle:fontsize_14 color:UIColorFromRGB(0xBBBBBB)];
    labelthursday.textAlignment=NSTextAlignmentCenter;
    [labelthursday setText:@"四"];
    [self addSubview:labelthursday];
    
    [labelthursday mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.width.equalTo(strongSelf.mas_width).multipliedBy(1/7);
        make.left.equalTo(labelwednesday.mas_right);
        make.height.equalTo(@20);
        make.top.equalTo(labelMonth.mas_bottom);
    }];
    
    labelfriday = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 40)];
    [labelfriday setStyle:fontsize_14 color:UIColorFromRGB(0xBBBBBB)];
    labelfriday.textAlignment=NSTextAlignmentCenter;
    [labelfriday setText:@"五"];
    [self addSubview:labelfriday];
    
    [labelfriday mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.width.equalTo(strongSelf.mas_width).multipliedBy(1/7);
        make.left.equalTo(labelthursday.mas_right);
        make.height.equalTo(@20);
        make.top.equalTo(labelMonth.mas_bottom);
    }];
    
    labelsaturday = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 40)];
    [labelsaturday setStyle:fontsize_14 color:UIColorFromRGB(0xBBBBBB)];
    labelsaturday.textAlignment=NSTextAlignmentCenter;
    [labelsaturday setText:@"六"];
    [self addSubview:labelsaturday];
    
    [labelsaturday mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.width.equalTo(strongSelf.mas_width).multipliedBy(1/7);
        make.left.equalTo(labelfriday.mas_right);
        make.height.equalTo(@20);
        make.top.equalTo(labelMonth.mas_bottom);
    }];
    
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    /*写文字*/
    CGContextSetFillColorWithColor(context, [get_theme_color CGColor]);
    //    CGContextSetRGBFillColor (context,  166, 209, 87, 1.0);//设置填充颜色
    CGContextFillRect(context,CGRectMake(0, 0, rect.size.width, 40));//填充框
    
    CGContextSetFillColorWithColor(context, [UIColorFromRGB(0xEEEEEE) CGColor]);
    CGContextFillRect(context,CGRectMake(0, 40, rect.size.width, 20));//填充框
}

@end
