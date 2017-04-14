//
//  CategoryChooseView.h
//  LightAccounting
//
//  Created by ddllzz on 17/3/29.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryViewCell.h"

@protocol CategoryChooseViewDelegate <NSObject>

-(void)categorychooseView:(UIImage *)chooseImage category:(NSString *)category;

@end

@interface CategoryChooseView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>{
    
    UIView *backgroundview;
    
    __weak UIImageView *imgView;
    
    UICollectionView *_collectionView;
    
    CategoryViewCell *chooseCell;
    
}

-(id)initwithTagView:(__weak UIImageView *)imgTap;

@property (nonatomic, weak) id <CategoryChooseViewDelegate> delegate;

@end
