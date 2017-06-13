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
    
    [voiceview setNeedsDisplay];
    
    chooseview.source = [self.viewmodel getFamilyAccounts];
    chooseview.selectedValue = [self.viewmodel getDefaultFamily];
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
    voiceview.addnewAccount=^(int type){
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        NewExpenditureViewController *newexpendController = [[NewExpenditureViewController alloc] init];
        newexpendController.accountType = type;
        [strongSelf.navigationController pushViewController:newexpendController animated:YES];
    };
    
    chooseview = [[AccountChooseView alloc] initWithFrame:CGRectMake(0, 0, 100, 70)];
    chooseview.oriFrame = CGRectMake(0, 0, 100, 70);
    chooseview.backgroundColor = [UIColor clearColor];
    chooseview.textColor=get_theme_color;
    chooseview.delegate=self;
    chooseview.containerColor = UIColorFromRGB(0xffffff);
    chooseview.userInteractionEnabled=YES;
    
    [self.view addSubview:chooseview];
    
    [chooseview mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.centerX.equalTo(strongSelf.view);
        make.top.equalTo(strongSelf.view).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(100, 70));
    }];;
}

-(void)initWithViewModel{
    self.viewmodel = [[ExpendVoiceViewModel alloc] init];
    voiceview.viewmodel = self.viewmodel;
}

-(void)AccountChooseView:(id)sender didSelectedChanged:(FamilyPerson *)person{
    
    [self.viewmodel setDefaultFamily:person.fid];
    
}
@end
