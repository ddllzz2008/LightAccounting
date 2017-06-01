//
//  NewStep1View.m
//  LightAccounting
//
//  Created by ddllzz on 17/3/26.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "NewPlanView.h"

@implementation NewPlanView

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
    
    UILabel *currentTitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 15, self.frame.size.width / 2, 20)];
    [currentTitle setTextColor:UIColorFromRGB(0xffffff)];
    [currentTitle setTextAlignment:NSTextAlignmentLeft];
    [currentTitle setFont:fontsize_24];
    [currentTitle setText:@"￥"];
    [self addSubview:currentTitle];
    
    //    @weakify(self);
    __weak typeof(self) weakSelf = self;
    [currentTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        //        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf).with.offset(15);
        make.top.equalTo(strongSelf).with.offset(50);
        make.width.equalTo(@30);
    }];
    
    self.inputmoney = [[UITextField alloc] init];
    [self.inputmoney setTextColor:UIColorFromRGB(0xffffff)];
    [self.inputmoney setFont:fontsize_32];
    [self.inputmoney setPlaceholder:@"金额"];
    self.inputmoney.keyboardType=UIKeyboardTypeDecimalPad;
    self.inputmoney.returnKeyType=UIReturnKeyDone;
    [self addSubview:self.inputmoney];
    [self.inputmoney mas_makeConstraints:^(MASConstraintMaker *make) {
        //        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(currentTitle.mas_right).with.offset(10);
        make.centerY.equalTo(currentTitle);
        make.width.mas_equalTo(strongSelf.bounds.size.width-50);
    }];
    
    UILabel *labelType = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [labelType setStyle:fontsize_16 color:UIColorFromRGB(0xBBBBBB)];
    labelType.textAlignment=NSTextAlignmentLeft;
    [labelType setText:@"账单类型"];
    [self addSubview:labelType];
    
    [labelType mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf).with.offset(15);
        make.top.equalTo(strongSelf).with.offset(110);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    
    self.accountType = [[UISegmentedControl alloc] initWithItems:@[@"支出",@"收入"]];
    self.accountType.frame = CGRectMake(0, 0, ScreenSize.width/2, 30);
    self.accountType.segmentedControlStyle=UISegmentedControlStylePlain;
    self.accountType.selectedSegmentIndex=0;
    [self.accountType setTintColor:get_theme_color];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:fontsize_14,UITextAttributeFont ,nil];
    [self.accountType setTitleTextAttributes:dic forState:UIControlStateNormal];
    [self addSubview:self.accountType];
    
    [self.accountType mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.right.equalTo(strongSelf.mas_right).with.offset(-15);
        make.centerY.equalTo(labelType);
    }];
    
    UILabel *labelAlert = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [labelAlert setStyle:fontsize_16 color:UIColorFromRGB(0xBBBBBB)];
    labelAlert.textAlignment=NSTextAlignmentLeft;
    [labelAlert setText:@"开启通知"];
    [self addSubview:labelAlert];
    
    [labelAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf).with.offset(15);
        make.top.equalTo(labelType.mas_bottom).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    
    self.switchAlert = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    self.switchAlert.on=YES;
    self.switchAlert.tintColor=UIColorFromRGB(0xcccccc);
    self.switchAlert.onTintColor=get_theme_color;
    [self addSubview:self.switchAlert];
    [self.switchAlert mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.right.equalTo(strongSelf.mas_right).with.offset(-15);
        make.centerY.equalTo(labelAlert);
    }];
    
    
    UIImageView *imgremark= [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
    [imgremark setImage:[UIImage imageNamed:@"icon_note"]];
    [self addSubview:imgremark];
    
    [imgremark mas_makeConstraints:^(MASConstraintMaker *make) {
        //        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf).with.offset(15);
        make.top.equalTo(labelAlert.mas_bottom).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    self.labelremark = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width-30-40, 30)];
    [self.labelremark setBackgroundColor:UIColorFromRGB(0xE6E6E6)];
    [self.labelremark setTextColor:UIColorFromRGB(0xA6CE57)];
    [self.labelremark setLeftPadding:10.0f];
    self.labelremark.keyboardType=UIKeyboardTypeDefault;
    self.labelremark.returnKeyType=UIReturnKeyDone;
    [self.labelremark setPlaceholder:@"备注"];
    
    [self addSubview:self.labelremark];
    
    [self.labelremark mas_makeConstraints:^(MASConstraintMaker *make) {
        //        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.centerY.equalTo(imgremark);
        make.left.equalTo(imgremark.mas_right).with.offset(12);
        make.right.equalTo(strongSelf).with.offset(-15);
        make.height.equalTo(@30);
    }];
    
    UIImageView *imgdate = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
    [imgdate setImage:[UIImage imageNamed:@"icon_alarm"]];
    [self addSubview:imgdate];
    
    UITapGestureRecognizer *dateTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseDate:)];
    dateTap.delegate=self;
    imgdate.userInteractionEnabled=YES;
    [imgdate addGestureRecognizer:dateTap];
    
    [imgdate mas_makeConstraints:^(MASConstraintMaker *make) {
        //        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf).with.offset(15);
        make.top.equalTo(imgremark.mas_bottom).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    labeldate = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width-30-40, 30)];
    [labeldate setBackgroundColor:UIColorFromRGB(0xE6E6E6)];
    [labeldate setTextColor:UIColorFromRGB(0xA6CE57)];
    [labeldate setLeftPadding:10.0f];
    labeldate.delegate=self;
    [labeldate setText:@"今天"];
    
    [self addSubview:labeldate];
    
    [labeldate mas_makeConstraints:^(MASConstraintMaker *make) {
        //        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.centerY.equalTo(imgdate);
        make.left.equalTo(imgdate.mas_right).with.offset(12);
        make.right.equalTo(strongSelf).with.offset(-15);
        make.height.equalTo(@30);
    }];
    
//    UIImageView *imgmap = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
//    [imgmap setImage:[UIImage imageNamed:@"icon_map"]];
//    [self addSubview:imgmap];
//    
//    [imgmap mas_makeConstraints:^(MASConstraintMaker *make) {
//        //        @strongify(self);
//        __strong __typeof(weakSelf) strongSelf = weakSelf;
//        make.left.equalTo(strongSelf).with.offset(15);
//        make.top.equalTo(imgdate.mas_bottom).with.offset(25);
//        make.size.mas_equalTo(CGSizeMake(30, 30));
//    }];
//    
//    UITextField *labelmap = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width-30-40, 30)];
//    [labelmap setBackgroundColor:UIColorFromRGB(0xE6E6E6)];
//    [labelmap setTextColor:UIColorFromRGB(0xA6CE57)];
//    [labelmap setLeftPadding:10.0f];
//    labelmap.delegate=self;
//    [labelmap setText:@"正在获取位置"];
//    
//    [self addSubview:labelmap];
//    [labelmap mas_makeConstraints:^(MASConstraintMaker *make) {
//        //        @strongify(self);
//        __strong __typeof(weakSelf) strongSelf = weakSelf;
//        make.centerY.equalTo(imgmap);
//        make.left.equalTo(imgmap.mas_right).with.offset(12);
//        make.right.equalTo(strongSelf).with.offset(-15);
//        make.height.equalTo(@30);
//    }];
    
    imgcategory = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
    [imgcategory setImage:[UIImage imageNamed:@"icon_category"]];
    
    UITapGestureRecognizer *selectcategoryTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showCategory:)];
    imgcategory.userInteractionEnabled=YES;
    [imgcategory addGestureRecognizer:selectcategoryTap];
    
    [self addSubview:imgcategory];
    
    [imgcategory mas_makeConstraints:^(MASConstraintMaker *make) {
        //        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf).with.offset(15);
        make.top.equalTo(imgdate.mas_bottom).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    labelcategory = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width-30-40, 30)];
    [labelcategory setBackgroundColor:UIColorFromRGB(0xE6E6E6)];
    [labelcategory setTextColor:UIColorFromRGB(0xA6CE57)];
    [labelcategory setLeftPadding:10.0f];
    labelcategory.delegate=self;
    [labelcategory setPlaceholder:@"选择类别"];
    
    [self addSubview:labelcategory];
    [labelcategory mas_makeConstraints:^(MASConstraintMaker *make) {
        //        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.centerY.equalTo(imgcategory);
        make.left.equalTo(imgcategory.mas_right).with.offset(12);
        make.right.equalTo(strongSelf).with.offset(-15);
        make.height.equalTo(@30);
    }];
    
    UILabel *labelaccount = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [labelaccount setStyle:fontsize_16 color:UIColorFromRGB(0xBBBBBB)];
    labelaccount.textAlignment=NSTextAlignmentLeft;
    [labelaccount setText:@"账单外记账"];
    [self addSubview:labelaccount];
    
    [labelaccount mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf).with.offset(15);
        make.top.equalTo(labelcategory.mas_bottom).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    
    UISwitch *switchaccount = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    switchaccount.on=NO;
    switchaccount.tintColor=UIColorFromRGB(0xcccccc);
    switchaccount.onTintColor=get_theme_color;
    [self addSubview:switchaccount];
    [switchaccount mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.right.equalTo(strongSelf.mas_right).with.offset(-15);
        make.centerY.equalTo(labelaccount);
    }];
    
    UILabel *labelaccount1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [labelaccount1 setStyle:fontsize_16 color:UIColorFromRGB(0xBBBBBB)];
    labelaccount1.textAlignment=NSTextAlignmentLeft;
    [labelaccount1 setText:@"隐私记账"];
    [self addSubview:labelaccount1];
    
    [labelaccount1 mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf).with.offset(15);
        make.top.equalTo(labelaccount.mas_bottom).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(80, 30));
    }];
    
    
    UISwitch *switchaccount1 = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    switchaccount1.on=NO;
    switchaccount1.tintColor=UIColorFromRGB(0xcccccc);
    switchaccount1.onTintColor=get_theme_color;
    [self addSubview:switchaccount1];
    [switchaccount1 mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.size.mas_equalTo(CGSizeMake(60, 30));
        make.right.equalTo(strongSelf.mas_right).with.offset(-15);
        make.centerY.equalTo(labelaccount1);
    }];
}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [get_theme_color CGColor]);
    CGContextFillRect(context,CGRectMake(0, 0, rect.size.width, 90));//填充框
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}

#pragma mark--交互事件
/**
 打开类别选择对话框
 
 @param sender 手势对象
 */
-(void)showCategory:(UITapGestureRecognizer *)sender{
    
    [((BaseViewController *)[self viewController]) hiddenKeyBoard];
    
    self.chooseWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.chooseWindow setBackgroundColor:[UIColor clearColor]];
    self.chooseWindow.alpha=1.0f;
    self.chooseWindow.windowLevel = UIWindowLevelAlert;
    self.chooseWindow.hidden=NO;
    
    UIView *rootview = [[UIView alloc] initWithFrame:self.chooseWindow.frame];
    rootview.backgroundColor=[UIColor grayColor];
    rootview.alpha=0.4f;
    UITapGestureRecognizer *hiddenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenAction:)];
    [rootview addGestureRecognizer:hiddenTap];
    [self.chooseWindow addSubview:rootview];
    
    CategoryChooseView *categoryView = [[CategoryChooseView alloc] initwithTagView:imgcategory];
    
    categoryView.delegate=self;
    
    CGRect targetrect = [self convertRect:imgcategory.frame toView:self.superview];
    
    [categoryView setFrame:CGRectMake(targetrect.origin.x + imgcategory.frame.size.width, 60, self.bounds.size.width - 55, targetrect.origin.y + 100)];
    
    [self.chooseWindow addSubview:categoryView];
    
    //    [categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(categoryView.mas_right).with.offset(15);
    //        make.bottom.equalTo(categoryView.mas_bottom).with.offset(20);
    //        make.right.equalTo(self.mas_right).with.offset(15);
    //        make.top.equalTo(self).with.offset(20);
    //    }];
}

-(void)hiddenAction:(UITapGestureRecognizer*)sender{
    if(self.chooseWindow!=nil){
        self.chooseWindow.hidden=YES;
        self.chooseWindow=nil;
    }
}

#pragma mark--协议
-(void)categorychooseView:(UIImage *)chooseImage category:(NSString *)category{
    if (imgcategory!=nil && chooseImage!=nil) {
        [imgcategory setImage:chooseImage];
    }
    
    if (labelcategory!=nil && category!=nil) {
        [labelcategory setText:category];
    }
}

/**
 选择日期
 
 @param sender <#sender description#>
 */
-(void)chooseDate:(id)sender{
    
    [((BaseViewController *)[self viewController]) hiddenKeyBoard];
    
    DLDatePickerView *picker = [[DLDatePickerView sharedInstance] initWithFrame:CGRectMake(0, ScreenSize.height-80, ScreenSize.width, 80)];
    picker.dateMode =UIDatePickerModeDateAndTime;
    picker.minDate = [[[NSDate date] dateForLastYear] objectAtIndex:0];
    picker.maxDate = [[[NSDate date] dateForNextYear] objectAtIndex:1];
    
    if([picker delegate]==nil){
        [picker setDelegate:self];
    }
    
    [picker show];
}

-(void)DLDatePickerView:(NSInteger)tag didSelectDate:(NSDate *)date{
    
    if (labeldate!=nil && date!=nil) {
        [labeldate setText:[date formatWithCode:dateformat_10]];
    }
    
}

@end
