//
//  ChartsMainView.h
//  LightAccounting
//
//  Created by ddllzz on 2017/8/15.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartsMainView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *chart_category;
@property (weak, nonatomic) IBOutlet UILabel *label_category;

@property (weak, nonatomic) IBOutlet UIImageView *chart_outrange;
@property (weak, nonatomic) IBOutlet UILabel *label_outrange;

@property (weak, nonatomic) IBOutlet UIImageView *chart_month;
@property (weak, nonatomic) IBOutlet UILabel *label_month;

@property (weak, nonatomic) IBOutlet UIImageView *chart_map;
@property (weak, nonatomic) IBOutlet UILabel *label_map;

@property (weak, nonatomic) IBOutlet UIImageView *chart_generate;
@property (weak, nonatomic) IBOutlet UILabel *label_generate;


@end
