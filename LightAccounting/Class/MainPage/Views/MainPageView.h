//
//  MainPageView.h
//  LightAccounting
//
//  Created by ddllzz on 17/3/19.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusExpenditure.h"
#import "WaterWareView.h"
#import "ExpenditureView.h"
#import "MainExpendModel.h"

@interface MainPageView : UIView{
    
    UILabel *currentSpend;
    UILabel *currentPlan;
    //支付类型图标列表
    NSDictionary *paytypeDictionry;
    //私有变量
    WaterWareView *waterview;
    UIView *mapviewleft;
    UIView *mapviewfront;
    UIView *mapviewright;
    UIView *mapviewbg;
    
    //手势
    UISwipeGestureRecognizer *swipeleft;
    UISwipeGestureRecognizer *swiperight;
    
    //滚动列表集合
    NSMutableArray *mapsourceArray;
    NSMutableArray *mapArray;
    
    //索引
    //当前地图序号0-5
    long mapindex;
    //当前数据源序号
    long sourceindex;
    
}

/**
 开始布局
 */
-(void)startlayout;

/**
 加载数据
 */
-(void)loadData;


/**
  数据源
 */
@property(nonatomic,strong) NSArray *source;

@property (nonatomic,assign) CGFloat currentBudget;

@property (nonatomic,assign) CGFloat currentExpend;

@property(nonatomic,copy) void(^updatePhotoBlock)(NSString *eid,NSString *photopath);

@property (nonatomic,copy) void(^addnewAccount)();

-(void)refreshTheme;


@end
