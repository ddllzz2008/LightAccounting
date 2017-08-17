//
//  MainChartViewController.m
//  LightAccounting
//
//  Created by ddllzz on 2017/8/15.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "MainChartViewController.h"

@interface MainChartViewController ()

@end

@implementation MainChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"收支分析"];
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_filter"] style:UIBarButtonItemStyleDone target:self action:@selector(navigateDetail)];
    self.navigationItem.rightBarButtonItem = rightitem;
    self.navigationItem.rightBarButtonItem.tintColor = UIColorFromRGB(0xffffff);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabbar];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

-(void)initControls{
    
    chartview = [[ChartsMainView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height -self.navigationController.navigationBar.frame.size.height)];
    
    [self.view addSubview:chartview];
    
}

-(void)initWithViewModel{
    self.viewmodel = [[ChartViewModel alloc] init];
    [self.viewmodel setFilter:0 min:@"" max:@"" cids:nil outlet:NO private:NO];
}

#pragma mark---筛选
-(void)navigateDetail{
    chooseWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [chooseWindow setBackgroundColor:[UIColor clearColor]];
    chooseWindow.alpha=1.0f;
    chooseWindow.windowLevel = UIWindowLevelAlert;
    chooseWindow.hidden=NO;
    
    UIView *rootview = [[UIView alloc] initWithFrame:chooseWindow.frame];
    rootview.backgroundColor=[UIColor grayColor];
    rootview.alpha=0.4f;
    UITapGestureRecognizer *hiddenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenAction:)];
    [rootview addGestureRecognizer:hiddenTap];
    [chooseWindow addSubview:rootview];
    
    filterview = [[FilterUIView alloc] initWithFrame:CGRectMake(ScreenSize.width, 0, ScreenSize.width, ScreenSize.height)];
    filterview.delegate=self;
    filterview.categorySource = [self.viewmodel loadCategory];
    
    [filterview setMinValue:[self.viewmodel minvalue]];
    [filterview setMaxValue:[self.viewmodel maxvalue]];
    [filterview setCategories:[self.viewmodel categories]];
    [filterview setOutlet:[self.viewmodel isoutlet]];
    [filterview setPrivate:[self.viewmodel isprivate]];
    
    [chooseWindow addSubview:filterview];
    
    [self addTextFieldResponser:filterview.minfield];
    [self addTextFieldResponser:filterview.maxfield];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.2 animations:^{
            filterview.frame = CGRectMake(0, 0, ScreenSize.width, ScreenSize.height);
        }];
    });
    
}

/**
 隐藏筛选框

 @param sender 手势对象
 */
-(void)hiddenAction:(UITapGestureRecognizer*)sender{
    
    if ([self iskeyboardShow]) {
        [self hiddenKeyBoard];
    }else{
        if (filterview!=nil) {
            filterview.delegate=nil;
            [filterview removeFromSuperview];
            filterview = nil;
        }
        
        if(chooseWindow!=nil){
            
            chooseWindow.hidden=YES;
            chooseWindow=nil;
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
