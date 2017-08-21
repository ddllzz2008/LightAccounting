//
//  DLFullDatePicker.h
//  LightAccounting
//
//  Created by ddllzz on 2017/8/21.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Style.h"
#import "NSDate+ExtMethod.h"
#import "NSString+ExtMethod.h"

@interface DateButton : UIButton

@property (nonatomic,assign) BOOL isSelected;

@end

typedef void(^layoutChanged)(int rowheight);
typedef void(^didSelected)(NSDate *selecteddate);

@interface DLFullDatePicker : UIView{
    
    UIWindow *chooseWindow;
    
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
    
    UIButton *closebutton;
    
    UIButton *comfirmbutton;
    
}

@property (nonatomic,copy) layoutChanged layoutchanged;
@property (nonatomic,copy) didSelected didSelected;

@property (nonatomic,strong,readwrite) NSDate *currentDate;

@property (nonatomic,strong,readwrite) NSDate *selectedDate;

@property (nonatomic,assign) CGFloat initHeight;

-(void)showDatePicker:(void(^)(NSDate *))selectedCallback;

@end
