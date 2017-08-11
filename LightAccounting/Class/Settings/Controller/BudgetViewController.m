//
//  BudgetViewController.m
//  LightAccounting
//
//  Created by ddllzz on 2017/4/25.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BudgetViewController.h"

@interface BudgetViewController ()

@end

@implementation BudgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"预算管理"];
    [self hiddenTabbar];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveData:)];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    self.viewcontrollerKeyboardDelegate = self;
}

-(void)initControls{
    
    choosedateview = [[BillDateChooseView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 50)];
    choosedateview.delegate=self;
    choosedateview.currentDate = [NSDate dateWithZone];
    choosedateview.mode = BillDateChooseModeYear;
    [self.view addSubview:choosedateview];
    
    tableview = [[TouchTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-30, 40)];
    [tableview setBackgroundColor:[UIColor clearColor]];
    tableview.delegate=self;
    tableview.dataSource = self;
    tableview.touchDelegate = self;
    tableview.layer.cornerRadius = 10;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.allowsSelection = NO;
    tableview.showsVerticalScrollIndicator = NO;
    [tableview registerClass:[BudgetTableViewCell class] forCellReuseIdentifier:@"budgettableviewcell"];
    [self.view addSubview:tableview];
    
    __weak __typeof(self.view) weakSelf = self.view;
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf).with.offset(15);
        make.width.mas_equalTo(ScreenSize.width - 30);
        make.centerX.equalTo(strongSelf);
        make.bottom.equalTo(strongSelf.mas_bottom).with.offset(-20);
        make.top.equalTo(choosedateview.mas_bottom).with.offset(15);
    }];
    
//    UIButton *resetBilldate = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 40)];
//    [resetBilldate setTitle:@"更改账单日" forState:UIControlStateNormal];
//    [resetBilldate setBackgroundColor:get_theme_color];
//    [resetBilldate addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:resetBilldate];
//    
//    [resetBilldate mas_makeConstraints:^(MASConstraintMaker *make) {
//        __strong __typeof(weakSelf) strongSelf = weakSelf;
//        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 40));
//        make.left.equalTo(strongSelf);
//        make.bottom.equalTo(strongSelf);
//    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewmodel.budgetArray.count;
}

// 设置cell
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString *idetifier = @"budgettableviewcell";
    BudgetTableViewCell *cell = (BudgetTableViewCell *)[tableView dequeueReusableCellWithIdentifier:idetifier forIndexPath:indexPath];
    if (cell) {
        BusBudgetModel *model = [self.viewmodel.budgetArray objectAtIndex:indexPath.item];
        if (model!=nil) {
            cell.inputmoney.tag = indexPath.item;
            [cell.inputmoney setText:[NSString stringWithFormat:@"%.1f",model.BVALUE]];
            [cell.inputmoney addTarget:self action:@selector(budgetValueChanged:) forControlEvents:UIControlEventEditingChanged];
            [cell setTitle:model.BMONTH];
            [cell setActualValue:model.ACTUALVALUE];
            [cell setBudgetValue:model.LEFTVALUE];
            NSNumber *colorvalue = [colorDictionary objectForKey:model.BMONTH];
            [cell setHeaderColor:UIColorFromRGB([colorvalue longValue])];
            //加入键盘自动管理
            [self addTextFieldResponser:cell.inputmoney];
        }
    }
    return cell;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 120;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesEnded:touches withEvent:event];
}

#pragma mark---键盘事件
-(void)viewcontrollerKeyboardChanged:(CGRect)rect ifshow:(BOOL)ifshow{
    if (ifshow) {
        tableview.frame = CGRectMake(tableview.frame.origin.x, tableview.frame.origin.y - rect.size.height, tableview.frame.size.width, tableview.frame.size.height);
    }else{
        tableview.frame = CGRectMake(tableview.frame.origin.x, tableview.frame.origin.y + rect.size.height, tableview.frame.size.width, tableview.frame.size.height);
    }
}

#pragma mark---更改账单日
-(void)resetAction:(id)sender{
    if (accountView==nil) {
        
        chooseWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [chooseWindow setBackgroundColor:[UIColor clearColor]];
        chooseWindow.alpha=1.0f;
        chooseWindow.windowLevel = UIWindowLevelAlert;
        chooseWindow.hidden=NO;
        
        rootview = [[UIView alloc] initWithFrame:chooseWindow.frame];
        rootview.backgroundColor=[UIColor grayColor];
        rootview.alpha=0.4f;
        UITapGestureRecognizer *hiddenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenAction:)];
        [rootview addGestureRecognizer:hiddenTap];
        //        [chooseWindow addSubview:rootview];
        [chooseWindow addSubview:rootview];
        
        accountView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-40, 200)];
        accountView.layer.cornerRadius=5.0f;
        accountView.layer.masksToBounds=YES;
        accountView.backgroundColor = get_theme_color;
        //        [chooseWindow addSubview:accountView];
        [chooseWindow addSubview:accountView];
        
        __weak __typeof(chooseWindow) weakSelf = chooseWindow;
        
        [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            make.left.equalTo(strongSelf).with.offset(20);
            make.right.equalTo(strongSelf.mas_right).with.offset(-20);
            make.top.equalTo(strongSelf).with.offset(80);
            make.height.equalTo(@200);
        }];
        
        __weak __typeof(accountView) weakaccountView = accountView;
        
        UILabel *messagetitlte = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        [messagetitlte setStyle:fontsize_13 color:UIColorFromRGB(0xffffff)];
        messagetitlte.textAlignment=NSTextAlignmentCenter;
        messagetitlte.numberOfLines=0;
        messagetitlte.lineBreakMode=NSLineBreakByWordWrapping;
        [messagetitlte setText:@"账单日为每月账单按照上月的账单日至本月的账单日统计,设置范围为1-31"];
        [accountView addSubview:messagetitlte];
        
        [messagetitlte mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakaccountView) strongweakaccountView = weakaccountView;
            make.left.equalTo(strongweakaccountView).with.offset(20);
            make.right.equalTo(strongweakaccountView.mas_right).with.offset(-20);
            make.top.equalTo(strongweakaccountView).with.offset(15);
            make.height.equalTo(@40);
        }];
        
        
        UITextField *photoName = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        photoName.backgroundColor=[UIColor whiteColor];
        photoName.placeholder=@"输入账单日（默认为每月第一天）";
        photoName.textColor=UIColorFromRGB(0x888888);
        photoName.textAlignment=NSTextAlignmentCenter;
        photoName.keyboardType=UIKeyboardTypeNumberPad;
        [photoName setText:self.viewmodel.billDate];
        [accountView addSubview:photoName];
        
        [photoName addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        
        [photoName mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakaccountView) strongweakaccountView = weakaccountView;
            make.left.equalTo(strongweakaccountView).with.offset(20);
            make.right.equalTo(strongweakaccountView).with.offset(-20);
            make.height.equalTo(@40);
            make.top.equalTo(messagetitlte.mas_bottom).with.offset(15);
        }];
        
        UIButton *photosave = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        [photosave setTitle:@"保存" forState:UIControlStateNormal];
        [photosave addTarget:self action:@selector(saveBillDate:) forControlEvents:UIControlEventTouchUpInside];
        photosave.backgroundColor=UIColorFromRGB(0xcccccc);
        [accountView addSubview:photosave];
        
        [photosave mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakaccountView) strongweakaccountView = weakaccountView;
            make.left.equalTo(strongweakaccountView).with.offset(20);
            make.right.equalTo(strongweakaccountView).with.offset(-20);
            make.height.equalTo(@40);
            make.top.equalTo(photoName.mas_bottom).with.offset(15);
        }];
    }
}

-(void)hiddenAction:(UITapGestureRecognizer*)sender{
    if (accountView!=nil) {
        [accountView removeFromSuperview];
        accountView = nil;
    }
    
    if(chooseWindow!=nil){
        
        chooseWindow.hidden=YES;
        chooseWindow=nil;
    }
}

#pragma mark---viewmodel操作
-(void)initWithViewModel{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"configinfo" ofType:@"plist"];
    NSMutableDictionary *configInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    colorDictionary = [configInfo objectForKey:@"MonthColor"];
    
    self.viewmodel = [[BudgetViewModel alloc] init];
    self.viewmodel.currentYear = [[NSDate dateWithZone] formatWithCode:@"yyyy"];
    
    [[AlertController sharedInstance] showMessage:@"加载中"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.viewmodel getBudgetsByYear];
        [tableview reloadData];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[AlertController sharedInstance] closeMessage];
        });
    });
}

#pragma mark---日期选择变更

/**
 上月

 @param sender <#sender description#>
 @param date <#date description#>
 */
-(void)BillDateChoose:(id)sender prebuttonPressed:(NSDate *)date{
    self.viewmodel.currentYear = [date formatWithCode:@"yyyy"];
        [[AlertController sharedInstance] showMessage:@"加载中"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self.viewmodel getBudgetsByYear];
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableview reloadData];
                [[AlertController sharedInstance] closeMessage];
            });
        });
}

/**
 下月

 @param sender <#sender description#>
 @param date <#date description#>
 */
-(void)BillDateChoose:(id)sender nextbuttonPressed:(NSDate *)date{
    self.viewmodel.currentYear = [date formatWithCode:@"yyyy"];
    [[AlertController sharedInstance] showMessage:@"加载中"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.viewmodel getBudgetsByYear];
        dispatch_async(dispatch_get_main_queue(), ^{
            [tableview reloadData];
            [[AlertController sharedInstance] closeMessage];
        });
    });
}

-(void)textFieldChanged:(UITextField *)sender{
    self.viewmodel.billDate = sender.text;
}

/**
 预算变更

 @param textfield <#textfield description#>
 */
-(void)budgetValueChanged:(UITextField *)textfield{
    
    if (textfield!=nil) {
        BusBudgetModel *model = [self.viewmodel.budgetArray objectAtIndex:textfield.tag];
        model.BVALUEString = textfield.text;
    }
    
}

#pragma mari---数据操作

/**
 保存账单日

 @param button <#button description#>
 */
-(void)saveBillDate:(UIButton*)button{
    
    [[AlertController sharedInstance] showMessage:@"保存中"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *result = [self.viewmodel setBillDate];
        if ([result isEqualToString:@""]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AlertController sharedInstance] closeMessage];
                [[Constants Instance].viewrefreshCache setValue:@YES forKey:@"mainpage"];
                [[Constants Instance].viewrefreshCache setValue:@YES forKey:@"billpage"];
                [[AlertController sharedInstance] showMessageAutoClose:@"保存成功"];
                [self hiddenAction:nil];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AlertController sharedInstance] closeMessage];
                [[AlertController sharedInstance] showMessageAutoClose:result];
            });
        }
        
    });
    
}

/**
 保存预算

 @param sender <#sender description#>
 */
-(void)saveData:(id)sender{
    
    [[AlertController sharedInstance] showMessage:@"保存中"];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *result = [self.viewmodel setBudgetsByYear];
        if ([result isEqualToString:@""]) {
            [self.viewmodel getBudgetsByYear];
            dispatch_async(dispatch_get_main_queue(), ^{
                [tableview reloadData];
                [[AlertController sharedInstance] closeMessage];
                [[Constants Instance].viewrefreshCache setValue:@YES forKey:@"mainpage"];
                [[AlertController sharedInstance] showMessageAutoClose:@"保存成功"];
            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AlertController sharedInstance] closeMessage];
                [[AlertController sharedInstance] showMessageAutoClose:result];
            });
        }
        
    });
    
}
@end
