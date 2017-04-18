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
//#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <CTAssetsPickerController/CTAssetsPickerController.h>
#import "NSString+ExtMethod.h"
#import "NSDate+ExtMethod.h"
#import "UIView+ExtMethod.h"

@interface ExpenditureView : UIView<CTAssetsPickerControllerDelegate>{
    
    UIView *backgroundview;
    
//    MKMapView* mapView;
    
    UILabel *ulmark;
    
    NSArray *imageviewArray;
    
    MainExpendModel *currentmodel;
    
}

@property (nonatomic,copy) BOOL(^updatePhotoBlock)(NSString *eid,NSString *photopath);

-(void)setmodel:(MainGroupModel *)model;

@end
