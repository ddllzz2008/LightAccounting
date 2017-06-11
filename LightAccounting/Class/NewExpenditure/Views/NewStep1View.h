//
//  NewStep1View.h
//  LightAccounting
//
//  Created by ddllzz on 17/3/26.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "UITextField+Style.h"
#import "NSDate+ExtMethod.h"
#import "CategoryChooseView.h"
#import "DLPickerView.h"
#import "DLDatePickerView.h"
#import "UIView+ExtMethod.h"
#import "MapChooseViewController.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import "ExpendViewModel.h"

@interface NewStep1View : UIView<UIGestureRecognizerDelegate,UITextFieldDelegate,CategoryChooseViewDelegate,DLDatePickerViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>{
    
    UITextField *labeldate;
    
    UIImageView *imgcategory;
    
    UITextField *labelcategory;
    
    UITextField *labelmap;
    //地图对象
    BMKLocationService *mapservice;
    BMKGeoCodeSearch *geocodesearch;
    
    //数据对象
    NewExpendModel *model;
}

@property (nonatomic,assign) int accountType;

@property (nonatomic,strong) ExpendViewModel *viewmodel;

@property (nonatomic,strong) NewExpendModel *currentModel;

@property (nonatomic,strong) UITextField *labelremark;

@property (nonatomic,strong) UITextField *inputmoney;

@property(nonatomic,strong) UIWindow *chooseWindow;

-(void)stopLocation;

-(instancetype)initWithTypeFrame:(int)type frame:(CGRect)frame;

@end
