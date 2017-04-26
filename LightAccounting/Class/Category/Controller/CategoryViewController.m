//
//  CategoryViewController.m
//  LightAccounting
//
//  Created by ddllzz on 17/3/8.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "CategoryViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

-(id)initWithType:(BOOL)ifincome{
    
    self = [super init];
    if (self) {
        ifIncome = ifincome;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=UIColorFromRGB(0xeeeeee);
    if (ifIncome) {
        [self.navigationItem setTitle:@"收入分类"];
    }else{
        [self.navigationItem setTitle:@"支出分类"];
    }
//    [self hiddenTabbar];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"item_ok"] style:UIBarButtonItemStyleDone target:self action:@selector(saveData:)];
    self.navigationItem.rightBarButtonItem = rightitem;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self initTextFieldArray:textfield,nil];
    
    [super viewWillAppear:animated];
}

-(void)initControls{
    
    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-30, 40)];
    [tableview setBackgroundColor:[UIColor whiteColor]];
    tableview.delegate=self;
    tableview.dataSource = self;
    tableview.layer.cornerRadius = 10;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.allowsSelection = YES;
    tableview.showsVerticalScrollIndicator = NO;
    [tableview registerClass:[CategoryTableCell class] forCellReuseIdentifier:@"CategoryTableCell"];
    [self.view addSubview:tableview];
    
    __weak __typeof(self.view) weakSelf = self.view;
    [tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf).with.offset(15);
        make.width.mas_equalTo(ScreenSize.width/2 - 20);
        make.top.equalTo(strongSelf.mas_top).with.offset(20);
        make.bottom.equalTo(strongSelf.mas_bottom).with.offset(-20);
    }];
    
    UILabel *categorytitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-30, 20)];
    [categorytitle setStyle:fontsize_14 color:UIColorFromRGB(0x333333)];
    categorytitle.textAlignment=NSTextAlignmentLeft;
    [categorytitle setText:@"分类名称"];
    [self.view addSubview:categorytitle];
    
    [categorytitle mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.top.equalTo(tableview);
        make.right.equalTo(strongSelf.mas_right).with.offset(-15);
        make.width.equalTo(tableview);
        make.height.equalTo(@20);
    }];
 
    textfield = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-30, 30)];
    [textfield setTextColor:UIColorFromRGB(0x333333)];
    textfield.textAlignment=NSTextAlignmentLeft;
    [textfield setFont:fontsize_16];
    [textfield setPlaceholder:@"请输入分类名称"];
    textfield.keyboardType=UIKeyboardTypeDecimalPad;
    textfield.returnKeyType=UIReturnKeyDone;
    [self.view addSubview:textfield];
    [textfield mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(categorytitle);
        make.top.equalTo(categorytitle.mas_bottom).with.offset(10);
        make.width.equalTo(categorytitle);
        make.height.equalTo(@30);
    }];
    
    UILabel *categoryicon = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-30, 20)];
    [categoryicon setStyle:fontsize_14 color:UIColorFromRGB(0x333333)];
    categoryicon.textAlignment=NSTextAlignmentLeft;
    [categoryicon setText:@"分类图标"];
    [self.view addSubview:categoryicon];
    
    [categoryicon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textfield.mas_bottom).with.offset(10);
        make.left.equalTo(textfield);
        make.width.equalTo(tableview);
        make.height.equalTo(@20);
    }];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 20;
    //最小两行之间的间距
    layout.minimumLineSpacing = 15;
    
    UICollectionView *_collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor=[UIColor clearColor];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    [_collectionView registerClass:[CategoryViewCell class] forCellWithReuseIdentifier:@"CategoryViewCell"];
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(categoryicon);
        make.top.equalTo(categoryicon.mas_bottom).with.offset(10);
        make.bottom.equalTo(tableview);
        make.width.equalTo(tableview);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark---UITableView协议
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    footview.backgroundColor = [UIColor whiteColor];
    
    __weak __typeof(footview) weakself = footview;
    
    UIImageView *imagetype = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    [imagetype setImage:[UIImage imageNamed:@"category_add"]];
    [footview addSubview:imagetype];
    
    [imagetype mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(footview) strongself = weakself;
        make.left.equalTo(strongself.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        make.centerY.equalTo(strongself);
    }];
    
    UILabel *typenameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    typenameLabel.textAlignment=NSTextAlignmentLeft;
    [typenameLabel setStyle:fontsize_16 color:UIColorFromRGB(0xbbbbbb)];
    [typenameLabel setText:@"添加"];
    [footview addSubview:typenameLabel];
    
    [typenameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakself) strongself = weakself;
        make.left.equalTo(imagetype.mas_right).with.offset(10);
        make.right.equalTo(strongself.mas_right).with.offset(-10);
        make.centerY.equalTo(imagetype);
        make.height.mas_equalTo(@30);
    }];
    
    return footview;
}

// 设置cell
- (UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    static NSString *idetifier = @"CategoryTableCell";
    CategoryTableCell *cell = (CategoryTableCell *)[tableView dequeueReusableCellWithIdentifier:idetifier forIndexPath:indexPath];
    if (cell) {
        [cell setTypeImage:[UIImage imageNamed:@"category_10"]];
        [cell setTypeName:@"晚餐"];
    }
    return cell;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark--uicollectionview视图
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 13;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"CategoryViewCell";
    CategoryViewCell *cell = (CategoryViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
        //最后一项为添加
    [cell setAnchorImage:[UIImage imageNamed:[NSString stringWithFormat:@"category_%ld",indexPath.item + 1]]];
    
    UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
    UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, cell.bounds.size.height-4, cell.bounds.size.width, 4)];
    bottomview.backgroundColor = UIColorFromRGB(color_theme_green);
    [selectedBGView addSubview:bottomview];
    selectedBGView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = selectedBGView;
    
    return cell;
    
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(35, 50);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryViewCell *cell = (CategoryViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell) {
        
        
    }
}

#pragma mark---保存数据
-(void)saveData:(id)sender{
//    UINavigationBar *navBar = [UINavigationBar appearance];
    self.navigationController.navigationBar.barTintColor = [UIColor redColor];
//    [navBar setTranslucent:NO];
    
    for (UITabBarItem *item in self.tabBarController.tabBar.items) {
            [item setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0x333333),NSFontAttributeName:fontsize_14} forState:UIControlStateNormal];
            [item setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor],NSFontAttributeName:fontsize_13} forState:UIControlStateSelected];
    }
    
    [self.tabBarController.tabBar setTintColor:UIColorFromRGB(0xff0000)];
    
//    [[UITabBar appearance]setTintColor:[UIColor redColor]];
    
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColorFromRGB(0x333333),NSFontAttributeName:fontsize_14} forState:UIControlStateNormal];
//    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor redColor],NSFontAttributeName:fontsize_13} forState:UIControlStateSelected];
    
}

@end
