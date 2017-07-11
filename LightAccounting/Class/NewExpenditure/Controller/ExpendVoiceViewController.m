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
    
    [self addObserve];
    
    [super viewWillAppear: animated];
    [self showTabbar];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [voiceview setNeedsDisplay];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self removeObserve];
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
    
//    chooseview = [[AccountChooseView alloc] initWithFrame:CGRectMake(0, 0, 100, 70)];
//    chooseview.oriFrame = CGRectMake(0, 0, 100, 70);
//    chooseview.backgroundColor = [UIColor clearColor];
//    chooseview.textColor=get_theme_color;
//    chooseview.delegate=self;
//    chooseview.containerColor = UIColorFromRGB(0xffffff);
//    chooseview.userInteractionEnabled=YES;
//    
//    [self.view addSubview:chooseview];
//    
//    [chooseview mas_makeConstraints:^(MASConstraintMaker *make) {
//        __strong __typeof(weakSelf) strongSelf = weakSelf;
//        make.centerX.equalTo(strongSelf.view);
//        make.top.equalTo(strongSelf.view).with.offset(-20);
//        make.size.mas_equalTo(CGSizeMake(100, 70));
//    }];;
}

-(void)loadAppearData{
    
    //界面赋值
    if ([[[Constants Instance].viewrefreshCache objectForKey:@"newexpend"] isEqual:@YES]) {
        
        [self.viewmodel loadCategory];
        
        [[Constants Instance].viewrefreshCache setValue:@NO forKey:@"newexpend"];
        
    }
    
}

-(void)initWithViewModel{
    self.viewmodel = [[ExpendVoiceViewModel alloc] init];
    voiceview.viewmodel = self.viewmodel;
}

#pragma mark---属性监视

/**
 添加属性监视
 */
-(void)addObserve{
    //添加属性监视KVO
    [voiceview addNotification];
}

/**
 移除属性监视
 */
-(void)removeObserve{
    [voiceview removeNotification];
}
@end
