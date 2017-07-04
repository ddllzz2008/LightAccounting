//
//  FilterUIView.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/29.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Style.h"
#import "NSString+ExtMethod.h"
#import "CategoryViewCell.h"
#import "CategoryModel.h"
#import "SSCheckBoxView.h"

@protocol FilterUIViewDelegate <NSObject>

@optional
-(void)FilterUIViewComfirm:(NSString *)min max:(NSString *)max categories:(NSArray<NSString *> *)categories isoutlet:(BOOL)isoutlet isprivate:(BOOL)isprivate;

@end

@interface FilterUIView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>{
    
    UICollectionView *_collectionView;
    
    SSCheckBoxView *cboutlet;
    
    SSCheckBoxView *cbprivate;
    
    NSMutableArray<NSString *> *categoryArray;
    
}

@property (nonatomic,strong) NSArray *categorySource;

@property (nonatomic,strong) UITextField *minfield;

@property (nonatomic,strong) UITextField *maxfield;

@property (nonatomic,weak) id<FilterUIViewDelegate> delegate;

-(void)setCategories:(NSArray *)array;

-(void)setMinValue:(NSString *)minvalue;

-(void)setMaxValue:(NSString *)maxvalue;

-(void)setOutlet:(BOOL)isoutlet;

-(void)setPrivate:(BOOL)isprivate;

@end
