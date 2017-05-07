//
//  PlanViewController.m
//  LightAccounting
//
//  Created by ddllzz on 2017/4/28.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "PlanViewController.h"

@interface PlanViewController ()

@end

@implementation PlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"计划任务"];
    [self hiddenTabbar];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_add"] style:UIBarButtonItemStyleDone target:self action:@selector(addNotification:)];
    self.navigationItem.rightBarButtonItem = rightitem;
}

-(void)initControls{
    
    planview = [[PlanView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height -self.navigationController.navigationBar.frame.size.height)];
    [self.view addSubview:planview];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [planview setCurrentDate:[NSDate dateWithZone]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark---事件
-(void)addNotification:(id)sender{
    
    NewPlanViewController *newplanController = [[NewPlanViewController alloc] init];
    [self.navigationController pushViewController:newplanController animated:YES];
    
}

@end
