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
    [self.navigationItem setTitle:@"家庭成员"];
    [self hiddenTabbar];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
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
        make.bottom.equalTo(strongSelf).with.offset(-20);
        make.right.equalTo(strongSelf).with.offset(-20);
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
    [cell setLabelText:@"我"];
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

@end
