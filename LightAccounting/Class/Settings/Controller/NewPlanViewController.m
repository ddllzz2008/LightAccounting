//
//  NewPlanViewController.m
//  LightAccounting
//
//  Created by ddllzz on 17/5/7.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "NewPlanViewController.h"

@interface NewPlanViewController ()

@end

@implementation NewPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"自动记账"];
    [self hiddenTabbar];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"item_ok"] style:UIBarButtonItemStyleDone target:self action:@selector(saveData:)];
    self.navigationItem.rightBarButtonItem = rightitem;
}

-(void)initControls{
    step1view = [[NewPlanView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - StatusSize.height -self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height)];
    [self.view addSubview:step1view];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self initTextFieldArray:step1view.inputmoney,step1view.labelremark,nil];
    
    [super viewWillAppear:animated];
    
    [step1view setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark--操作
-(void)saveData:(id)sender{
    
}
@end
