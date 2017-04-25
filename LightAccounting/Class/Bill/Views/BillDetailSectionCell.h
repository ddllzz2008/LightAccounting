//
//  BillDetailSectionCell.h
//  LightAccounting
//
//  Created by ddllzz on 2017/4/20.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Style.h"

@interface BillDetailSectionCell : UIView{
    
    UILabel *currentLabel;
    UILabel *numberLabel;
    
}

@property (nonatomic,strong,readwrite) NSString *date;

@property (nonatomic,strong,readwrite) NSString *money;

@property (nonatomic,assign,readwrite) BOOL ifFirstLine;

@end
