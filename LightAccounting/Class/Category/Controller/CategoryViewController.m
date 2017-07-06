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
    
//    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"item_ok"] style:UIBarButtonItemStyleDone target:self action:@selector(saveData:)];
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(saveData:)];
    self.navigationItem.rightBarButtonItem = rightitem;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self initTextFieldArray:textfield,nil];
    
    [super viewWillAppear:animated];
    
    [self hiddenTabbar];
    
    [self addObserve];
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self removeObserve];
}

-(void)initControls{
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-30, 40)];
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
    [textfield setTextColor:get_theme_color];
    textfield.textAlignment=NSTextAlignmentLeft;
    [textfield setFont:fontsize_16];
    [textfield setPlaceholder:@"请输入分类名称"];
    textfield.keyboardType=UIKeyboardTypeDefault;
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
    
    deletebutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 35)];
    [deletebutton setTitle:@"删除" forState:UIControlStateNormal];
    [deletebutton setBackgroundColor:get_theme_color];
    [deletebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [deletebutton addTarget:self action:@selector(deleteCategory:) forControlEvents:UIControlEventTouchUpInside];
    deletebutton.hidden=YES;
    [self.view addSubview:deletebutton];
    
    [deletebutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@0);
        make.width.equalTo(tableview);
        make.left.equalTo(categoryicon);
        make.bottom.equalTo(tableview.mas_bottom).with.offset(10);
    }];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 20;
    //最小两行之间的间距
    layout.minimumLineSpacing = 15;
    
    _collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor=[UIColor clearColor];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.showsVerticalScrollIndicator = NO;
    [_collectionView registerClass:[CategoryViewCell class] forCellWithReuseIdentifier:@"CategoryViewCell"];
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(categoryicon);
        make.top.equalTo(categoryicon.mas_bottom).with.offset(10);
        make.bottom.equalTo(deletebutton.mas_top).with.offset(-10);
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
    return categoryarray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 40)];
    footview.backgroundColor = [UIColor whiteColor];
    
    footview.userInteractionEnabled = YES;
    UITapGestureRecognizer *foottap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addnewCategory:)];
    [footview addGestureRecognizer:foottap];
    
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
        CategoryModel *model  = [categoryarray objectAtIndex:indexPath.item];
        [cell setTypeImage:[UIImage imageNamed:[NSString stringWithFormat:@"category_%@",model.CCOLOR]]];
        [cell setTypeName:model.CNAME];
    }
    return cell;
}

- (CGFloat)tableView:(nonnull UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CategoryModel *model = [categoryarray objectAtIndex:indexPath.item];
    if (model!=nil) {
        self.viewmodel.model = model;
        textfield.text = model.CNAME;
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[model.CCOLOR intValue]-1 inSection:0];
        [_collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];//设置默认选中的行
        
        deletebutton.hidden=NO;
        [deletebutton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(@35);
            make.bottom.equalTo(tableview.mas_bottom).with.offset(0);
        }];
        
    }
}

#pragma mark--uicollectionview视图
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 32;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"CategoryViewCell";
    CategoryViewCell *cell = (CategoryViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
        //最后一项为添加
    [cell setAnchorImage:[UIImage imageNamed:[NSString stringWithFormat:@"category_%ld",indexPath.item + 1]]];
    
    UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
    UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, cell.bounds.size.height-4, cell.bounds.size.width, 4)];
    bottomview.backgroundColor = get_theme_color;
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
        self.viewmodel.model.CCOLOR = [NSString stringWithFormat:@"%ld",indexPath.item+1];
    }
}

/**
 添加新分类
 */
-(void)addnewCategory:(UITapGestureRecognizer *)sender{
    CategoryModel *model = [[CategoryModel alloc] init];
    if (ifIncome) {
        model.CREATETIME = [[NSDate dateWithZone] formatWithCode:@"yyyy-MM-dd HH:mm:ss"];
        model.CTYPE = 1;
    }else{
        //支出
        model.CREATETIME = [[NSDate dateWithZone] formatWithCode:@"yyyy-MM-dd HH:mm:ss"];
        model.CTYPE = 0;
    }
    self.viewmodel.model = model;
    
    textfield.text = @"";
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [_collectionView selectItemAtIndexPath:indexPath animated:YES scrollPosition:UICollectionViewScrollPositionNone];//设置默认选中的行
    
    deletebutton.hidden=YES;
    [deletebutton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@0);
        make.bottom.equalTo(tableview.mas_bottom).with.offset(10);
    }];
}

- (void)deleteCategory:(UIButton *)sender{
    
    [self.viewmodel runThreadAction:@"正在删除" successtitle:@"删除成功" errortitle:@"删除失败" threadaction:^BOOL{
        BOOL hresult = [self.viewmodel deleteCategory];
        return hresult;
    } mainuiaction:^(BOOL result) {
        if (result) {
            [self addnewCategory:nil];
            [tableview reloadData];
        }
    }];
    
}

#pragma mark---viewmodel操作
-(void)initWithViewModel{
    
    self.viewmodel = [[CategoryViewModel alloc] init];
    CategoryModel *model = [[CategoryModel alloc] init];
    if (ifIncome) {
        model.CREATETIME = [[NSDate dateWithZone] formatWithCode:@"yyyy-MM-dd HH:mm:ss"];
        model.CTYPE = 1;
        categoryarray = [self.viewmodel getIncomeCategory];
    }else{
        //支出
        model.CREATETIME = [[NSDate dateWithZone] formatWithCode:@"yyyy-MM-dd HH:mm:ss"];
        model.CTYPE = 0;
        categoryarray = [self.viewmodel getExpendCategory];
    }
    
    self.viewmodel.model = model;
    
}

#pragma mark---属性监视

/**
 添加属性监视
 */
-(void)addObserve{
    //添加属性监视KVO
    [textfield addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

/**
 移除属性监视
 */
-(void)removeObserve{
    [textfield removeTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

-(void)textFieldChanged:(UITextField *)sender{
    self.viewmodel.model.CNAME=sender.text;
}

#pragma mark---保存数据
-(void)saveData:(id)sender{
    //收入
    NSString *result = [self.viewmodel checkCategory];
    if (result!=nil && ![CommonFunc isBlankString:result]) {
        [DLZAlertView showAlertMessage:self title:@"错误提示" content:result];
    }else{
        [[AlertController sharedInstance] showMessage:@"保存中"];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (self.viewmodel.model.CID==nil||[self.viewmodel.model.CID isEqualToString:@""]) {
                CategoryModel *newmodel = [self.viewmodel addCategory];
                if (newmodel!=nil) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [[AlertController sharedInstance] closeMessage];
                        [[AlertController sharedInstance] showMessageAutoClose:@"保存成功"];
                        [categoryarray addObject:newmodel];
                        [tableview reloadData];
                        self.viewmodel.model = newmodel;
                        
                        deletebutton.hidden=NO;
                        [deletebutton mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.height.mas_equalTo(@35);
                            make.bottom.equalTo(tableview.mas_bottom).with.offset(0);
                        }];
                        
                    });
                }else{
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [[AlertController sharedInstance] closeMessage];
                        [[AlertController sharedInstance] showMessageAutoClose:@"保存失败"];
                    });
                }
            }else{
                BOOL hresult = [self.viewmodel updateCategory];
                if (hresult) {
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [[AlertController sharedInstance] closeMessage];
                        [[AlertController sharedInstance] showMessageAutoClose:@"保存成功"];
                        [tableview reloadData];
                        
                        deletebutton.hidden=NO;
                        [deletebutton mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.height.mas_equalTo(@35);
                            make.bottom.equalTo(tableview.mas_bottom).with.offset(0);
                        }];
                        
                    });
                }else{
                    dispatch_sync(dispatch_get_main_queue(), ^{
                        [[AlertController sharedInstance] closeMessage];
                        [[AlertController sharedInstance] showMessageAutoClose:@"保存失败"];
                    });
                }
            }
            
        });
    }
}

@end
