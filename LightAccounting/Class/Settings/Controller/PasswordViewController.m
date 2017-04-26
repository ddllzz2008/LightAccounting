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
    [self.navigationItem setTitle:@"设置手势密码"];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
//    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"item_ok"] style:UIBarButtonItemStyleDone target:self action:@selector(saveData:)];
//    self.navigationItem.rightBarButtonItem = rightitem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self hiddenTabbar];
}

-(void)initControls{
    
    UILabel *setlabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 40)];
    [setlabel setStyle:fontsize_14 color:UIColorFromRGB(0x333333)];
    setlabel.textAlignment=NSTextAlignmentLeft;
    [setlabel setText:@"是否开启手势密码"];
    [self.view addSubview:setlabel];
    
    __weak __typeof(self) weakSelf = self;
    [setlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf.view).with.offset(12);
        make.top.equalTo(strongSelf.view).with.offset(12);
        make.width.equalTo(strongSelf.view).with.offset(24);
        make.height.equalTo(@40);
    }];
//
    UISwitch *sw = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    sw.on=NO;
    sw.onTintColor = UIColorFromRGB(color_theme_green);
    [sw addTarget:self action:@selector(passwordStatusChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:sw];
    
    [sw mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.right.equalTo(strongSelf.view.mas_right).with.offset(-12);
        make.centerY.equalTo(setlabel);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    UIView *borderview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 1)];
    borderview.backgroundColor=UIColorFromRGB(0xcccccc);
    [self.view addSubview:borderview];
    [borderview mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.top.equalTo(setlabel.mas_bottom).with.offset(10);
        make.left.equalTo(strongSelf.view);
        make.width.equalTo(strongSelf.view);
        make.height.equalTo(@1);
    }];
    
    alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 15)];
    [alertLabel setStyle:fontsize_14 color:UIColorFromRGB(0xcccccc)];
    alertLabel.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:alertLabel];
    [alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 15));
        make.top.equalTo(borderview.mas_bottom).with.offset(12);
    }];
    
    tappassview = [[TapPassView alloc] initWithFrame:CGRectMake(20, 0, ScreenSize.width-40, ScreenSize.height-self.navigationController.navigationBar.frame.size.height)];
    tappassview.hidden=YES;
    tappassview.delegate=self;
    [self.view addSubview:tappassview];
    
    [tappassview mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.top.equalTo(alertLabel.mas_bottom).with.offset(20);
        make.left.equalTo(strongSelf.view).with.offset(0);
        make.width.equalTo(strongSelf.view);
        make.bottom.equalTo(strongSelf.view);
    }];
    
    UIButton *resetPassword = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 40)];
    [resetPassword setTitle:@"更改密码" forState:UIControlStateNormal];
    [resetPassword setBackgroundColor:UIColorFromRGB(color_theme_green)];
    [resetPassword addTarget:self action:@selector(resetAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:resetPassword];
    
    [resetPassword mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 40));
        make.left.equalTo(strongSelf.view);
        make.bottom.equalTo(strongSelf.view);
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

-(void)passwordStatusChanged:(UISwitch *)sender{
    if (sender.on) {
        tappassview.hidden=NO;
        tappassview.userInteractionEnabled=YES;
        [alertLabel setText:@"请输入手势密码"];
    }else{
        tappassview.hidden=YES;
        tappassview.userInteractionEnabled=NO;
        [alertLabel setText:@""];
    }
}

-(void)resetAction:(UIButton*)sender{
    [alertLabel setText:@"请输入原始密码"];
    ifresetPassword = YES;
    tappassview.userInteractionEnabled=YES;
}

#pragma mark---procotol
-(void)tappassviewdidfinished:(NSString *)resultstring{
    
    DDLogDebug(@"输入密码：%@",resultstring);
    
    if (ifresetPassword) {
        //更改密码,判断输入密码是否与原始密码一致
        [tappassview showError];
        
        firstPassword = @"";
        secondPassword =@"";
        
    }else{
        if (firstPassword==nil || [firstPassword isBlankString]) {
            firstPassword = resultstring;
            [alertLabel setText:@"请再次输入密码"];
        }else{
            secondPassword = resultstring;
            
            if (![firstPassword isEqualToString:secondPassword]) {
                [alertLabel setText:@"两次输入的密码不一致"];
            }else{
                [alertLabel setText:@"密码修改成功"];
            }
            
            tappassview.userInteractionEnabled=NO;
            ifresetPassword = NO;
            firstPassword = @"";
            secondPassword =@"";
        }
    }
}

@end
