//
//  ChartsMainView.h
//  LightAccounting
//
//  Created by ddllzz on 2017/8/15.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DLFullDatePicker.h"

typedef void(^didChartsMainViewChanged)(NSInteger chartindex);

@interface ChartsMainView : UIView<UIScrollViewDelegate>{
    
    //业务参数
//    NSMutableArray *monthrange;
    
}

@property (weak, nonatomic) IBOutlet UIScrollView *topscrollview;

@property (weak, nonatomic) IBOutlet UIView *label_contanier;


@property (weak, nonatomic) IBOutlet UILabel *label_category;

@property (weak, nonatomic) IBOutlet UILabel *label_outrange;

@property (weak, nonatomic) IBOutlet UILabel *label_month;

@property (weak, nonatomic) IBOutlet UILabel *label_map;

@property (weak, nonatomic) IBOutlet UILabel *label_generate;

@property (weak, nonatomic) IBOutlet UIScrollView *contentscrollview;
@property (weak, nonatomic) IBOutlet UIWebView *webview_chart1;
@property (weak, nonatomic) IBOutlet UIImageView *image_chart1start;
@property (weak, nonatomic) IBOutlet UILabel *label_chart1start;
@property (weak, nonatomic) IBOutlet UIImageView *image_chart1end;

@property (weak, nonatomic) IBOutlet UILabel *label_chart1end;

@property (nonatomic,strong) NSMutableArray *chart1Range;

#pragma mark---回调
@property (nonatomic,copy) didChartsMainViewChanged didChanged;


#pragma mark---Method
-(void)loadData;

@end
