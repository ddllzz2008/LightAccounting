//
//  PlanViewController.m
//  LightAccounting
//
//  Created by ddllzz on 2017/4/28.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "PlanViewController.h"

@interface PlanViewController ()

@end

@implementation PlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"计划任务"];
    [self hiddenTabbar];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_add"] style:UIBarButtonItemStyleDone target:self action:@selector(addNotification:)];
    self.navigationItem.rightBarButtonItem = rightitem;
}

-(void)initControls{
    
    planview = [[PlanView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height -self.navigationController.navigationBar.frame.size.height)];
    [self.view addSubview:planview];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-30, 40)];
    [tableview setBackgroundColor:[UIColor clearColor]];
    tableview.delegate=self;
    tableview.dataSource = self;
    tableview.layer.cornerRadius = 10;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.allowsSelection = NO;
    tableview.showsVerticalScrollIndicator = NO;
    [tableview registerClass:[PlanTableViewCell class] forCellReuseIdentifier:@"PlanTableViewCell"];
    [self.view addSubview:tableview];
    
    __weak __typeof(self) weakSelf = self;
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf.view).with.offset(15);
        make.width.mas_equalTo(ScreenSize.width - 30);
        make.centerX.equalTo(strongSelf.view);
        make.bottom.equalTo(strongSelf.view.mas_bottom).with.offset(-20);
        make.top.equalTo(planview.mas_bottom).with.offset(5);
    }];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [planview setCurrentDate:[NSDate dateWithZone]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark---table事件
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}

// 设置cell
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString *idetifier = @"PlanTableViewCell";
    PlanTableViewCell *cell = (PlanTableViewCell *)[tableView dequeueReusableCellWithIdentifier:idetifier forIndexPath:indexPath];
    if (cell) {
        
        [cell setIfAlert:NO];
        [cell setCategoryImage:[UIImage imageNamed:@"category_5"]];
        [cell setCategoryTtile:@"生活"];
        [cell setAccountString:@"150.0"];
        [cell setRemarkString:@"沃尔玛购物"];
        [cell setHeaderColor:get_theme_color];
    }
    return cell;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 120;
}

//-(void)tableView:(UITableView *)tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self touchesEnded:touches withEvent:event];
//}

#pragma mark---事件
-(void)addNotification:(id)sender{
    
    NewPlanViewController *newplanController = [[NewPlanViewController alloc] init];
    [self.navigationController pushViewController:newplanController animated:YES];
    
}

@end
