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
    //支付类型图标列表
    NSDictionary *paytypeDictionry;
    //私有变量
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
  数据源
 */
@property(nonatomic,strong) NSArray *source;

@property(nonatomic,copy) void(^updatePhotoBlock)(NSString *eid,NSString *photopath);

@property (nonatomic,copy) void(^addnewAccount)();

@end
