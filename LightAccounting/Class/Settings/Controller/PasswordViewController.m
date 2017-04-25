//
//  PasswordViewController.m
//  LightAccounting
//
//  Created by ddllzz on 17/4/19.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "PasswordViewController.h"

@interface PasswordViewController ()

@end

@implementation PasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"手势密码"];
    [self hiddenTabbar];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"item_ok"] style:UIBarButtonItemStyleDone target:self action:@selector(saveData:)];
    self.navigationItem.rightBarButtonItem = rightitem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabbar];
}

-(void)initControls{
    
    TapPassView *tappassview = [[TapPassView alloc] initWithFrame:CGRectMake(20, 0, ScreenSize.width-40, ScreenSize.height-self.navigationController.navigationBar.frame.size.height)];
    [self.view addSubview:tappassview];
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
