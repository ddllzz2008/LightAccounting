//
//  BillViewController.m
//  LightAccounting
//
//  Created by ddllzz on 17/4/11.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BillViewController.h"

@interface BillViewController ()

@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_filter"] style:UIBarButtonItemStyleDone target:self action:@selector(navigateDetail)];
    self.navigationItem.rightBarButtonItem = rightitem;
    self.navigationItem.rightBarButtonItem.tintColor = UIColorFromRGB(0xffffff);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabbar];
    
    /*----------刷新主题颜色----------------*/
    UIColor *themecolor = get_theme_color;
    [choosedateview refreshTheme];
    [segmentControl setTintColor:themecolor];
    [totalmoney setTextColor:themecolor];
    [lefttableview setBackgroundColor:themecolor];
    [detailmoney setTextColor:themecolor];
    [righttableview reloadData];
}

-(void)initControls{
    
    choosedateview = [[BillDateChooseView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 60)];
    choosedateview.delegate=self;
    choosedateview.mode=BillDateChooseModeYearMonth;
    choosedateview.currentDate = [NSDate dateWithZone];
    [self.view addSubview:choosedateview];
    
    /*--------------左边容器-------------------*/
    
    viewleft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height)];
    viewleft.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:viewleft];
    
    __weak typeof(self.view) weakSelf = self.view;
    
    [viewleft mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.top.equalTo(choosedateview.mas_bottom).with.offset(5);
        make.left.equalTo(strongSelf);
        make.bottom.equalTo(strongSelf);
        make.width.mas_equalTo(ScreenSize.width);
    }];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"支出",@"收入",nil];
    segmentControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    segmentControl.frame = CGRectMake(0, 0, ScreenSize.width/2, 30);
    segmentControl.segmentedControlStyle=UISegmentedControlStylePlain;
    segmentControl.selectedSegmentIndex=0;
    [segmentControl setTintColor:get_theme_color];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:fontsize_14,UITextAttributeFont ,nil];
    [segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    [segmentControl addTarget:self action:@selector(billtypeChanged:) forControlEvents:UIControlEventValueChanged];
    [viewleft addSubview:segmentControl];
    
    __weak typeof(viewleft) weakviewleft = viewleft;
    
    [segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakviewleft) strongviewleft = weakviewleft;
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width/2, 30));
        make.centerX.equalTo(strongviewleft);
        make.top.equalTo(strongviewleft);
    }];
    
    totalmoney = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 20)];
    [totalmoney setTextColor:get_theme_color];
    [totalmoney setTextAlignment:NSTextAlignmentCenter];
    [totalmoney setFont:fontsize_26];
//    [totalmoney setText:@"1,5000.0"];
    [viewleft addSubview:totalmoney];
    
    [totalmoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 20));
        make.top.equalTo(segmentControl.mas_bottom).with.offset(20);
    }];
    
    chartview = [[BillChartView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 150)];
    [viewleft addSubview:chartview];
    
    [chartview mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakviewleft) strongviewleft = weakviewleft;
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width-30, 150));
        make.left.equalTo(strongviewleft.mas_left).with.offset(15);
        make.top.equalTo(totalmoney.mas_bottom).with.offset(5);
    }];
    
    lefttableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-30, 40)];
    [lefttableview setBackgroundColor:get_theme_color];
    lefttableview.delegate=self;
    lefttableview.dataSource = self;
    lefttableview.layer.cornerRadius = 10;
    lefttableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    lefttableview.allowsSelection = NO;
    lefttableview.showsVerticalScrollIndicator = NO;
    [lefttableview registerClass:[BillTableCell class] forCellReuseIdentifier:@"billtablecell"];
    [viewleft addSubview:lefttableview];
    
    [lefttableview mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakviewleft) strongviewleft = weakviewleft;
        make.left.equalTo(strongviewleft).with.offset(15);
        make.width.mas_equalTo(ScreenSize.width - 30);
        make.centerX.equalTo(strongviewleft);
        make.bottom.equalTo(strongviewleft.mas_bottom).with.offset(-60);
        make.top.equalTo(chartview.mas_bottom).with.offset(10);
    }];
    
    
    /*--------------右边容器-------------------*/
    
    viewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height)];
    viewright.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:viewright];
    
    [viewright mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(viewleft.mas_top);
        make.left.equalTo(viewleft.mas_right);
        make.bottom.equalTo(viewleft.mas_bottom);
        make.width.mas_equalTo(ScreenSize.width);
    }];
    
    __weak typeof(viewright) weakviewright = viewright;
    
    detailmoney = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 20)];
    [detailmoney setTextColor:get_theme_color];
    [detailmoney setTextAlignment:NSTextAlignmentCenter];
    [detailmoney setFont:fontsize_16];
//    [detailmoney setText:@"收入：2万 ／ 支出：1,854.0"];
    [viewright addSubview:detailmoney];
    
    [detailmoney mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakviewright) strongviewright = weakviewright;
        make.centerX.equalTo(strongviewright);
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 25));
        make.top.equalTo(strongviewright).with.offset(0);
    }];
    
    righttableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-30, 40)];
    [righttableview setBackgroundColor:[UIColor clearColor]];
    righttableview.delegate=self;
    righttableview.dataSource = self;
    righttableview.layer.cornerRadius = 10;
    righttableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    righttableview.allowsSelection = NO;
    righttableview.showsVerticalScrollIndicator = NO;
    [righttableview registerClass:[BillDetailTableCell class] forCellReuseIdentifier:@"billdetailtablecell"];
    [viewright addSubview:righttableview];
    
    [righttableview mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakviewright) strongviewright = weakviewright;
        make.left.equalTo(strongviewright).with.offset(15);
        make.width.mas_equalTo(ScreenSize.width - 30);
        make.centerX.equalTo(strongviewright);
        make.bottom.equalTo(strongviewright.mas_bottom).with.offset(-60);
        make.top.equalTo(detailmoney.mas_bottom).with.offset(10);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark----UITable协议（分为汇总tableview和详细tableview）
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([tableView isEqual:lefttableview]) {
        return 1;
    }else{
        return self.viewmodel.rightsource.count;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([tableView isEqual:lefttableview]) {
        return self.viewmodel.leftsource.count;
    }else{
        return [[self.viewmodel.rightsource objectAtIndex:section] count];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:righttableview]) {
        BillDetailSectionCell *cellsection = [[BillDetailSectionCell alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
        if (section==0) {
            [cellsection setIfFirstLine:YES];
        }else{
            [cellsection setIfFirstLine:NO];
        }
        
        BusExpenditure *model =  [[self.viewmodel.rightsource objectAtIndex:section] objectAtIndex:0];
        
        NSArray *arr = [self.viewmodel.rightsource objectAtIndex:section];
        
        float totalvalue = [[arr valueForKeyPath:@"@sum.EVALUE"] floatValue];
        
        [cellsection setDate:[[model.CREATETIME convertDateFromString:@"yyyy-MM-dd"] formatWithCode:@"MM-dd"]];
        [cellsection setMoney:[NSString stringWithFormat:@"%.1f",totalvalue]];
        return cellsection;
    }
    return nil;
}

// 设置cell
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if ([tableView isEqual:lefttableview]) {
        static NSString *idetifier = @"billtablecell";
        BillTableCell *cell = (BillTableCell *)[tableView dequeueReusableCellWithIdentifier:idetifier forIndexPath:indexPath];
        if (cell) {
            
            NSDictionary *dic = [self.viewmodel.leftsource objectAtIndex:indexPath.item];
            
            [cell setTypeName:[dic objectForKey:@"name"]];
            if (self.viewmodel.currentType==0) {
                [cell setSpendMoney:0 - [[dic objectForKey:@"evalue"] floatValue]];
            }else{
                [cell setSpendMoney:[[dic objectForKey:@"evalue"] floatValue]];
            }
            
            [cell setSpendPercent:[[dic objectForKey:@"percent"] floatValue]];
        }
        return cell;
    }else{
        static NSString *idetifier = @"billdetailtablecell";
        BillDetailTableCell *cell = (BillDetailTableCell *)[tableView dequeueReusableCellWithIdentifier:idetifier forIndexPath:indexPath];
        if (cell) {
            
            BusExpenditure *model = [[self.viewmodel.rightsource objectAtIndex:indexPath.section] objectAtIndex:indexPath.item];
            
            [cell setTypeImage:[UIImage imageNamed:[NSString stringWithFormat:@"category_%@",model.CCOLOR]]];
            [cell setTypeName:model.CNAME];
            [cell setTypeSection:model.TYPE==0?@"支出":@"收入"];
            [cell setDetailNumber:[NSString stringWithFormat:@"%.1f",model.EVALUE]];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if ([tableView isEqual:lefttableview]) {
        return 0;
    }else{
        return 50;
    }
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 40;
}

#pragma mark---跳转事件

/**
 打开筛选面板
 */
-(void)navigateDetail{
    chooseWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [chooseWindow setBackgroundColor:[UIColor clearColor]];
    chooseWindow.alpha=1.0f;
    chooseWindow.windowLevel = UIWindowLevelAlert;
    chooseWindow.hidden=NO;
    
    UIView *rootview = [[UIView alloc] initWithFrame:chooseWindow.frame];
    rootview.backgroundColor=[UIColor grayColor];
    rootview.alpha=0.4f;
    UITapGestureRecognizer *hiddenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenAction:)];
    [rootview addGestureRecognizer:hiddenTap];
    [chooseWindow addSubview:rootview];
    
    filterview = [[FilterUIView alloc] initWithFrame:CGRectMake(ScreenSize.width/3, 0, ScreenSize.width*2/3, ScreenSize.height)];
    filterview.delegate=self;
    filterview.categorySource = [self.viewmodel loadCategory];
    
    [filterview setMinValue:[self.viewmodel minvalue]];
    [filterview setMaxValue:[self.viewmodel maxvalue]];
    [filterview setCategories:[self.viewmodel categories]];
    [filterview setOutlet:[self.viewmodel isoutlet]];
    [filterview setPrivate:[self.viewmodel isprivate]];
    
    [chooseWindow addSubview:filterview];
    
    [self addTextFieldResponser:filterview.minfield];
    [self addTextFieldResponser:filterview.maxfield];
    
}

-(void)hiddenAction:(UITapGestureRecognizer*)sender{
    
    if ([self iskeyboardShow]) {
        [self hiddenKeyBoard];
    }else{
        if (filterview!=nil) {
            filterview.delegate=self;
            [filterview removeFromSuperview];
            filterview = nil;
        }
        
        if(chooseWindow!=nil){
            
            chooseWindow.hidden=YES;
            chooseWindow=nil;
        }
    }
}

#pragma mark---滑动手势
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    isscroll = NO;
    UITouch *touch = [touches anyObject];
    if (touch) {
        CGPoint location = [touch locationInView:self.view];
        
        if ([viewleft pointInside:location withEvent:nil]) {
            
            //防止uitableview被响应
            if (location.y>segmentControl.frame.size.height+choosedateview.frame.size.height) {
                return;
            }
            
            if (viewleft.frame.origin.x>0) {
                viewleft.frame = CGRectMake(0, viewleft.frame.origin.y, viewleft.frame.size.width, viewleft.frame.size.height);
                viewright.frame = CGRectMake(ScreenSize.width, viewright.frame.origin.y, viewright.frame.size.width, viewright.frame.size.height);
                return;
            }else if(viewleft.frame.origin.x<(0-ScreenSize.width)){
                viewleft.frame = CGRectMake(0-ScreenSize.width, viewleft.frame.origin.y, viewleft.frame.size.width, viewleft.frame.size.height);
                viewright.frame = CGRectMake(0, viewright.frame.origin.y, viewright.frame.size.width, viewright.frame.size.height);
                return;
            }
            
            CGPoint prevLocation = [touch previousLocationInView:self.view];
            
            if (viewleft.frame.origin.x+(location.x - prevLocation.x)>0) {
                viewleft.frame = CGRectMake(0, viewleft.frame.origin.y, viewleft.frame.size.width, viewleft.frame.size.height);
                viewright.frame = CGRectMake(ScreenSize.width, viewright.frame.origin.y, viewright.frame.size.width, viewright.frame.size.height);
                return;
            }else if(viewleft.frame.origin.x+(location.x - prevLocation.x)<(0-ScreenSize.width)){
                viewleft.frame = CGRectMake(0-ScreenSize.width, viewleft.frame.origin.y, viewleft.frame.size.width, viewleft.frame.size.height);
                viewright.frame = CGRectMake(0, viewright.frame.origin.y, viewright.frame.size.width, viewright.frame.size.height);
                return;
            }
            
            if (location.x - prevLocation.x > 0) {
                //finger touch went right
                lastdirection = 1;
            } else {
                //finger touch went left
                lastdirection = 2;
            }
            
            viewleft.frame = CGRectMake(viewleft.frame.origin.x+(location.x - prevLocation.x), viewleft.frame.origin.y, viewleft.frame.size.width, viewleft.frame.size.height);
            viewright.frame = CGRectMake(viewright.frame.origin.x+(location.x - prevLocation.x), viewright.frame.origin.y, viewright.frame.size.width, viewright.frame.size.height);
            
            if (location.y - prevLocation.y > 0) {
                //finger touch went upwards
            } else {
                //finger touch went downwards
            }
            
            isscroll = YES;
        }
    }
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    if (!isscroll) {
//        return;
//    }
    
    UITouch *touch = [touches anyObject];
    if (touch) {
        CGPoint location = [touch locationInView:self.view];
        
        if ([viewleft pointInside:location withEvent:nil]) {
            
            if (lastdirection==1) {
                //向右滑
                if (viewleft.frame.origin.x>(0-ScreenSize.width*3/4)) {
                    
                    //切换到第一个
                    [UIView animateWithDuration:0.2 animations:^{
                        viewleft.frame = CGRectMake(0, viewleft.frame.origin.y, viewleft.frame.size.width, viewleft.frame.size.height);
                        viewright.frame = CGRectMake(ScreenSize.width, viewright.frame.origin.y, viewright.frame.size.width, viewright.frame.size.height);
                    } completion:^(BOOL finished) {
                        
                        
                    }];
                    
                }else{
                    //切换到第二个
                    [UIView animateWithDuration:0.2 animations:^{
                        viewleft.frame = CGRectMake(0-ScreenSize.width, viewleft.frame.origin.y, viewleft.frame.size.width, viewleft.frame.size.height);
                        viewright.frame = CGRectMake(0, viewright.frame.origin.y, viewright.frame.size.width, viewright.frame.size.height);
                    } completion:^(BOOL finished) {
                        
                        
                    }];
                }
            }else if(lastdirection==2){
                //向左滑
                if (viewleft.frame.origin.x>(0-ScreenSize.width/4)) {
                    
                    //切换到第一个
                    [UIView animateWithDuration:0.2 animations:^{
                        viewleft.frame = CGRectMake(0, viewleft.frame.origin.y, viewleft.frame.size.width, viewleft.frame.size.height);
                        viewright.frame = CGRectMake(ScreenSize.width, viewright.frame.origin.y, viewright.frame.size.width, viewright.frame.size.height);
                    } completion:^(BOOL finished) {
                        
                        
                    }];
                    
                }else{
                    //切换到第二个
                    [UIView animateWithDuration:0.2 animations:^{
                        viewleft.frame = CGRectMake(0-ScreenSize.width, viewleft.frame.origin.y, viewleft.frame.size.width, viewleft.frame.size.height);
                        viewright.frame = CGRectMake(0, viewright.frame.origin.y, viewright.frame.size.width, viewright.frame.size.height);
                    } completion:^(BOOL finished) {
                        
                        
                    }];
                }
            }
            
        }
    }
    
}

-(void)initWithViewModel{
    
    self.viewmodel = [[BillViewModel alloc] init];
    [self.viewmodel setFilter:0 min:@"" max:@"" cids:nil outlet:NO private:NO];
    
}

/**
 封装加载数据得方法
 */
- (void)loadData{
    [[AlertController sharedInstance] showMessage:@"获取账单中"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [self.viewmodel loadBill:choosedateview.currentDate];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [lefttableview setsourceCount:self.viewmodel.leftsource.count];
            [righttableview setsourceCount:self.viewmodel.rightsource.count];
            
            [lefttableview reloadData];
            [righttableview reloadData];
            
            [totalmoney setText:self.viewmodel.currentType==0?[[self.viewmodel.totalExpend transferMoney] stringByReplacingOccurrencesOfString:@"-" withString:@""]:[self.viewmodel.totalIncome transferMoney]];
            [totalmoney setText:[NSString stringWithFormat:@"￥%@",totalmoney.text]];
            [detailmoney setText:[NSString stringWithFormat:@"收入：%@ ／ 支出：%@",[self.viewmodel.totalIncome transferMoney],[[self.viewmodel.totalExpend transferMoney] stringByReplacingOccurrencesOfString:@"-" withString:@""]]];
            
            
            [chartview setSelectedMonth:[choosedateview.currentDate month]];
            if (self.viewmodel.currentType==0) {
                [chartview setChartsource:self.viewmodel.yearForExpend];
            }else{
                [chartview setChartsource:self.viewmodel.yearForIncome];
            }
            
            [[AlertController sharedInstance] closeMessage];
        });
        
    });
}

-(void)loadAppearData{
    
    //界面赋值
    if ([[[Constants Instance].viewrefreshCache objectForKey:@"billpage"] isEqual:@YES]) {
        
        [self loadData];
        
        [[Constants Instance].viewrefreshCache setValue:@NO forKey:@"billpage"];
        
    }
    
}

#pragma mark---协议回调
-(void)FilterUIViewComfirm:(NSString *)min max:(NSString *)max categories:(NSArray<NSString *> *)categories isoutlet:(BOOL)isoutlet isprivate:(BOOL)isprivate{
    
    [self.viewmodel setFilter:segmentControl.selectedSegmentIndex min:min max:max cids:categories outlet:isoutlet private:isprivate];
    [[AlertController sharedInstance] showMessage:@"获取账单中"];
    
    [self loadData];
    
    [self hiddenAction:nil];
    
}

-(void)billtypeChanged:(UISegmentedControl *)segment{
    
    [self.viewmodel setCurrentType:segment.selectedSegmentIndex];
    
    [self loadData];
    
}

/**
 上月
 
 @param sender <#sender description#>
 @param date <#date description#>
 */
-(void)BillDateChoose:(id)sender prebuttonPressed:(NSDate *)date{
    
    [self.viewmodel setFilter:0 min:@"" max:@"" cids:nil outlet:NO private:NO];
    
    [self loadData];
}

/**
 下月
 
 @param sender <#sender description#>
 @param date <#date description#>
 */
-(void)BillDateChoose:(id)sender nextbuttonPressed:(NSDate *)date{
    
    [self.viewmodel setFilter:0 min:@"" max:@"" cids:nil outlet:NO private:NO];
    
    [self loadData];
}

@end
