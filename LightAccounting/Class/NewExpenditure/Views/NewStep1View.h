//
//  NewStep1View.h
//  LightAccounting
//
//  Created by ddllzz on 17/3/26.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "CategoryViewController.h"
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
#import "DLFullDatePicker.h"

@interface NewStep1View : UIView<UIGestureRecognizerDelegate,UITextFieldDelegate,CategoryChooseViewDelegate,DLDatePickerViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>{
    
    UITextField *labeldate;
    
    UIImageView *imgcategory;
    
    UITextField *labelcategory;
    
    UITextField *labelmap;
    
    UISwitch *switchAlert1;
    
//    UISwitch *switchAlert;
    //地图对象
    BMKLocationService *mapservice;
    BMKGeoCodeSearch *geocodesearch;
    
    //数据对象
    NewExpendModel *model;
    NSMutableArray *categoryarray;
}

@property (nonatomic,assign) int accountType;

@property (nonatomic,strong) NSString *id;

@property (nonatomic,strong) ExpendViewModel *viewmodel;

@property (nonatomic,strong) UITextField *labelremark;

@property (nonatomic,strong) UITextField *inputmoney;

@property(nonatomic,strong) UIWindow *chooseWindow;

-(void)stopLocation;

-(instancetype)initWithTypeFrame:(int)type id:(NSString *)id frame:(CGRect)frame;

/**
 打开类别选择对话框
 
 @param sender 手势对象
 */
-(void)showCategory:(UITapGestureRecognizer *)sender;

-(void)addObserve;

-(void)removeObserve;

@end
