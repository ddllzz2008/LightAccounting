//
//  ChartsMainView.h
//  LightAccounting
//
//  Created by ddllzz on 2017/8/15.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChartsMainView : UIView<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *topscrollview;

@property (weak, nonatomic) IBOutlet UIView *label_contanier;


@property (weak, nonatomic) IBOutlet UILabel *label_category;

@property (weak, nonatomic) IBOutlet UILabel *label_outrange;

@property (weak, nonatomic) IBOutlet UILabel *label_month;

@property (weak, nonatomic) IBOutlet UILabel *label_map;

@property (weak, nonatomic) IBOutlet UILabel *label_generate;

@property (weak, nonatomic) IBOutlet UIScrollView *contentscrollview;


#pragma mark---Method

@end
