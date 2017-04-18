//
//  ExpendVoiceView.m
//  LightAccounting
//
//  Created by ddllzz on 17/3/8.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "ExpendVoiceView.h"

@interface ExpendVoiceView (){
    
    UIImageView *imgIncome;
    UIImageView *imgExpend;
    UIImageView *imgVoice;
    UILabel *voiceAlert;
    UILabel *labelincome;
    UILabel *labelexpend;
    UILabel *labelMessage;
}

@end

@implementation ExpendVoiceView

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
    
    imgIncome= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [imgIncome setImage:[UIImage imageNamed:@"icon_income"]];
    imgIncome.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imgIncome];
    
    imgExpend= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [imgExpend setImage:[UIImage imageNamed:@"icon_expend"]];
    imgExpend.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imgExpend];
    
    imgVoice= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    [imgVoice setImage:[UIImage imageNamed:@"icon_voice"]];
    imgVoice.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:imgVoice];
    
    labelincome = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width/2, 30)];
    [labelincome setFont:fontsize_16];
    [labelincome setTextColor:UIColorFromRGB(0xffffff)];
    [labelincome setTextAlignment:NSTextAlignmentCenter];
    [labelincome setText:@"收入"];
    
    [self addSubview:labelincome];
    
    labelexpend = [[UILabel alloc] initWithFrame:CGRectMake(ScreenSize.width/2, 0, ScreenSize.width/2, 30)];
    [labelexpend setFont:fontsize_16];
    [labelexpend setTextColor:UIColorFromRGB(0xffffff)];
    [labelexpend setTextAlignment:NSTextAlignmentCenter];
    [labelexpend setText:@"支出"];
    
    [self addSubview:labelexpend];
    
    voiceAlert = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 25)];
    [voiceAlert setFont:fontsize_14];
    [voiceAlert setTextColor:UIColorFromRGB(0xcccccc)];
    [voiceAlert setTextAlignment:NSTextAlignmentCenter];
    [voiceAlert setText:@"按住说话，松开记账"];
    
    [self addSubview:voiceAlert];
    
    labelMessage = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width/2, 80)];
    labelMessage.lineBreakMode =NSLineBreakByWordWrapping;
    labelMessage.numberOfLines = 0;
    [labelMessage setFont:fontsize_16];
    [labelMessage setTextColor:UIColorFromRGB(color_theme_green)];
    [labelMessage setText:@"可以说\n\n早餐20\n\n打车22\n\n购物180\n\n......"];
    
    [self addSubview:labelMessage];
    
//    @weakify(self);
    __weak typeof(self) weakSelf = self;
    
    [imgIncome mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf.mas_left).with.offset(40);
        make.top.equalTo(strongSelf.mas_top).with.offset(15);
    }];
    
    [imgExpend mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.right.equalTo(strongSelf.mas_right).with.offset(-30);
        make.centerY.equalTo(imgIncome);
    }];
    
    [imgVoice mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.centerX.equalTo(strongSelf);
        make.bottom.equalTo(strongSelf.mas_bottom).with.offset(-80);
    }];
    
    [labelincome mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgIncome);
        make.top.equalTo(imgIncome.mas_bottom).with.offset(10);
    }];
    
    [labelexpend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(imgExpend);
        make.top.equalTo(imgExpend.mas_bottom).with.offset(10);
    }];
    
    [voiceAlert mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.centerX.equalTo(strongSelf);
        make.top.equalTo(imgVoice.mas_bottom).with.offset(15);
    }];
    
    [labelMessage mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.centerX.equalTo(strongSelf);
        make.bottom.equalTo(imgVoice.mas_top).with.offset(-20);
    }];
    
    
    UITapGestureRecognizer *addaccountTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigateAccount)];
    imgExpend.userInteractionEnabled=YES;
    [imgExpend addGestureRecognizer:addaccountTap];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    /*写文字*/
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:166/255.0 green:209/255.0 blue:87/255.0 alpha:1].CGColor);
    //    CGContextSetRGBFillColor (context,  166, 209, 87, 1.0);//设置填充颜色
    CGContextFillRect(context,CGRectMake(0, 0, rect.size.width, 150));//填充框
}

#pragma mark--回调方法
-(void)navigateAccount{
    if (self.addnewAccount) {
        self.addnewAccount();
    }
}

@end
