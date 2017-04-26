//
//  ThemeViewController.m
//  LightAccounting
//
//  Created by ddllzz on 2017/4/26.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "ThemeViewController.h"

@interface ThemeViewController ()

@end

@implementation ThemeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"主题颜色"];
    [self hiddenTabbar];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

-(void)initControls{
    
//    HRColorPickerView *colorPickerView = [[HRColorPickerView alloc] init];
//    colorPickerView.color = self.color;
//    [colorPickerView addTarget:self
//                        action:@selector(action:)
//              forControlEvents:UIControlEventValueChanged];
//    [self.view addSubview:colorPickerView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
