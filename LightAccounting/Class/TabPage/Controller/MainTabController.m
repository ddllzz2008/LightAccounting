//
//  MainTabController.m
//  DLZProject
//
//  Created by ddllzz on 16/12/1.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "MainTabController.h"
#import "MainPageViewController.h"

@implementation MainTabController

-(id)init{
    if(self==[super init]){
        
        //     改变标题字体颜色和大小
//        [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:12.0f], NSForegroundColorAttributeName : [UIColor redColor]} forState:UIControlStateNormal];
//        [[UITabBarItem appearance] setTitleTextAttributes:@{ NSForegroundColorAttributeName:[UIColor greenColor]} forState:UIControlStateSelected];
        
        //设置tabbar的背景图片
        UITabBar *tabBar = self.tabBar;
        [tabBar setTintColor:[UIColor colorWithRed:166.0/255.0 green:209.0/255.0 blue:87.0/255.0 alpha:1.0]];
//        tabBar.selectedImageTintColor = [UIColor clearColor];
        
        self.viewControllers = [NSArray arrayWithObjects:[self addViewController:@"支出" image:[UIImage imageNamed:@"tabbaritem1"] viewcontroller:[[MainPageViewController alloc] init]],
                                [self addViewController:@"分析" image:[UIImage imageNamed:@"tabbaritem2"] viewcontroller:[[MainPageViewController alloc] init]],
                                [self addViewController:@"" image:nil viewcontroller:[[ExpendVoiceViewController alloc] init]],
                                [self addViewController:@"账单" image:[UIImage imageNamed:@"tabbaritem3"] viewcontroller:[[BillViewController alloc] init]],
                                [self addViewController:@"设置" image:[UIImage imageNamed:@"tabbaritem4"] viewcontroller:[[MyZoneViewController alloc] init]],
                                nil];
        
    }
    return self;
}


/**
 增加基于NavigationController的TabBarItem项

 @param title tabbaritem标题
 @param image 图片资源
 @param viewcontroller UINavigationController的根试图
 @return 返回UINavigationController
 */
-(UINavigationController*)addViewController:(NSString*)title image:(UIImage*)image viewcontroller:(UIViewController*)viewcontroller{
    viewcontroller.tabBarItem = [[UITabBarItem alloc] initWithTitle:title image:image tag:0];
    viewcontroller.title=title;
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:viewcontroller];
//    [nav.navigationItem setTitle:navtitle];
    return nav;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.barTintColor = UIColorFromRGB(color_theme_green);
    [navBar setTranslucent:NO];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0x333333),NSFontAttributeName:fontsize_14} forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(color_theme_green),NSFontAttributeName:fontsize_13} forState:UIControlStateSelected];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 38, 38)];
    button.center = CGPointMake(ScreenSize.width/2, 22);
    [button setBackgroundImage:[UIImage imageNamed:@"icon_new"] forState:UIControlStateNormal];
    [self.tabBar addSubview:button];
}

//-(void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    
//    [self addObserver:self forKeyPath:@"selectedIndex" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
//    
//    UITabBarController *tabBarController = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
//    
//    [tabBarController setDelegate:self];
//}
//
//-(void)viewWillDisappear:(BOOL)animated{
//    
//    [self removeObserver:self forKeyPath:@"selectedIndex"];
//    
//    [super viewWillDisappear:animated];
//}

#pragma mark---monitor selected changed
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    if ([keyPath isEqualToString:@"selectedIndex"]) {
//        int _new = [[change objectForKey:@"new"] intValue];
//        switch (_new) {
//            case 0:
//            case 1:
//            case 3:
//            case 4:
//            [self.tabBar setHidden:NO];
//            self.tabBar.bounds = CGRectMake(0, 0, ScreenSize.width, 49);
//            break;
//            case 2:
//            [self.tabBar setHidden:YES];
//            self.tabBar.bounds = CGRectMake(0, 0, ScreenSize.width, 0);
//            break;
//        }
//    }
//}

//-(void)tabBar:(UITabBar*)atabBar didSelectItem:(UITabBarItem*)item
//{
//    if (item.title==nil) {
//        CATransition* animation = [CATransition animation];
//        [animation setDuration:0.4f];
//        [animation setType:kCATransitionMoveIn];
//        [animation setSubtype:kCATransitionFromTop];
//        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
//        [[self.view layer]addAnimation:animation forKey:@"switchView"];
//    }
//}

@end
