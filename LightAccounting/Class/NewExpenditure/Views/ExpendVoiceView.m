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
    
    UILongPressGestureRecognizer *startrecord = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(startRecord:)];
    imgVoice.userInteractionEnabled=YES;
    startrecord.cancelsTouchesInView=NO;
    [imgVoice addGestureRecognizer:startrecord];
    
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
    labelMessage.textAlignment=NSTextAlignmentCenter;
    labelMessage.lineBreakMode =NSLineBreakByWordWrapping;
    labelMessage.numberOfLines = 0;
    [labelMessage setFont:fontsize_16];
    [labelMessage setTextColor:get_theme_color];
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
    
    UITapGestureRecognizer *addincomeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigateIncome)];
    imgIncome.userInteractionEnabled=YES;
    [imgIncome addGestureRecognizer:addincomeTap];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    /*写文字*/
    CGContextSetFillColorWithColor(context, [get_theme_color CGColor]);
    //    CGContextSetRGBFillColor (context,  166, 209, 87, 1.0);//设置填充颜色
    CGContextFillRect(context,CGRectMake(0, 0, rect.size.width, 150));//填充框
}

#pragma mark---观察对象

-(void)addNotification{
    
    [self.viewmodel addObserver:self forKeyPath:@"categoryArray" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    self.viewmodel.delegate=self;
    
}

- (void)removeNotification{
    
    [self.viewmodel removeObserver:self forKeyPath:@"categoryArray"];
    self.viewmodel.delegate=nil;
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"categoryArray"])
    {
        NSArray *array = self.viewmodel.categoryArray;
        
        NSString *str = @"可以说\n";
        
        for (NSInteger i=0; i<5; i++) {
            if (array.count>i) {
                str = [str stringByAppendingFormat:@"%@%ld\n",((CategoryModel *)[array objectAtIndex:i]).CNAME,(i+1)*30];
            }
        }
        if (array.count>0) {
            str = [str stringByAppendingString:@"\n......"];
            str = [str stringByAppendingString:@"\n格式为(收入/支出分类名称+金额)"];
        }else{
            str = @"请先前往设置-收入/支出分类-新增分类";
        }
        
        [labelMessage setText:str];
        
    }
}

#pragma mark--回调方法
-(void)navigateAccount{
    if (self.addnewAccount) {
        self.addnewAccount(1);
    }
}
-(void)navigateIncome{
    if (self.addnewAccount) {
        self.addnewAccount(0);
    }
}

-(void)startRecord:(UILongPressGestureRecognizer *)recognizer{
    
    if (recognizer.state==UIGestureRecognizerStateBegan) {
        
        [[AlertController sharedInstance] showMessage:@"正在说话"];
        [self.viewmodel startRecognize];
        
        
    }else if(recognizer.state==UIGestureRecognizerStateEnded){
        
//        [[AlertController sharedInstance] closeMessage];
        
        [self.viewmodel stopRecognie];
    }
    
}

#pragma mark---返回结果
- (void)voiceresult:(NSString *)result iferror:(BOOL)iferror{
    
    if (iferror) {
        [[AlertController sharedInstance] closeMessage];
        [[AlertController sharedInstance] showMessageAutoClose:@"请重新录入"];
    }else{
        
        [[AlertController sharedInstance] closeMessage];
        [[AlertController sharedInstance] showMessageAutoClose:[NSString stringWithFormat:@"识别结果\n%@",result]];
        
    }
    
}

@end
