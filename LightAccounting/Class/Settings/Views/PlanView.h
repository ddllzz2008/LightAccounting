//
//  PlanView.h
//  LightAccounting
//
//  Created by ddllzz on 2017/4/28.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Style.h"
#import "NSDate+ExtMethod.h"

@interface PlanView : UIView{
    
    UILabel *labelMonth;
    
    UILabel *labelsunday;
    
    UILabel *labelmonday;
    
    UILabel *labeltuesday;
    
    UILabel *labelwednesday;
    
    UILabel *labelthursday;
    
    UILabel *labelfriday;
    
    UILabel *labelsaturday;
    
    UIView *calanerView;
}

@property (nonatomic,strong,readwrite) NSDate *currentDate;

@end
