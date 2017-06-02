//
//  MapChooseViewController.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/2.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKPoiSearch.h>
#import <BaiduMapAPI_Map/BMKMapView.h>
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import "UILabel+Style.h"

@interface MapChooseViewController : BaseViewController<BMKMapViewDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate,UITableViewDelegate,UITableViewDataSource>{
    
    BMKMapView *mapview;
    BMKLocationService *mapservice;
    BMKGeoCodeSearch *geocodesearch;
    BMKPointAnnotation *_pointAnnotation;
    CLLocationCoordinate2D coord;
    NSString *address;
    
    //UI控件
    UILabel *addressLabel;
    UIImageView *searchimg;
    UITextField *searchfield;
    UITableView *resulttableview;
    
    //数据源
    NSMutableArray *tableArray;
}

@end
