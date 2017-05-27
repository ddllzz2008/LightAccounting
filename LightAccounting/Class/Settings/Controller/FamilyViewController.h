//
//  FamilyViewController.h
//  LightAccounting
//
//  Created by ddllzz on 2017/5/16.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewController.h"
#import "CategoryViewCell.h"
#import "RadarUIView.h"
#import "RadarSearchButton.h"

@interface FamilyViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource,RadarSearchButtonDelegate>{
    
    UICollectionView *collectionview;
    
    //业务变量
    BOOL deleteMode;
    //雷达效果图
    RadarUIView *rader;
    
    //添加账本视图
    UIView *accountView;
    
}

@end
