//
//  BillDetailViewController.m
//  LightAccounting
//
//  Created by ddllzz on 2017/4/19.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BillDetailViewController.h"

@interface BillDetailViewController ()

@end

@implementation BillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"账单明细"];
    [self hiddenTabbar];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_filter"] style:UIBarButtonItemStyleDone target:self action:@selector(navigateDetail)];
    self.navigationItem.rightBarButtonItem = rightitem;
    self.navigationItem.rightBarButtonItem.tintColor = UIColorFromRGB(0xffffff);
}

#pragma mark---属性赋值

-(void)initControls{
    choosedateview = [[BillDateChooseView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 60)];
    choosedateview.delegate=self;
    choosedateview.mode=BillDateChooseModeYearMonth;
    choosedateview.currentDate = _currentDate;
    [self.view addSubview:choosedateview];
    
    /*--------------右边容器-------------------*/
    
    viewright = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height)];
    viewright.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:viewright];
    
    __weak typeof(self.view) weakSelf = self.view;
    
    [viewright mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.top.equalTo(choosedateview.mas_bottom).with.offset(5);
        make.left.equalTo(strongSelf);
        make.bottom.equalTo(strongSelf);
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
    return self.viewmodel.rightsource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.viewmodel.rightsource objectAtIndex:section] count];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
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

// 设置cell
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
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

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
        
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        BOOL hresult = NO;
        NSString *billid = @"";
        int billtype = 0;
        
        @try {
            
            NSMutableArray *array = [self.viewmodel.rightsource objectAtIndex:indexPath.section];
            
            BusExpenditure *model = [array objectAtIndex:indexPath.item];
            
            billid = model.CID;
            billtype = model.TYPE;
            
            if (array.count<=1) {
                [array removeObjectAtIndex:indexPath.item];
                [self.viewmodel.rightsource removeObjectAtIndex:indexPath.section];
            }else{
                [array removeObjectAtIndex:indexPath.item];
            }
            
            [tableView beginUpdates];
            
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:indexPath.section];
            
            if (array.count<=0) {
                [tableView deleteSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
                if (indexPath.section==0) {
                    @try {
                        [tableView reloadSections:[[NSIndexSet alloc] initWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
                    } @catch (NSException *exception) {
                        
                    } @finally {
                        
                    }
                    
                }
            }else{
                [tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
            }
            
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [tableView endUpdates];
            
            hresult = YES;
            
        } @catch (NSException *exception) {
            
            [[AlertController sharedInstance] showMessageAutoClose:@"操作异常"];
            
        } @finally {
            
            if (hresult) {
                
                [self.viewmodel runThreadAction:@"删除中" successtitle:@"删除成功" errortitle:@"删除失败" threadaction:^BOOL{
                    BOOL deleteresult = [self.viewmodel deleteBill:billid type:billtype];
                    return deleteresult;
                } mainuiaction:^(BOOL result) {
                    if (result) {
                        [[Constants Instance].viewrefreshCache setValue:@YES forKey:@"mainpage"];
                    }
                }];
                
                
                
                
            }
            
        }
        
    }
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 50;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 50;
}

#pragma mark---筛选
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
#pragma mark---数据加载
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
        
        [self.viewmodel loadDetailBill:choosedateview.currentDate];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [righttableview setsourceCount:self.viewmodel.rightsource.count];
            
            [righttableview reloadData];
            
            [detailmoney setText:[NSString stringWithFormat:@"收入：%@ ／ 支出：%@",[self.viewmodel.totalIncome transferMoney],[[self.viewmodel.totalExpend transferMoney] stringByReplacingOccurrencesOfString:@"-" withString:@""]]];

            [[AlertController sharedInstance] closeMessage];
        });
        
    });
}

-(void)loadAppearData{
    
    [self loadData];
    
}
#pragma mark---协议回调
-(void)FilterUIViewComfirm:(NSString *)min max:(NSString *)max categories:(NSArray<NSString *> *)categories isoutlet:(BOOL)isoutlet isprivate:(BOOL)isprivate{
    
    [self.viewmodel setFilter:0 min:min max:max cids:categories outlet:isoutlet private:isprivate];
    [[AlertController sharedInstance] showMessage:@"获取账单中"];
    
    [self loadData];
    
    [self hiddenAction:nil];
    
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
