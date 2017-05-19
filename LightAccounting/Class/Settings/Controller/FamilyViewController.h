//
//  FamilyViewController.h
//  LightAccounting
//
//  Created by ddllzz on 2017/5/16.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewController.h"
#import "CategoryViewCell.h"

@interface FamilyViewController : BaseViewController<UICollectionViewDelegate,UICollectionViewDataSource>{
    
    UICollectionView *collectionview;
    
    //业务变量
    BOOL deleteMode;
    
}

@end
