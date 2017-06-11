//
//  NewExpenditureViewController.m
//  LightAccounting
//
//  Created by ddllzz on 17/3/26.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "NewExpenditureViewController.h"

@interface NewExpenditureViewController ()

@property (nonatomic,readwrite) ExpendViewModel *viewmodel;

@end

@implementation NewExpenditureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"记账"];
    [self hiddenTabbar];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"item_ok"] style:UIBarButtonItemStyleDone target:self action:@selector(saveAccount:)];
    self.navigationItem.rightBarButtonItem = rightitem;
}

-(void)initControls{
    step1view = [[NewStep1View alloc] initWithTypeFrame:self.accountType frame:(CGRect)CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - StatusSize.height -self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height)];
    
    [self.view addSubview:step1view];
}

-(void)initWithViewModel{
    
    self.viewmodel = [[ExpendViewModel alloc] init];
    
    step1view.viewmodel = self.viewmodel;
    
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
-(void)saveAccount:(id)sender{
    
    if (self.accountType==0) {
        //收入
        NSString *result = [self.viewmodel checkIncomeData];
        if (result!=nil && ![CommonFunc isBlankString:result]) {
            [DLZAlertView showAlertMessage:self title:@"错误提示" content:result];
        }else{
            
        }
        
    }else{
        //支出
        NSString *result = [self.viewmodel checkIncomeData];
        if (result!=nil && ![CommonFunc isBlankString:result]) {
            [DLZAlertView showAlertMessage:self title:@"错误提示" content:result];
        }else{
            
        }
    }
    
}
@end
