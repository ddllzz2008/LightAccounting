//
//  CategoryTableCell.h
//  LightAccounting
//
//  Created by ddllzz on 2017/4/26.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Style.h"

@interface CategoryTableCell : UITableViewCell{
    
    UIImageView *imagetype;
    
    UILabel *typenameLabel;
    
}

@property (nonatomic,strong,readwrite) UIImage *typeImage;

@property (nonatomic,strong,readwrite) NSString *typeName;

@end
