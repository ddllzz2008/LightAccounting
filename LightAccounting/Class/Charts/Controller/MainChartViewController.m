//
//  MainChartViewController.m
//  LightAccounting
//
//  Created by ddllzz on 2017/8/15.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "MainChartViewController.h"

@interface MainChartViewController ()

@end

@implementation MainChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"收支分析"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabbar];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

-(void)initControls{
    
    ChartsMainView *chartview = [[ChartsMainView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height -self.navigationController.navigationBar.frame.size.height)];
    
    [self.view addSubview:chartview];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
