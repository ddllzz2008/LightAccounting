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
}

-(void)initControls{
    
    BillDateChooseView *choosedateview = [[BillDateChooseView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 80)];
    [self.view addSubview:choosedateview];
    
    NSArray *segmentedArray = [[NSArray alloc]initWithObjects:@"支出",@"收入",nil];
    UISegmentedControl *segmentControl = [[UISegmentedControl alloc] initWithItems:segmentedArray];
    segmentControl.frame = CGRectMake(0, 0, ScreenSize.width/2, 30);
    segmentControl.segmentedControlStyle=UISegmentedControlStylePlain;
    segmentControl.selectedSegmentIndex=0;
    [segmentControl setTintColor:UIColorFromRGB(color_theme_green)];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:fontsize_14,UITextAttributeFont ,nil];
    [segmentControl setTitleTextAttributes:dic forState:UIControlStateNormal];
    [self.view addSubview:segmentControl];
    
    @weakify(self);
    
    [segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width/2, 30));
        make.centerX.equalTo(self.view);
        make.top.equalTo(choosedateview.mas_bottom).with.offset(5);
    }];
    
    UILabel *totalmoney = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 20)];
    [totalmoney setTextColor:UIColorFromRGB(color_theme_green)];
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
        @strongify(self);
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width-30, 150));
        make.left.equalTo(self.view.mas_left).with.offset(15);
        make.top.equalTo(totalmoney.mas_bottom).with.offset(5);
    }];
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-30, 40)];
    [tableview setBackgroundColor:UIColorFromRGB(color_theme_green)];
    tableview.delegate=self;
    [self.view addSubview:tableview];
    
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self);
        make.left.equalTo(self.view).with.offset(15);
        make.width.mas_equalTo(ScreenSize.width - 30);
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(10);
        make.top.equalTo(chartview.mas_bottom).with.offset(10);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
