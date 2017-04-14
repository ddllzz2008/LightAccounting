//
//  BillChartView.h
//  LightAccounting
//
//  Created by ddllzz on 17/4/11.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BillChartView : UIView

@property (nonatomic,strong,readwrite) NSArray *chartsource;

@property (nonatomic,assign,readwrite) NSInteger selectedMonth;

@end
