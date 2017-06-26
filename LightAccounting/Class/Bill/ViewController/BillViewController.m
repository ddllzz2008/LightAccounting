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
    UIBarButtonItem *lefttitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_chart"] style:UIBarButtonItemStyleDone target:self action:@selector(navigateDetail)];
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_filter"] style:UIBarButtonItemStyleDone target:self action:@selector(navigateDetail)];
    self.navigationItem.leftBarButtonItem = lefttitem;
    self.navigationItem.rightBarButtonItem = rightitem;
    self.navigationItem.leftBarButtonItem.tintColor = UIColorFromRGB(0xffffff);
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
    [tableview setBackgroundColor:themecolor];
}

-(void)initControls{
    
    choosedateview = [[BillDateChooseView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 80)];
    [self.view addSubview:choosedateview];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"支出",@"收入",nil];
    segmentControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    segmentControl.frame = CGRectMake(0, 0, ScreenSize.width/2, 30);
    segmentControl.segmentedControlStyle=UISegmentedControlStylePlain;
    segmentControl.selectedSegmentIndex=0;
    [segmentControl setTintColor:get_theme_color];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:fontsize_14,UITextAttributeFont ,nil];
    [segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    [self.view addSubview:segmentControl];
    
    __weak typeof(self) weakSelf = self;
    
    [segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width/2, 30));
        make.centerX.equalTo(strongSelf.view);
        make.top.equalTo(choosedateview.mas_bottom).with.offset(5);
    }];
    
    totalmoney = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 20)];
    [totalmoney setTextColor:get_theme_color];
    [totalmoney setTextAlignment:NSTextAlignmentCenter];
    [totalmoney setFont:fontsize_26];
    [totalmoney setText:@"1,5000.0"];
    [self.view addSubview:totalmoney];
    
    [totalmoney mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 20));
        make.top.equalTo(segmentControl.mas_bottom).with.offset(20);
    }];
    
    BillChartView *chartview = [[BillChartView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 150)];
    [self.view addSubview:chartview];
    
    [chartview mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width-30, 150));
        make.left.equalTo(strongSelf.view.mas_left).with.offset(15);
        make.top.equalTo(totalmoney.mas_bottom).with.offset(5);
    }];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-30, 40)];
    [tableview setBackgroundColor:get_theme_color];
    tableview.delegate=self;
    tableview.dataSource = self;
    tableview.layer.cornerRadius = 10;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.allowsSelection = NO;
    tableview.showsVerticalScrollIndicator = NO;
    [tableview registerClass:[BillTableCell class] forCellReuseIdentifier:@"billtablecell"];
    [self.view addSubview:tableview];
    
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf.view).with.offset(15);
        make.width.mas_equalTo(ScreenSize.width - 30);
        make.centerX.equalTo(strongSelf.view);
        make.bottom.equalTo(strongSelf.view.mas_bottom).with.offset(-60);
        make.top.equalTo(chartview.mas_bottom).with.offset(10);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 8;
}

// 设置cell
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString *idetifier = @"billtablecell";
    BillTableCell *cell = (BillTableCell *)[tableView dequeueReusableCellWithIdentifier:idetifier forIndexPath:indexPath];
    if (cell) {
        [cell setTypeName:@"运动"];
        [cell setSpendMoney:100.0f];
        [cell setSpendPercent:0.83f];
    }
    return cell;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 50;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark---跳转事件
-(void)navigateDetail{
    [self.navigationController pushViewController:[[BillDetailViewController alloc] init] animated:YES];
}

@end
