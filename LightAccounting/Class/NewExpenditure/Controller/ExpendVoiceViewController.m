//
//  ExpendVoiceViewController.m
//  LightAccounting
//
//  Created by ddllzz on 17/3/8.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "ExpendVoiceViewController.h"

@interface ExpendVoiceViewController (){
    
    ExpendVoiceView *voiceview;
    
}

@end

@implementation ExpendVoiceViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"记账"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self showTabbar];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

-(void)initViewStyle{
    
    
}

-(void)initContraints{
    
}

-(void)initControls{

    voiceview = [[ExpendVoiceView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - StatusSize.height -self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height)];
    [self.view addSubview:voiceview];
    
//    @weakify(self);
    __weak typeof(self) weakSelf = self;
    voiceview.addnewAccount=^(){
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        NewExpenditureViewController *newexpendController = [[NewExpenditureViewController alloc] init];
        [strongSelf.navigationController pushViewController:newexpendController animated:YES];
    };
}

-(void)initWithViewModel{

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
