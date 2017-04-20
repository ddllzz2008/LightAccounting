//
//  BillDetailTableCell.h
//  LightAccounting
//
//  Created by ddllzz on 2017/4/19.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Style.h"

@interface BillDetailTableCell : UITableViewCell{
    
    UIImageView *imagetype;
    
    UILabel *typenameLabel;
    
    UILabel *typesectionLabel;
    
    UILabel *detailnumberLabel;
    
}

@property (nonatomic,strong,readwrite) UIImage *typeImage;
    
@property (nonatomic,strong,readwrite) NSString *typeName;
    
@property (nonatomic,strong,readwrite) NSString *typeSection;
    
@property (nonatomic,strong,readwrite) NSString *detailNumber;

@end
