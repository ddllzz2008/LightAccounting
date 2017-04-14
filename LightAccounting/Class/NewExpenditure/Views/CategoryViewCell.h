//
//  CategoryViewCell.h
//  LightAccounting
//
//  Created by ddllzz on 17/4/5.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewCell : UICollectionViewCell{
    
    UIImageView *imageview;
    
    UILabel *title;
}

@property (nonatomic,strong) UIImage *anchorImage;

@property (nonatomic,strong) NSString *labelText;

-(void)setLabelColor:(UIColor *)color;

@end
