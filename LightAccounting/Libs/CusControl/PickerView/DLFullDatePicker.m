//
//  DLFullDatePicker.m
//  LightAccounting
//
//  Created by ddllzz on 2017/8/21.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "DLFullDatePicker.h"

static const CGFloat headerHeight = 55.0f;

@implementation DateButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=UIColorFromRGB(0xFFFFFF);
        _isSelected = NO;
    }
    return self;
}

-(id)init{
    if (self==[super init]) {
        self.backgroundColor=UIColorFromRGB(0xFFFFFF);
        _isSelected = NO;
    }
    return self;
}

-(void)setIsSelected:(BOOL)isSelected{
    
    _isSelected = isSelected;
    
    [self setNeedsDisplay];
    
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if (_isSelected) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        /*写文字*/
        CGContextSetFillColorWithColor(context,[UIColor whiteColor].CGColor);
        //    CGContextSetRGBFillColor (context,  166, 209, 87, 1.0);//设置填充颜色
        CGContextFillRect(context,CGRectMake(0, rect.size.height-10, rect.size.width, 10));//填充框
    }
    
}

@end

@implementation DLFullDatePicker

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
    
    __weak typeof(self) weakSelf = self;
    
    labelMonth = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 40)];
    [labelMonth setStyle:fontsize_16 color:UIColorFromRGB(0xffffff)];
    labelMonth.textAlignment=NSTextAlignmentCenter;
    [labelMonth setText:@"2017年2月"];
    [self addSubview:labelMonth];
    
    [labelMonth mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.width.equalTo(strongSelf);
        make.left.equalTo(strongSelf);
        make.top.equalTo(strongSelf);
        make.height.equalTo(@40);
    }];
    
    UIImageView *leftimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [leftimage setImage:[UIImage imageNamed:@"icon_left"]];
    leftimage.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapleft = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(turnLeft:)];
    [leftimage addGestureRecognizer:tapleft];
    [self addSubview:leftimage];
    
    [leftimage mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.centerY.equalTo(labelMonth);
        make.left.equalTo(strongSelf.mas_left).with.offset(80);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    UIImageView *rightimage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    [rightimage setImage:[UIImage imageNamed:@"icon_right"]];
    rightimage.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapright = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(turnRight:)];
    [rightimage addGestureRecognizer:tapright];
    [self addSubview:rightimage];
    
    [rightimage mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.centerY.equalTo(labelMonth);
        make.right.equalTo(strongSelf.mas_right).with.offset(-80);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    float widthpercent = 1.0f/7.0f;
    
    labelsunday = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 30)];
    [labelsunday setStyle:fontsize_14 color:UIColorFromRGB(0xBBBBBB)];
    labelsunday.textAlignment=NSTextAlignmentCenter;
    [labelsunday setText:@"日"];
    [self addSubview:labelsunday];
    
    [labelsunday mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.width.mas_equalTo(strongSelf.mas_width).multipliedBy(widthpercent);
        make.left.equalTo(strongSelf);
        make.height.equalTo(@30);
        make.top.equalTo(labelMonth.mas_bottom);
    }];
    
    labelmonday = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 30)];
    [labelmonday setStyle:fontsize_14 color:UIColorFromRGB(0xBBBBBB)];
    labelmonday.textAlignment=NSTextAlignmentCenter;
    [labelmonday setText:@"一"];
    [self addSubview:labelmonday];
    
    [labelmonday mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.width.mas_equalTo(strongSelf.mas_width).multipliedBy(widthpercent);
        make.left.equalTo(labelsunday.mas_right);
        make.height.equalTo(@30);
        make.top.equalTo(labelMonth.mas_bottom);
    }];
    
    labeltuesday = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 30)];
    [labeltuesday setStyle:fontsize_14 color:UIColorFromRGB(0xBBBBBB)];
    labeltuesday.textAlignment=NSTextAlignmentCenter;
    [labeltuesday setText:@"二"];
    [self addSubview:labeltuesday];
    
    [labeltuesday mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.width.mas_equalTo(strongSelf.mas_width).multipliedBy(widthpercent);
        make.left.equalTo(labelmonday.mas_right);
        make.height.equalTo(@30);
        make.top.equalTo(labelMonth.mas_bottom);
    }];
    
    labelwednesday = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 30)];
    [labelwednesday setStyle:fontsize_14 color:UIColorFromRGB(0xBBBBBB)];
    labelwednesday.textAlignment=NSTextAlignmentCenter;
    [labelwednesday setText:@"三"];
    [self addSubview:labelwednesday];
    
    [labelwednesday mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.width.mas_equalTo(strongSelf.mas_width).multipliedBy(widthpercent);
        make.left.equalTo(labeltuesday.mas_right);
        make.height.equalTo(@30);
        make.top.equalTo(labelMonth.mas_bottom);
    }];
    
    labelthursday = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 30)];
    [labelthursday setStyle:fontsize_14 color:UIColorFromRGB(0xBBBBBB)];
    labelthursday.textAlignment=NSTextAlignmentCenter;
    [labelthursday setText:@"四"];
    [self addSubview:labelthursday];
    
    [labelthursday mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.width.mas_equalTo(strongSelf.mas_width).multipliedBy(widthpercent);
        make.left.equalTo(labelwednesday.mas_right);
        make.height.equalTo(@30);
        make.top.equalTo(labelMonth.mas_bottom);
    }];
    
    labelfriday = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 30)];
    [labelfriday setStyle:fontsize_14 color:UIColorFromRGB(0xBBBBBB)];
    labelfriday.textAlignment=NSTextAlignmentCenter;
    [labelfriday setText:@"五"];
    [self addSubview:labelfriday];
    
    [labelfriday mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.width.mas_equalTo(strongSelf.mas_width).multipliedBy(widthpercent);
        make.left.equalTo(labelthursday.mas_right);
        make.height.equalTo(@30);
        make.top.equalTo(labelMonth.mas_bottom);
    }];
    
    labelsaturday = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 30)];
    [labelsaturday setStyle:fontsize_14 color:UIColorFromRGB(0xBBBBBB)];
    labelsaturday.textAlignment=NSTextAlignmentCenter;
    [labelsaturday setText:@"六"];
    [self addSubview:labelsaturday];
    
    [labelsaturday mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.width.mas_equalTo(strongSelf.mas_width).multipliedBy(widthpercent);
        make.left.equalTo(labelfriday.mas_right);
        make.height.equalTo(@30);
        make.top.equalTo(labelMonth.mas_bottom);
    }];
    
    //绘制日历
    
    //end
}

-(void)setCurrentDate:(NSDate *)currentDate{
    _currentDate = currentDate;
    
    [labelMonth setText:[currentDate formatWithCode:@"yyyy年MM月"]];
    
    [self setNeedsLayout];
}

-(void)setSelectedDate:(NSDate *)selectedDate{
    _currentDate = selectedDate;
    _selectedDate = selectedDate;
    [labelMonth setText:[selectedDate formatWithCode:@"yyyy年MM月"]];
    
    [self setNeedsLayout];
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    if (calanerView!=nil) {
        [calanerView removeFromSuperview];
    }
    
    calanerView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, self.frame.size.width, 210)];
    calanerView.backgroundColor = UIColorFromRGB(0xefefef);
    [self addSubview:calanerView];
    
    int maxrow = 6;
    
    float unitwidth = self.frame.size.width / 7;
    
    float unitheight = 40;
    
    float spaceleft = (unitwidth - 30)/2;
    
    float spacetop = 5;
    
    __weak __typeof(calanerView) weakself = calanerView;
    
//    UIColor *normalColor = UIColorFromRGB(0xDEDEDE);
    UIColor *normalColor = get_theme_color;
    UIColor *selectedColor = get_theme_color;
    
    NSArray *monthrange = [_currentDate dateForCurrentMonth];
    NSInteger today = [[NSDate dateWithZone] day];
    NSInteger month = [[NSDate dateWithZone] month];
    NSInteger year = [[NSDate dateWithZone] year];
    NSInteger maxday = [[monthrange objectAtIndex:1] day];
    NSInteger weekday = [[monthrange objectAtIndex:0] weekday];
    weekday = weekday -1;
    for (int row=0; row<6; row++) {
        for(int col = 0;col<7;col++){
            if (row==0) {
                if (col>=weekday) {
                    DateButton *btnday = [[DateButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
                    btnday.layer.cornerRadius = 15;
                    btnday.layer.masksToBounds=YES;
                    NSString *daystring = (today==col&&year == [_currentDate year]&&month==[_currentDate month])?@"今":[NSString stringWithFormat:@"%ld",col - weekday + 1];
//                    if ([daystring isEqualToString:@"今"]) {
//                        btnday.isSelected=YES;
//                        selectedButton = btnday;
//                    }
                    btnday.tag=(row*7+(col)-weekday+1);
                    
                    if (btnday.tag==[_selectedDate day]&&[_currentDate year]==[_selectedDate year]&&[_currentDate month]==[_selectedDate month]) {
                        btnday.isSelected=YES;
                        selectedButton = btnday;
                    }
                    
                    [btnday setTitle:daystring forState:UIControlStateNormal];
                    [btnday setBackgroundColor:normalColor];
                    
                    [btnday addTarget:self action:@selector(selectedDateChanged:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [calanerView addSubview:btnday];
                    
                    [btnday mas_makeConstraints:^(MASConstraintMaker *make) {
                        __strong __typeof(weakself) strongself = weakself;
                        make.size.mas_equalTo(CGSizeMake(30, 30));
                        make.left.equalTo(strongself).with.offset(col*unitwidth+spaceleft);
                        make.top.equalTo(strongself).with.offset(spacetop);
                    }];
                    
                }else{
                    continue;
                }
            }else{
                if((row*7+(col)-weekday+1)>maxday){
                    if (col==0) {
                        maxrow = row-1;
                    }else{
                        maxrow = row;
                    }
                    row++;
                    break;
                }else{
                    DateButton *btnday = [[DateButton alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
                    btnday.layer.cornerRadius = 15;
                    btnday.layer.masksToBounds=YES;
                    NSString *daystring = (today==(row*7+(col)-weekday+1)&&year == [_currentDate year]&&month==[_currentDate month])?@"今":[NSString stringWithFormat:@"%ld",row*7+(col)-weekday+1];
//                    if ([daystring isEqualToString:@"今"]) {
//                        btnday.isSelected=YES;
//                        selectedButton = btnday;
//                    }
                    btnday.tag=(row*7+(col)-weekday+1);
                    
                    if (btnday.tag==[_selectedDate day]&&[_currentDate year]==[_selectedDate year]&&[_currentDate month]==[_selectedDate month]) {
                        btnday.isSelected=YES;
                        selectedButton = btnday;
                    }
                    
                    [btnday setTitle:daystring forState:UIControlStateNormal];
                    
                    if (col%2==0) {
                        [btnday setBackgroundColor:selectedColor];
                    }
                    else{
                        [btnday setBackgroundColor:normalColor];
                    }
                    
                    
                    [btnday addTarget:self action:@selector(selectedDateChanged:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [calanerView addSubview:btnday];
                    
                    [btnday mas_makeConstraints:^(MASConstraintMaker *make) {
                        __strong __typeof(weakself) strongself = weakself;
                        make.size.mas_equalTo(CGSizeMake(30, 30));
                        make.left.equalTo(strongself).with.offset(col*unitwidth+spaceleft);
                        make.top.equalTo(strongself).with.offset(unitheight*row+spacetop);
                    }];
                }
            }
        }
    }
    
    if (maxrow==4) {
        calanerView.frame = CGRectMake(0, 70, self.frame.size.width, 210);
        //        [self mas_updateConstraints:^(MASConstraintMaker *make) {
        //            make.height.mas_equalTo(@280);
        //        }];
//        self.frame = CGRectMake(0, 0, ScreenSize.width, 280);
        [self setBounds:CGRectMake(0, 0, self.frame.size.width, 280+35)];
        self.initHeight = 280;
        if (self.layoutchanged) {
            self.layoutchanged(280);
        }
    }else{
        calanerView.frame = CGRectMake(0, 70, self.frame.size.width, 250);
        //        [self mas_updateConstraints:^(MASConstraintMaker *make) {
        //            make.height.mas_equalTo(@320);
        //        }];
//        self.frame = CGRectMake(0, 0, ScreenSize.width, 320);
        [self setBounds:CGRectMake(0, 0, self.frame.size.width, 320+35)];
        self.initHeight = 320;
        if (self.layoutchanged) {
            self.layoutchanged(320);
        }
    }
    
    if (closebutton==nil) {
        closebutton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.initHeight, self.frame.size.width/2, 35)];
        [closebutton setBackgroundColor:UIColorFromRGB(0x999999)];
        [closebutton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        [closebutton setTitle:@"关闭" forState:UIControlStateNormal];
        [closebutton.titleLabel setFont:fontsize_14];
        [closebutton addTarget:self action:@selector(closePicker:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:closebutton];
    }
    
    [closebutton setFrame:CGRectMake(0, self.initHeight, self.frame.size.width/2, 35)];
    
    if(comfirmbutton==nil){
        comfirmbutton = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2, self.initHeight, self.frame.size.width/2, 35)];
        [comfirmbutton setBackgroundColor:get_theme_color];
        [comfirmbutton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        [comfirmbutton setTitle:@"确定" forState:UIControlStateNormal];
        [comfirmbutton.titleLabel setFont:fontsize_14];
        [comfirmbutton addTarget:self action:@selector(comfirmChoose:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:comfirmbutton];
        
        [self setBounds:CGRectMake(0, 0, self.frame.size.width, self.initHeight+35)];
    }
    
    [comfirmbutton setFrame:CGRectMake(self.frame.size.width/2, self.initHeight, self.frame.size.width/2, 35)];
    
}

#pragma mark---翻页事件
-(void)turnLeft:(UITapGestureRecognizer *)sender{
    
    NSArray *lastarray = [_currentDate dateForLastMonth];
    [self setCurrentDate:[lastarray objectAtIndex:1]];
    
}

-(void)turnRight:(UITapGestureRecognizer *)sender{
    
    NSArray *lastarray = [_currentDate dateForNextMonth];
    [self setCurrentDate:[lastarray objectAtIndex:1]];
    
}

-(void)closePicker:(UIButton *)sender{
    
    [self removeFromSuperview];
    chooseWindow.hidden = YES;
    chooseWindow = nil;
    
}

-(void)comfirmChoose:(UIButton *)sender{
    
    if (self.didSelected) {
        self.didSelected(_selectedDate);
    }
    
    [self closePicker:nil];
    
}

#pragma mark---选中事件
-(void)selectedDateChanged:(DateButton *)sender{
    
    NSString *date = [NSString stringWithFormat:@"%@-%@-%@ 00:00:00",[[NSString stringWithFormat:@"%ld",[_currentDate year]] padLeftWithChar:2 charstring:@"0"],[[NSString stringWithFormat:@"%ld",[_currentDate month]] padLeftWithChar:2 charstring:@"0"],[[NSString stringWithFormat:@"%ld",sender.tag] padLeftWithChar:2 charstring:@"0"]];
    _selectedDate = [date convertDateFromString:@"yyyy-MM-dd HH:mm:ss"];
    
    if (selectedButton!=nil) {
        [selectedButton setIsSelected:NO];
    }
    
    selectedButton = sender;
    [selectedButton setIsSelected:YES];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [get_theme_color CGColor]);
    CGContextFillRect(context,CGRectMake(0, 0, rect.size.width, 40));//填充框

}

#pragma mark---日期控件交互事件
-(void)showDatePicker:(void(^)(NSDate *))selectedCallback{
    chooseWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [chooseWindow setBackgroundColor:[UIColor clearColor]];
    chooseWindow.alpha=1.0f;
    chooseWindow.windowLevel = UIWindowLevelAlert;
    chooseWindow.hidden=NO;
    
    UIView *rootview = [[UIView alloc] initWithFrame:chooseWindow.frame];
    rootview.backgroundColor=[UIColor grayColor];
    rootview.alpha=0.4f;
    [chooseWindow addSubview:rootview];
    
    self.didSelected = ^(NSDate *selecteddate) {
        if (selectedCallback!=nil) {
            selectedCallback(selecteddate);
        }
    };
    self.hidden = YES;
    [chooseWindow addSubview:self];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        self.hidden=NO;
        
        CABasicAnimation *theAnimation;
        theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
        theAnimation.duration=0.3;
        //            theAnimation.delegate=self;
        theAnimation.fillMode=kCAFillModeForwards;
        theAnimation.removedOnCompletion = NO;
        theAnimation.fromValue = [NSNumber numberWithFloat:0];
        theAnimation.toValue = [NSNumber numberWithFloat:1];
        [self.layer addAnimation:theAnimation forKey:@"animateTransform"];
        
    });
    
}

@end
