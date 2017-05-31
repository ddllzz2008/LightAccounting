//
//  FamilyViewController.m
//  LightAccounting
//
//  Created by ddllzz on 2017/5/16.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "FamilyViewController.h"

@interface FamilyViewController ()

@end

@implementation FamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"家庭账本"];
    [self hiddenTabbar];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_edit"] style:UIBarButtonItemStyleDone target:self action:@selector(deleteAction:)];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    deleteMode = NO;
}

-(void)initControls{
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 20;
    //最小两行之间的间距
    layout.minimumLineSpacing = 15;
    
    collectionview=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionview.backgroundColor=[UIColor clearColor];
    collectionview.delegate=self;
    collectionview.dataSource=self;
    [collectionview registerClass:[CategoryViewCell class] forCellWithReuseIdentifier:@"CategoryViewCell"];
    
    [self.view addSubview:collectionview];
    
    __weak __typeof(self.view) weakSelf = self.view;
    [collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.top.equalTo(strongSelf).with.offset(20);
        make.left.equalTo(strongSelf).with.offset(20);
        make.bottom.equalTo(strongSelf).with.offset(-60);
        make.right.equalTo(strongSelf).with.offset(-20);
    }];
    
    RadarSearchButton *radarbutton = [[RadarSearchButton alloc] initWithFrame:CGRectMake(0, 0, 140, 100)];
    radarbutton.delegate=self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapNewFamily:)];
    [radarbutton addGestureRecognizer:tap];
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(holdSyncFamily:)];
    longpress.cancelsTouchesInView = NO;
    [radarbutton addGestureRecognizer:longpress];
    
    [self.view addSubview:radarbutton];
    [radarbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.size.mas_equalTo(CGSizeMake(140, 100));
        make.bottom.equalTo(strongSelf.mas_bottom);
        make.centerX.equalTo(strongSelf);
    }];
}

#pragma mark--uicollectionview视图
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"CategoryViewCell";
    CategoryViewCell *cell = (CategoryViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    [cell setAnchorImage:[UIImage imageNamed:@"icon_capture"]];
    [cell setLabelText:@"我的账本"];
    if (deleteMode) {
        cell.showDelete=YES;
    }else{
        cell.showDelete=NO;
    }
    return cell;
    
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 90);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark---交互事件
-(void)deleteAction:(id)sender{
    
    deleteMode = YES;
    
    [collectionview reloadData];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 40, 40);
    [right addTarget:self action:@selector(comfirmBackEvent) forControlEvents:UIControlEventTouchUpInside];
    [right setTitle:@"确定" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = rightBut;
    
}

-(void)comfirmBackEvent{
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_edit"] style:UIBarButtonItemStyleDone target:self action:@selector(deleteAction:)];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    deleteMode = NO;
    
    [collectionview reloadData];
    
}

-(void)tapNewFamily:(UITapGestureRecognizer *)sender{
    
    if (accountView==nil) {
        
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
        
        accountView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-40, 200)];
        accountView.layer.cornerRadius=5.0f;
        accountView.layer.masksToBounds=YES;
        accountView.backgroundColor = get_theme_color;
        [chooseWindow addSubview:accountView];
        
        __weak __typeof(self.view) weakSelf = chooseWindow;
        
        [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            make.left.equalTo(strongSelf).with.offset(20);
            make.right.equalTo(strongSelf.mas_right).with.offset(-20);
            make.top.equalTo(strongSelf).with.offset(80);
            make.height.equalTo(@200);
        }];
        
        __weak __typeof(self.view) weakaccountView = accountView;
        UIImageView *photoview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        photoview.image=[UIImage imageNamed:@"icon_capture"];
        UITapGestureRecognizer *choosephotoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePhoto:)];
        photoview.userInteractionEnabled = YES;
        [photoview addGestureRecognizer:choosephotoTap];
        [accountView addSubview:photoview];
        [photoview mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakaccountView) strongweakaccountView = weakaccountView;
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.top.equalTo(strongweakaccountView).with.offset(15);
            make.centerX.equalTo(strongweakaccountView);
        }];
        
        UITextField *photoName = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        photoName.backgroundColor=[UIColor whiteColor];
        photoName.placeholder=@"输入账本名称";
        photoName.textColor=UIColorFromRGB(0x888888);
        photoName.textAlignment=NSTextAlignmentCenter;
        [accountView addSubview:photoName];
        
        [photoName mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakaccountView) strongweakaccountView = weakaccountView;
            make.left.equalTo(strongweakaccountView).with.offset(20);
            make.right.equalTo(strongweakaccountView).with.offset(-20);
            make.height.equalTo(@40);
            make.top.equalTo(photoview.mas_bottom).with.offset(15);
        }];
        
        UIButton *photosave = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        [photosave setTitle:@"保存" forState:UIControlStateNormal];
        photosave.backgroundColor=UIColorFromRGB(0xcccccc);
        [accountView addSubview:photosave];
        
        [photosave mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakaccountView) strongweakaccountView = weakaccountView;
            make.left.equalTo(strongweakaccountView).with.offset(20);
            make.right.equalTo(strongweakaccountView).with.offset(-20);
            make.height.equalTo(@40);
            make.top.equalTo(photoName.mas_bottom).with.offset(15);
        }];
    }
    
}

-(void)hiddenAction:(UITapGestureRecognizer*)sender{
    if (accountView!=nil) {
        [accountView removeFromSuperview];
        accountView = nil;
    }
    
    if(chooseWindow!=nil){
        
        chooseWindow.hidden=YES;
        chooseWindow=nil;
    }
}


-(void)holdSyncFamily:(UILongPressGestureRecognizer *)sender{
    if (rader==nil) {
        rader = [[RadarUIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [rader setAlertMessage:@"正在查找附近设备"];
        [self.view addSubview:rader];
        
        __weak __typeof(self.view) weakSelf = self.view;
        [rader mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            make.left.equalTo(strongSelf);
            make.top.equalTo(strongSelf);
            make.bottom.equalTo(strongSelf.mas_bottom).with.offset(-100);
            make.width.equalTo(strongSelf);
        }];
    }
}


/**
 选择照片

 @param sender 手势对象
 */
-(void)choosePhoto:(UITapGestureRecognizer*)sender{
    
}

/**
 按钮弹起
 */
-(void)RadarSearchButtonTouchEnd{
    if (rader!=nil&&[rader superview]!=nil) {
        [rader removeFromSuperview];
        rader = nil;
    }
}

@end
