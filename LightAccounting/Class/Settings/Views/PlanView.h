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
#import "DateButton.h"

typedef void(^layoutChanged)(int rowheight);

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
    
    DateButton *selectedButton;
}

@property (nonatomic,copy) layoutChanged layoutchanged;

@property (nonatomic,strong,readwrite) NSDate *currentDate;

@property (nonatomic,assign) CGFloat initHeight;

-(void)hiddenDate;
-(void)showDate;

@end
