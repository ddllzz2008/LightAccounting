//
//  BillDateChooseView.h
//  LightAccounting
//
//  Created by ddllzz on 17/4/11.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSDate+ExtMethod.h"

typedef NS_ENUM(NSInteger, BillDateChooseMode) {
    BillDateChooseModeYear=0,
    BillDateChooseModeYearMonth=1
};

@protocol BillDateChooseDelegate <NSObject>

@optional
-(void)BillDateChoose:(id)sender prebuttonPressed:(NSDate*)date;
-(void)BillDateChoose:(id)sender nextbuttonPressed:(NSDate*)date;

@end

@interface BillDateChooseView : UIView{
    
    UIView *viewleft;
    
    UIView *viewright;
    
    UILabel *chooseDate;
    
}

-(void)refreshTheme;

@property (nonatomic,strong) NSDate *currentDate;

@property (nonatomic,assign) BillDateChooseMode mode;

@property (nonatomic,weak) id<BillDateChooseDelegate> delegate;

@end
