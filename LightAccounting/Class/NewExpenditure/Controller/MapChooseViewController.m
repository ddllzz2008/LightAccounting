//
//  MapChooseViewController.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/2.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "MapChooseViewController.h"

@interface MapChooseViewController ()

@end

@implementation MapChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"选择位置"];
    [self hiddenTabbar];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"item_ok"] style:UIBarButtonItemStyleDone target:self action:@selector(chooseLoationCompleted:)];
    self.navigationItem.rightBarButtonItem = rightitem;
}

-(void)initControls{
    
    geocodesearch = [[BMKGeoCodeSearch alloc] init];
    
    __weak typeof(self.view) weakSelf = self.view;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 80)];
    headerView.backgroundColor = get_theme_color;
    [self.view addSubview:headerView];
    
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, 80));
        make.top.equalTo(strongSelf);
        make.left.equalTo(strongSelf);
    }];
    
    searchfield = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 30)];
    searchfield.layer.cornerRadius=10;
    searchfield.layer.masksToBounds=YES;
    searchfield.font=fontsize_13;
    searchfield.backgroundColor = UIColorFromRGB(0xffffff);
    searchfield.textColor=UIColorFromRGB(0xdddddd);
    [headerView addSubview:searchfield];
    
    __weak typeof(headerView) weakheaderView = headerView;
    [searchfield mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakheaderView) strongSelf = weakheaderView;
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width-60, 30));
        make.left.equalTo(strongSelf).with.offset(10);
        make.top.equalTo(strongSelf).with.offset(10);
    }];
    
    searchimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    searchimg.image = [UIImage imageNamed:@"icon_search"];
    searchimg.userInteractionEnabled=YES;
    UITapGestureRecognizer *searchTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchAction:)];
    [searchimg addGestureRecognizer:searchTap];
    [headerView addSubview:searchimg];
    
    [searchimg mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakheaderView) strongSelf = weakheaderView;
        make.size.mas_equalTo(CGSizeMake(25, 25));
        make.right.equalTo(strongSelf).with.offset(-10);
//        make.left.equalTo(searchfield.mas_right).with.offset(10);
        make.centerY.equalTo(searchfield);
    }];
    
    addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 20)];
    [addressLabel setStyle:fontsize_13 color:UIColorFromRGB(0xdddddd)];
    addressLabel.textAlignment=NSTextAlignmentLeft;
    [headerView addSubview:addressLabel];
    
    [addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakheaderView) strongSelf = weakheaderView;
        make.left.equalTo(strongSelf).with.offset(10);
        make.top.equalTo(searchfield.mas_bottom).with.offset(10);
        make.width.equalTo(strongSelf).with.offset(-20);
        make.height.equalTo(@30);
    }];
    
    resulttableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 60)];
    resulttableview.backgroundColor = UIColorFromRGB(0xffffff);
    resulttableview.delegate=self;
    resulttableview.dataSource=self;
    [self.view addSubview:resulttableview];
    
    [resulttableview mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        __strong __typeof(weakheaderView) strongheaderview = weakheaderView;
        make.left.equalTo(strongSelf);
        make.top.equalTo(strongheaderview.mas_bottom);
        make.right.equalTo(strongSelf);
        make.bottom.equalTo(strongSelf);
    }];
    
    mapview = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0,ScreenSize.width, ScreenSize.height - self.navigationController.navigationBar.frame.size.height)];
    mapview.mapType=BMKMapTypeStandard;//设置地图为空白类型
    mapview.showsUserLocation=YES;//是否显示定位图层（即我的位置的小圆点
    [mapview setZoomLevel:17.0];
    [self.view addSubview:mapview];
    
    [mapview mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf);
        make.right.equalTo(strongSelf);
        make.top.equalTo(headerView.mas_bottom);
        make.bottom.equalTo(strongSelf);
    }];
}

/**
 开始定位
 */
-(void)startLocation{
    mapservice = [[BMKLocationService alloc] init];
    mapservice.delegate=self;
    [mapservice startUserLocationService];
}

/**
 定位结果返回

 @param userLocation <#userLocation description#>
 */
-(void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation{
    
    if(userLocation.location!=nil) {
        
        CLLocationCoordinate2D pt;
        pt = userLocation.location.coordinate;
        pt.latitude= userLocation.location.coordinate.latitude;
        pt.longitude= userLocation.location.coordinate.longitude;
        coord = pt;
        _pointAnnotation= [[BMKPointAnnotation alloc]init];
        _pointAnnotation.coordinate= pt;
        [mapview setCenterCoordinate:pt animated:true];
        [mapview addAnnotation:_pointAnnotation];
        
        [mapservice stopUserLocationService];
        //反编码地理位置
        BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc] init];
        reverseGeocodeSearchOption.reverseGeoPoint= pt;
        [geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    }
}

/**
 地图拖曳

 @param mapView <#mapView description#>
 @param animated <#animated description#>
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
    CLLocationCoordinate2D carLocation = [mapview convertPoint:self.view.center toCoordinateFromView:self.view];
    coord = carLocation;
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc] init];
    option.reverseGeoPoint = CLLocationCoordinate2DMake(carLocation.latitude, carLocation.longitude);
    NSLog(@"%f - %f", option.reverseGeoPoint.latitude, option.reverseGeoPoint.longitude);
    if (_pointAnnotation!=nil) {
        _pointAnnotation.coordinate = CLLocationCoordinate2DMake(option.reverseGeoPoint.latitude, option.reverseGeoPoint.longitude);
    }
    //调用发地址编码方法，让其在代理方法onGetReverseGeoCodeResult中输出
    [geocodesearch reverseGeoCode:option];
}

/**
 地图空白位置点击

 @param mapView <#mapView description#>
 @param coordinate <#coordinate description#>
 */
- (void)mapView:(BMKMapView *)mapView onClickedMapBlank:(CLLocationCoordinate2D)coordinate{
    
    BMKReverseGeoCodeOption *option = [[BMKReverseGeoCodeOption alloc] init];
    option.reverseGeoPoint = coordinate;
    NSLog(@"%f - %f", option.reverseGeoPoint.latitude, option.reverseGeoPoint.longitude);
    if (_pointAnnotation!=nil) {
        _pointAnnotation.coordinate = CLLocationCoordinate2DMake(option.reverseGeoPoint.latitude, option.reverseGeoPoint.longitude);
        coord = _pointAnnotation.coordinate;
    }
    //调用发地址编码方法，让其在代理方法onGetReverseGeoCodeResult中输出
    [geocodesearch reverseGeoCode:option];
    
}

//返回地理反编码
/**
 返回地理编码位置结果

 @param searcher <#searcher description#>
 @param result <#result description#>
 @param error <#error description#>
 */
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error {
    if (result) {
        [addressLabel setText:[NSString stringWithFormat:@"%@", result.address]];
    } else {
        [addressLabel setText:@"未找到地理位置描述"];
    }
}

#pragma mark---交互事件

/**
 搜索结果

 @param sender <#sender description#>
 */
-(void)searchAction:(UITapGestureRecognizer *)sender{
    
    if (![searchfield.text isEqualToString:@""]) {
        BMKPoiSearch *_poiSearch = [[BMKPoiSearch alloc] init];
        _poiSearch.delegate = self;
        //附近云检索
        BMKNearbySearchOption *nearBySearchOption = [[BMKNearbySearchOption alloc] init];
        nearBySearchOption.pageIndex = 0;
        nearBySearchOption.pageCapacity = 10;
        nearBySearchOption.keyword = searchfield.text;
        
        //检索的中心点
        nearBySearchOption.location = mapservice.userLocation.location.coordinate;
        nearBySearchOption.radius = 100;
        
        BOOL flag = [_poiSearch poiSearchNearBy:nearBySearchOption];
        if (flag) {
            NSLog(@"success");
        } else {
            NSLog(@"fail");
        }
    }
}

/**
 检索结果

 @param searcher <#searcher description#>
 @param poiResult <#poiResult description#>
 @param errorCode <#errorCode description#>
 */
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult *)poiResult errorCode:(BMKSearchErrorCode)errorCode {
    
    tableArray = [[NSMutableArray alloc] init];
    
    if (errorCode == BMK_SEARCH_NO_ERROR) {
        for (int i = 0; i < poiResult.poiInfoList.count; i++) {
            BMKPoiInfo *info = [poiResult.poiInfoList objectAtIndex:i];
            [tableArray addObject:info];
        }
        if (tableArray.count>0) {
            [self.view bringSubviewToFront:resulttableview];
        }
        [resulttableview reloadData];
    }else{
        [[AlertController sharedInstance] showMessageAutoClose:@"未搜索到相关地址"];
    }
}

#pragma mark---UITable协议
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return tableArray.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIndetifier = @"mapsearchresultcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndetifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndetifier];
    }
    cell.textLabel.text=[[tableArray objectAtIndex:indexPath.item] name];
    
    return cell;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIButton *closebutton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
    [closebutton setTitle:@"关闭" forState:UIControlStateNormal];
    [closebutton setTitleColor:get_theme_color forState:UIControlStateNormal];
    [closebutton addTarget:self action:@selector(closesearchPanel:) forControlEvents:UIControlEventTouchUpInside];
    return closebutton;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 40;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 40;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BMKPoiInfo *info = [tableArray objectAtIndex:indexPath.item];
    if (_pointAnnotation!=nil) {
        _pointAnnotation.coordinate = info.pt;
        coord = info.pt;
    }
    [mapview setCenterCoordinate:info.pt animated:true];
    [addressLabel setText:[NSString stringWithFormat:@"%@", info.address]];
    [self.view bringSubviewToFront:mapview];
}

-(void)closesearchPanel:(id)sender{
    [self.view bringSubviewToFront:mapview];
}


/**
 返回结果

 @param sender <#sender description#>
 */
-(void)chooseLoationCompleted:(id)sender{
    if (addressLabel.text!=nil && ![addressLabel.text isEqualToString:@""]) {
        if (self.chooseCallback!=nil) {
            self.chooseCallback(self, addressLabel.text, coord.latitude, coord.longitude);
        }
    }else{
        if (self.chooseCallback!=nil) {
            self.chooseCallback(self, @"未选择消费地址", -1, -1);
        }
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark---系统事件
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self initTextFieldArray:searchfield,nil];
    
    [super viewWillAppear:animated];
    
    [mapview viewWillAppear];
    
    [self startLocation];
    
    mapview.delegate=self;
    geocodesearch.delegate=self;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    [mapview viewWillAppear];
    mapview.delegate=nil;
    
    mapservice.delegate=nil;
    geocodesearch.delegate=nil;
    
}

@end
