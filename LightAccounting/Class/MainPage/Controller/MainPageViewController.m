//
//  MainPageViewController.m
//  LightAccounting
//
//  Created by ddllzz on 17/3/19.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "MainPageViewController.h"

@interface MainPageViewController (){
    
    MainPageView *mainview;
    
}

@property (nonatomic,readwrite) MainPageViewModel *viewmodel;

@end

@implementation MainPageViewController

extern NSDictionary *viewrefreshCache;

- (void)viewDidLoad {
    
    self.viewmodel = [[MainPageViewModel alloc] init];
    
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"消费记录"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];
    [self showTabbar];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [mainview refreshTheme];
}

-(void)initViewStyle{
    
    
}

-(void)initContraints{
    [mainview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(self.view.mas_top);
        make.width.mas_equalTo(ScreenSize.width);
        make.height.mas_equalTo(ScreenSize.height - StatusSize.height -self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height);
    }];
}

-(void)initControls{
    mainview = [[MainPageView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height - StatusSize.height -self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height)];
    [self.view addSubview:mainview];
    
    [mainview startlayout];
}

-(void)initWithViewModel{
//    @weakify(self);
    __weak typeof(self) weakSelf = self;
    mainview.updatePhotoBlock=^(NSString *eid,NSString *photopath){
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.viewmodel updateExpendPhoto:eid photo:photopath];
    };
    mainview.addnewAccount=^(){
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        NewExpenditureViewController *newexpendController = [[NewExpenditureViewController alloc] init];
        [strongSelf.navigationController pushViewController:newexpendController animated:YES];
    };
}

-(void)loadAppearData{
    
    //界面赋值
    if ([[[Constants Instance].viewrefreshCache objectForKey:@"mainpage"] isEqual:@YES]) {
        NSDate *today = [NSDate dateWithZone];
        long day = [today getDateFormatter:@"dd"];
        int billday = [self.viewmodel getBillDay];
        long startyear = [today getDateFormatter:@"yyyy"];
        long endyear = startyear;
        long startmonth = [today getDateFormatter:@"MM"];
        long endmonth = startmonth;
        if (day>=billday) {
            if (startmonth==12) {
                endyear = startyear+1;
                startmonth = 12;
                endmonth = 1;
            }else{
                endmonth = startmonth+1;
            }
        }else{
            if(startmonth==1){
                startyear = startyear-1;
                startmonth = 12;
                endmonth = 1;
            }else{
                startmonth = startmonth - 1;
            }
        }
        
        NSString *startday = [NSString stringWithFormat:@"%ld-%ld-%d 00:00:00",startyear,startmonth,billday];
        NSString *endday = [NSString stringWithFormat:@"%ld-%ld-%d 00:00:00",endyear,endmonth,billday];
        
        [self.viewmodel initFilters:[startday convertDateFromString:@"yyyy-MM-dd HH:mm:ss"] end:[endday convertDateFromString:@"yyyy-MM-dd HH:mm:ss"] categoryid:nil packageid:nil minexpend:nil maxexpend:nil];
        NSArray *source = [self.viewmodel loadData];
        
        CGFloat totalexpend = [[source valueForKeyPath:@"@sum.groupExpend"] floatValue];
        
        [mainview setCurrentExpend:totalexpend];
        
        [mainview setSource:source];
        [mainview loadData];
        
        CGFloat totalbudget = [self.viewmodel getCurrentBudget];
        [mainview setCurrentBudget:totalbudget];
        
        [[Constants Instance].viewrefreshCache setValue:@NO forKey:@"mainpage"];
        
    }
    
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

@end
