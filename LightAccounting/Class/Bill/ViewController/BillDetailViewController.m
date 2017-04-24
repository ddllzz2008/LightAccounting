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
}

-(void)initControls{
    BillDateChooseView *choosedateview = [[BillDateChooseView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 80)];
    [self.view addSubview:choosedateview];
    
    UILabel *totalmoney = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 20)];
    [totalmoney setTextColor:UIColorFromRGB(color_theme_green)];
    [totalmoney setTextAlignment:NSTextAlignmentCenter];
    [totalmoney setFont:fontsize_16];
    [totalmoney setText:@"收入：2万 ／ 支出：1,854.0"];
    [self.view addSubview:totalmoney];
    
    [totalmoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 25));
        make.top.equalTo(choosedateview.mas_bottom).with.offset(0);
    }];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-30, 40)];
    [tableview setBackgroundColor:[UIColor clearColor]];
    tableview.delegate=self;
    tableview.dataSource = self;
    tableview.layer.cornerRadius = 10;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.allowsSelection = NO;
    tableview.showsVerticalScrollIndicator = NO;
    [tableview registerClass:[BillDetailTableCell class] forCellReuseIdentifier:@"billdetailtablecell"];
    [self.view addSubview:tableview];
    
    __weak __typeof(self) weakSelf = self;
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        //        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf.view).with.offset(15);
        make.width.mas_equalTo(ScreenSize.width - 30);
        make.centerX.equalTo(strongSelf.view);
        make.bottom.equalTo(strongSelf.view.mas_bottom).with.offset(-20);
        make.top.equalTo(totalmoney.mas_bottom).with.offset(10);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark---UITableView协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger secnumber = 0;
    switch (section) {
        case 0:
            secnumber = 2;
        break;
        case 1:
            secnumber = 3;
        break;
        case 2:
            secnumber = 2;
        break;
        case 3:
            secnumber = 1;
        break;
        default:
        break;
    }
    return secnumber;
}

// 设置cell
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString *idetifier = @"billdetailtablecell";
    BillDetailTableCell *cell = (BillDetailTableCell *)[tableView dequeueReusableCellWithIdentifier:idetifier forIndexPath:indexPath];
    if (cell) {
        [cell setTypeImage:[UIImage imageNamed:@"category_10"]];
        [cell setTypeName:@"晚餐"];
        [cell setTypeSection:@"收入"];
        [cell setDetailNumber:@"-38.0"];
    }
    return cell;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 40;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
