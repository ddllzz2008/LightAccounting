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
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"item_ok"] style:UIBarButtonItemStyleDone target:self action:@selector(saveData:)];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    currentColor = [[StoreUserDefault instance] getDataWithString:appcache_themecolor]==nil?UIColorFromRGB(0xA6D157):[UIColor colorWithHexString:[[StoreUserDefault instance] getDataWithString:appcache_themecolor]];
}

-(void)initControls{
    
    HRColorPickerView *colorPickerView = [[HRColorPickerView alloc] initWithFrame:CGRectMake(10, 10, ScreenSize.width-20, ScreenSize.height - StatusSize.height -self.navigationController.navigationBar.frame.size.height-20)];
    colorPickerView.color = get_theme_color;
    [colorPickerView addTarget:self
                        action:@selector(colorChanged:)
              forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:colorPickerView];
    
//    __weak __typeof(self.view) weakself = self.view;
//    [colorPickerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        __strong __typeof(weakself) strongself = weakself;
//        make.width.equalTo(strongself).with.offset(40);
//        make.height.equalTo(strongself).with.offset(40);
//        make.left.equalTo(strongself.mas_left).with.offset(10);
//        make.top.equalTo(strongself).with.offset(10);
//    }];
}

-(void)colorChanged:(HRColorPickerView *)picker{
    
    DDLogDebug(@"当前颜色:%@",picker.color);
    
    self.navigationController.navigationBar.barTintColor = picker.color;
    //    [navBar setTranslucent:NO];
    
    for (UITabBarItem *item in self.tabBarController.tabBar.items) {
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0x333333),NSFontAttributeName:fontsize_14} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName : picker.color,NSFontAttributeName:fontsize_13} forState:UIControlStateSelected];
    }
    
    [self.tabBarController.tabBar setTintColor:picker.color];
    
    currentColor = picker.color;
    
    ifcolorChanged = YES;

}

-(void)saveData:(id)sender{
    
    NSString *savecolorString = [UIColor hexFromUIColor:currentColor];
    
    [[StoreUserDefault instance] setData:appcache_themecolor data:savecolorString];
    
    DDLogDebug(@"save color is %@",savecolorString);
    
    [[AlertController sharedInstance] showMessageAutoClose:@"保存成功"];
    
    ifcolorChanged = NO;
    
    for (UINavigationController *navcontroller in self.tabBarController.viewControllers) {
        navcontroller.navigationBar.barTintColor=currentColor;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(BOOL)navigationShouldPopOnBackButton{
    
    if (ifcolorChanged) {
        [DLZAlertView showAlertMessage:self title:@"提示" content:@"改变的主题颜色还未保存，是否继续退出" leftButton:@"取消" leftaction:^(id sender) {
            
            [(DLZAlertView*)sender close];
        } rightButton:@"退出" rightaction:^(id sender) {
            
            UIColor *savecolor = get_theme_color;
            
            self.navigationController.navigationBar.barTintColor = savecolor;
            //    [navBar setTranslucent:NO];
            
            for (UITabBarItem *item in self.tabBarController.tabBar.items) {
                [item setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0x333333),NSFontAttributeName:fontsize_14} forState:UIControlStateNormal];
                [item setTitleTextAttributes:@{NSForegroundColorAttributeName : savecolor,NSFontAttributeName:fontsize_13} forState:UIControlStateSelected];
            }
            
            [self.tabBarController.tabBar setTintColor:savecolor];
            
            [(DLZAlertView*)sender close];
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
