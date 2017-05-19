//
//  CategoryViewCell.h
//  LightAccounting
//
//  Created by ddllzz on 17/4/5.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLZAlertView.h"
#import "UIView+ExtMethod.h"

@interface CategoryViewCell : UICollectionViewCell{
    
    UIImageView *deleteview;
    
    UIImageView *imageview;
    
    UILabel *title;
}

@property (nonatomic,strong) UIImage *anchorImage;

@property (nonatomic,strong) NSString *labelText;

@property (nonatomic,assign) BOOL showDelete;

-(void)setLabelColor:(UIColor *)color;

@end
