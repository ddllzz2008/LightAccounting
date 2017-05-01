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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
