//
//  ExpenditureView.h
//  LightAccounting
//
//  Created by ddllzz on 17/3/21.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainExpendModel.h"
#import <QuartzCore/QuartzCore.h>
#import "NSString+ExtMethod.h"
#import "NSDate+ExtMethod.h"
#import "UIView+ExtMethod.h"

@interface ExpenditureView : UIView{
    
    UIView *backgroundview;
    
    UIView *container;
    
    UILabel *ulmark;
    
    NSArray *imageviewArray;
    
    MainExpendModel *currentmodel;
    
}

@property (nonatomic,copy) BOOL(^updatePhotoBlock)(NSString *eid,NSString *photopath);

-(void)setmodel:(MainGroupModel *)model;

@end
