//
//  BudgetViewController.m
//  LightAccounting
//
//  Created by ddllzz on 2017/4/25.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BudgetViewController.h"

@interface BudgetViewController ()

@end

@implementation BudgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"预算管理"];
    [self hiddenTabbar];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"item_ok"] style:UIBarButtonItemStyleDone target:self action:@selector(saveData:)];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    self.viewcontrollerKeyboardDelegate = self;
}

-(void)initControls{
    
    tableview = [[TouchTableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-30, 40)];
    [tableview setBackgroundColor:[UIColor clearColor]];
    tableview.delegate=self;
    tableview.dataSource = self;
    tableview.touchDelegate = self;
    tableview.layer.cornerRadius = 10;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.allowsSelection = NO;
    tableview.showsVerticalScrollIndicator = NO;
    [tableview registerClass:[BudgetTableViewCell class] forCellReuseIdentifier:@"budgettableviewcell"];
    [self.view addSubview:tableview];
    
    __weak __typeof(self) weakSelf = self;
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf.view).with.offset(15);
        make.width.mas_equalTo(ScreenSize.width - 30);
        make.centerX.equalTo(strongSelf.view);
        make.bottom.equalTo(strongSelf.view.mas_bottom).with.offset(-20);
        make.top.equalTo(strongSelf.view.mas_top).with.offset(15);
    }];
    
}

-(void)initWithViewModel{
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"configinfo" ofType:@"plist"];
    NSMutableDictionary *configInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    colorDictionary = [configInfo objectForKey:@"MonthColor"];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 12;
}

// 设置cell
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString *idetifier = @"budgettableviewcell";
    BudgetTableViewCell *cell = (BudgetTableViewCell *)[tableView dequeueReusableCellWithIdentifier:idetifier forIndexPath:indexPath];
    if (cell) {
        [cell setTitle:[NSString stringWithFormat:@"%d月",indexPath.item+1]];
        [cell setActualValue:90.0f];
        [cell setBudgetValue:100.0f];
        NSNumber *colorvalue = [colorDictionary objectForKey:[NSString stringWithFormat:@"%d",indexPath.item+1]];
        [cell setHeaderColor:UIColorFromRGB([colorvalue longValue])];
        //加入键盘自动管理
        [self addTextFieldResponser:cell.inputmoney];
    }
    return cell;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 120;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tableView:(UITableView *)tableView touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesEnded:touches withEvent:event];
}

#pragma mark---键盘事件
-(void)viewcontrollerKeyboardChanged:(CGRect)rect ifshow:(BOOL)ifshow{
    if (ifshow) {
        tableview.frame = CGRectMake(tableview.frame.origin.x, tableview.frame.origin.y - rect.size.height, tableview.frame.size.width, tableview.frame.size.height);
    }else{
        tableview.frame = CGRectMake(tableview.frame.origin.x, tableview.frame.origin.y + rect.size.height, tableview.frame.size.width, tableview.frame.size.height);
    }
}

@end
