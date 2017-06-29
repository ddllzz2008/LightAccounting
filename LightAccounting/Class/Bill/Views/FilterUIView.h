//
//  FilterUIView.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/29.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Style.h"
#import "CategoryViewCell.h"
#import "CategoryModel.h"

@interface FilterUIView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>{
    
    UICollectionView *_collectionView;
    
}

@property (nonatomic,strong) NSArray *categorySource;

@end
