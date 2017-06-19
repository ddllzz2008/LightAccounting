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

extern NSDictionary *viewrefreshCache;

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
    step1view = [[NewStep1View alloc] initWithTypeFrame:self.accountType id:@"" frame:(CGRect)CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - StatusSize.height -self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height)];
    
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
    
    [step1view addObserve];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [step1view removeObserve];
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
            [[AlertController sharedInstance] showMessage:@"记账中"];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                BOOL hresult = [self.viewmodel saveIncome];
                if (hresult) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [[AlertController sharedInstance] closeMessage];
                        [[AlertController sharedInstance] showMessageAutoClose:@"记账成功"];
                        [[Constants Instance].viewrefreshCache setValue:@YES forKey:@"mainpage"];
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }else{
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [[AlertController sharedInstance] closeMessage];
                        [[AlertController sharedInstance] showMessageAutoClose:@"保存失败"];
                    });
                }
                
            });
        }
        
    }else{
        //支出
        NSString *result = [self.viewmodel checkIncomeData];
        if (result!=nil && ![CommonFunc isBlankString:result]) {
            [DLZAlertView showAlertMessage:self title:@"错误提示" content:result];
        }else{
            [[AlertController sharedInstance] showMessage:@"记账中"];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                BOOL hresult = [self.viewmodel saveExpend];
                if (hresult) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [[AlertController sharedInstance] closeMessage];
                        [[AlertController sharedInstance] showMessageAutoClose:@"记账成功"];
                        [[Constants Instance].viewrefreshCache setValue:@YES forKey:@"mainpage"];
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                }else{
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [[AlertController sharedInstance] closeMessage];
                        [[AlertController sharedInstance] showMessageAutoClose:@"保存失败"];
                    });
                }
            });
        }
    }
    
}
@end
