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
    
    planview = [[PlanView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 280)];
    planview.layer.masksToBounds=YES;
    [self.view addSubview:planview];
    
    __weak __typeof(self.view) weakSelf = self.view;
//    [planview mas_makeConstraints:^(MASConstraintMaker *make) {
//       __strong __typeof(weakSelf) strongSelf = weakSelf;
//        make.top.equalTo(strongSelf);
//        make.width.equalTo(strongSelf);
//        make.left.equalTo(strongSelf);
//        make.height.equalTo(@280);
//    }];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-30, 40)];
    [tableview setBackgroundColor:[UIColor clearColor]];
    tableview.delegate=self;
    tableview.dataSource = self;
    tableview.layer.cornerRadius = 10;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.allowsSelection = NO;
    tableview.bounces = NO;
    tableview.showsVerticalScrollIndicator = NO;
    [tableview registerClass:[PlanTableViewCell class] forCellReuseIdentifier:@"PlanTableViewCell"];
    [self.view addSubview:tableview];
    
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf.mas_left).with.offset(15);
        make.top.equalTo(strongSelf.mas_top).with.offset(290);
        make.bottom.equalTo(strongSelf.mas_bottom).with.offset(-10);
        make.right.equalTo(strongSelf.mas_right).with.offset(-15);
    }];
    
    __weak __typeof(tableview) weaktableview =  tableview;
    planview.layoutchanged = ^(int rowheight) {
        
        __strong __typeof(weaktableview) strongtableview = weaktableview;
        
        [strongtableview mas_updateConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            make.top.equalTo(strongSelf).with.offset(rowheight+10);
        }];
    };
    
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
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *idetifier = @"PlanTableViewCell";
    PlanTableViewCell *cell = (PlanTableViewCell *)[tableView dequeueReusableCellWithIdentifier:idetifier forIndexPath:indexPath];
    if (cell) {
        
        [cell setIfAlert:YES];
        [cell setCategoryImage:[UIImage imageNamed:@"category_5"]];
        [cell setCategoryTtile:@"生活"];
        [cell setAccountString:@"150.0"];
        [cell setRemarkString:@"沃尔玛购物"];
        [cell setHeaderColor:get_theme_color];
    }
    return cell;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 100;
}

//-(void)tableView:(UITableView *)tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    [self touchesEnded:touches withEvent:event];
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat y = scrollView.contentOffset.y;
    if (y<=0) {
        lasty = 0;
        if (planview.bounds.size.height!=planviewHeight) {
            [planview showDate];
            [tableview mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view).with.offset(planview.initHeight+10);
            }];
        }
    }else{
        if (lasty - y > 60) {
            if (planview.bounds.size.height!=planviewHeight) {
                //向下滚动超过10，显示planview
                [planview showDate];
                [tableview mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.equalTo(self.view).with.offset(planview.initHeight+10);
                }];
                lasty = y;
            }
        }else if(lasty - y < -10){
            //向上滚动超过10，隐藏planview
                [planview hiddenDate];
            [tableview mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view).with.offset(70);
            }];
                lasty = y;
        }
    }
    
}

#pragma mark---事件
-(void)addNotification:(id)sender{
    
    NewPlanViewController *newplanController = [[NewPlanViewController alloc] init];
    [self.navigationController pushViewController:newplanController animated:YES];
    
}

@end
