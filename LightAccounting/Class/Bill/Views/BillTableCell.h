//
//  BillTableCell.h
//  LightAccounting
//
//  Created by ddllzz on 17/4/17.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillTableCell : UITableViewCell{
    
    UILabel *typeLabel;
    UILabel *spendmoneyLabel;
    UILabel *spendpercentLabel;
    UIProgressView *progressView;
    
}

@property (nonatomic,strong,readwrite) NSString *typeName;

@property (nonatomic,assign,readwrite) float spendMoney;

@property (nonatomic,assign,readwrite) float spendPercent;

@end
