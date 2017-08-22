//
//  NewStep1View.m
//  LightAccounting
//
//  Created by ddllzz on 17/3/26.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "NewStep1View.h"

@implementation NewStep1View

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        
        [self initlayout];
    }
    return self;
}

-(instancetype)initWithTypeFrame:(int)type id:(NSString *)id frame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        
        self.accountType = type;
        self.id = id;
        
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
    
    UIImageView *imgremark= [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
    [imgremark setImage:[UIImage imageNamed:@"icon_note"]];
    [self addSubview:imgremark];
    
    [imgremark mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf).with.offset(15);
        make.top.equalTo(strongSelf).with.offset(110);
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
    [labeldate setText:[[NSDate dateWithZone] formatWithCode:@"yyyy年MM月dd日"]];
    
    [self addSubview:labeldate];
    
    [labeldate mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.centerY.equalTo(imgdate);
        make.left.equalTo(imgdate.mas_right).with.offset(12);
        make.right.equalTo(strongSelf).with.offset(-15);
        make.height.equalTo(@30);
    }];
    
    if (self.accountType==0) {
        //收入布局
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
            make.top.equalTo(labeldate.mas_bottom).with.offset(25);
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
        
        UILabel *labelAlert1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [labelAlert1 setStyle:fontsize_16 color:UIColorFromRGB(0xBBBBBB)];
        labelAlert1.textAlignment=NSTextAlignmentLeft;
        [labelAlert1 setText:@"隐私记账"];
        [self addSubview:labelAlert1];
        
        [labelAlert1 mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            make.left.equalTo(strongSelf).with.offset(15);
            make.top.equalTo(labelcategory.mas_bottom).with.offset(25);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        
        
        switchAlert1 = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        switchAlert1.on=NO;
        switchAlert1.tintColor=UIColorFromRGB(0xcccccc);
        switchAlert1.onTintColor=get_theme_color;
        [self addSubview:switchAlert1];
        [switchAlert1 mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            make.size.mas_equalTo(CGSizeMake(60, 30));
            make.right.equalTo(strongSelf.mas_right).with.offset(-15);
            make.centerY.equalTo(labelAlert1);
        }];
    }else{
        //支出布局
        UIImageView *imgmap = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 30, 30)];
        [imgmap setImage:[UIImage imageNamed:@"icon_map"]];
        UITapGestureRecognizer *selectlocationTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoLocationTap:)];
        imgmap.userInteractionEnabled=YES;
        [imgmap addGestureRecognizer:selectlocationTap];
        [self addSubview:imgmap];
        
        [imgmap mas_makeConstraints:^(MASConstraintMaker *make) {
            //        @strongify(self);
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            make.left.equalTo(strongSelf).with.offset(15);
            make.top.equalTo(imgdate.mas_bottom).with.offset(25);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
        labelmap = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.bounds.size.width-30-40, 30)];
        [labelmap setBackgroundColor:UIColorFromRGB(0xE6E6E6)];
        [labelmap setTextColor:UIColorFromRGB(0xA6CE57)];
        [labelmap setLeftPadding:10.0f];
        labelmap.delegate=self;
        [labelmap setText:@"正在获取位置"];
        
        [self addSubview:labelmap];
        [labelmap mas_makeConstraints:^(MASConstraintMaker *make) {
            //        @strongify(self);
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            make.centerY.equalTo(imgmap);
            make.left.equalTo(imgmap.mas_right).with.offset(12);
            make.right.equalTo(strongSelf).with.offset(-15);
            make.height.equalTo(@30);
        }];
        
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
            make.top.equalTo(imgmap.mas_bottom).with.offset(25);
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
        
        UILabel *labelAlert = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [labelAlert setStyle:fontsize_16 color:UIColorFromRGB(0xBBBBBB)];
        labelAlert.textAlignment=NSTextAlignmentLeft;
        [labelAlert setText:@"额外消费"];
        [self addSubview:labelAlert];
        
        [labelAlert mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            make.left.equalTo(strongSelf).with.offset(15);
            make.top.equalTo(labelcategory.mas_bottom).with.offset(25);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        
        
        switchAlert = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        switchAlert.on=NO;
        switchAlert.tintColor=UIColorFromRGB(0xcccccc);
        switchAlert.onTintColor=get_theme_color;
        [self addSubview:switchAlert];
        [switchAlert mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            make.size.mas_equalTo(CGSizeMake(60, 30));
            make.right.equalTo(strongSelf.mas_right).with.offset(-15);
            make.centerY.equalTo(labelAlert);
        }];
        
        UILabel *labelAlert1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
        [labelAlert1 setStyle:fontsize_16 color:UIColorFromRGB(0xBBBBBB)];
        labelAlert1.textAlignment=NSTextAlignmentLeft;
        [labelAlert1 setText:@"隐私记账"];
        [self addSubview:labelAlert1];
        
        [labelAlert1 mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            make.left.equalTo(strongSelf).with.offset(15);
            make.top.equalTo(labelAlert.mas_bottom).with.offset(25);
            make.size.mas_equalTo(CGSizeMake(80, 30));
        }];
        
        
        switchAlert1 = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        switchAlert1.on=NO;
        switchAlert1.tintColor=UIColorFromRGB(0xcccccc);
        switchAlert1.onTintColor=get_theme_color;
        [self addSubview:switchAlert1];
        [switchAlert1 mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            make.size.mas_equalTo(CGSizeMake(60, 30));
            make.right.equalTo(strongSelf.mas_right).with.offset(-15);
            make.centerY.equalTo(labelAlert1);
        }];
    }
    
    
}


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [get_theme_color CGColor]);
    CGContextFillRect(context,CGRectMake(0, 0, rect.size.width, 90));//填充框
}

/**
 禁止日期，地图，类别输入

 @param textField 输入框
 @return 禁止输入NO
 */
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    if ([textField isEqual:labeldate]) {
        [self chooseDate:nil];
    }else if([textField isEqual:labelmap]){
        [self gotoLocationTap:nil];
    }else if([textField isEqual:labelcategory]){
        [self showCategory:nil];
    }
    
    return NO;
}

/**
 子视图布局，用于最后绘制数据
 */
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    mapservice = [[BMKLocationService alloc] init];
    mapservice.delegate=self;
    geocodesearch = [[BMKGeoCodeSearch alloc] init];
    geocodesearch.delegate=self;
    [mapservice startUserLocationService];
    
}

/**
 定位结果返回
 
 @param userLocation <#userLocation description#>
 */
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    if(userLocation.location!=nil) {
        
        CLLocationCoordinate2D pt;
        pt = userLocation.location.coordinate;
        pt.latitude= userLocation.location.coordinate.latitude;
        pt.longitude= userLocation.location.coordinate.longitude;
        [mapservice stopUserLocationService];
        //反编码地理位置
        self.viewmodel.model.bdx = [NSString stringWithFormat:@"%lf",pt.latitude];
        self.viewmodel.model.bdy = [NSString stringWithFormat:@"%lf",pt.longitude];
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
        reverseGeocodeSearchOption.reverseGeoPoint= pt;
        [geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    }else{
        [labelmap setText:@"获取位置失败，尝试重新获取"];
    }
}
/**
 返回地理编码位置结果
 
 @param searcher <#searcher description#>
 @param result <#result description#>
 @param error <#error description#>
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    if (result) {
        [labelmap setText:[NSString stringWithFormat:@"%@", result.address]];
        self.viewmodel.model.bdaddress = result.address;
    } else {
        [labelmap setText:@"获取位置失败"];
    }
    [self stopLocation];
}

/**
 停止定位，viewcontroll出栈时调用
 */
-(void)stopLocation{
    if (mapservice!=nil) {
        [mapservice stopUserLocationService];
    }
    geocodesearch.delegate=nil;
    mapservice.delegate=nil;
    
    geocodesearch = nil;
    mapservice=nil;
}

#pragma mark--交互事件

/**
 跳转至选择位置

 @param sender 手势对象
 */
-(void)gotoLocationTap:(UITapGestureRecognizer *)sender{
    
    MapChooseViewController *mapcontroller = [[MapChooseViewController alloc] init];
    mapcontroller.chooseCallback = ^(id sender, NSString *address, double lat, double lng) {
        [labelmap setText:address];
        self.viewmodel.model.bdx = [NSString stringWithFormat:@"%lf",lat];
        self.viewmodel.model.bdy = [NSString stringWithFormat:@"%lf",lng];
        self.viewmodel.model.bdaddress = address;
    };
    
    [[self viewController].navigationController pushViewController:mapcontroller animated:YES];
    
}
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
    
    categoryView.source = categoryarray;
    
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
-(void)categorychooseView:(UIImage *)chooseImage category:(CategoryModel *)category{
    
    if (chooseImage==nil&&category==nil) {
        [self hiddenAction:nil];
        [[self viewController].navigationController pushViewController:[[CategoryViewController alloc] initWithType:(self.accountType==0)] animated:YES];
        
    }else{
        
        if (imgcategory!=nil && chooseImage!=nil) {
            [imgcategory setImage:chooseImage];
        }
        
        if (labelcategory!=nil && category!=nil) {
            [labelcategory setText:category.CNAME];
        }
        
        self.viewmodel.model.cid = category.CID;
        
        [self hiddenAction:nil];
        
    }
    
}

/**
 选择日期

 @param sender 发起者
 */
-(void)chooseDate:(id)sender{
    
    [((BaseViewController *)[self viewController]) hiddenKeyBoard];
    
    float maxheight = 600;
    
    if (ScreenSize.height - 120 < 600) {
        maxheight = ScreenSize.height - 120;
    }
    
    DLFullDatePicker *picker = [[DLFullDatePicker alloc] initWithFrame:CGRectMake(20, 60, ScreenSize.width-40, maxheight)];
    picker.selectedDate = [labeldate.text convertDateFromString:@"yyyy年MM月dd日"];
    [picker showDatePicker:^(NSDate *result) {
        
        [labeldate setText:[result formatWithCode:@"yyyy年MM月dd日"]];
        
    }];
}

-(void)DLDatePickerView:(NSInteger)tag didSelectDate:(NSDate *)date{
    
    if (labeldate!=nil && date!=nil) {
        [labeldate setText:[date formatWithCode:dateformat_10]];
        self.viewmodel.model.createtime = date;
    }
    
}

#pragma mark---数据操作放到文档最后
-(void)setViewmodel:(ExpendViewModel *)viewmodel{
    
    _viewmodel = viewmodel;
    model = [[NewExpendModel alloc] init];
    if (self.accountType==0) {
        //收入
        if (self.id!=nil && ![self.id isEqualToString:@""]) {
            //修改
        }else{
            //新增
            model.evalue = self.inputmoney.text;
            model.createtime = [NSDate dateWithZone];
            model.fid = [self.viewmodel getDefaultFamily].fid;
            model.isprivate = 0;
            model.outbudget = 0;
        }
        categoryarray = [self.viewmodel getIncomeCategory];
    }else{
        //支出
        if (self.id!=nil && ![self.id isEqualToString:@""]) {
            //修改
        }else{
            //新增
            model.evalue = self.inputmoney.text;
            model.createtime = [NSDate dateWithZone];
            model.fid = [self.viewmodel getDefaultFamily].fid;
            model.isprivate = 0;
            model.outbudget = 0;
        }
        categoryarray = [self.viewmodel getExpendCategory];
    }
    
    self.viewmodel.model = model;
    
}

#pragma mark---属性监视

/**
 添加属性监视
 */
-(void)addObserve{
    //添加属性监视KVO
    [self.inputmoney addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.labelremark addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    if (switchAlert!=nil) {
        [switchAlert addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    if (switchAlert1!=nil) {
        [switchAlert1 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    }
}

/**
 移除属性监视
 */
-(void)removeObserve{
    [self.inputmoney removeTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.labelremark removeTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    if (switchAlert!=nil) {
        [switchAlert removeTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    if (switchAlert1!=nil) {
        [switchAlert1 removeTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    }
}

-(void)textFieldChanged:(UITextField *)sender{
    if ([sender isEqual:self.inputmoney]) {
        self.viewmodel.model.evalue = self.inputmoney.text;
    }else if([sender isEqual:self.labelremark]){
        self.viewmodel.model.imark = self.labelremark.text;
    }
}
-(void)switchChanged:(UISwitch *)sender{
    if([sender isEqual:switchAlert]){
        self.viewmodel.model.outbudget = (switchAlert.on==YES?1:0);
    }else if([sender isEqual:switchAlert1]){
        self.viewmodel.model.isprivate = (switchAlert1.on ==YES?1:0);
    }
}
@end
