//
//  RadarUIView.h
//  LightAccounting
//
//  Created by ddllzz on 2017/5/26.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UILabel+Style.h"

@interface RadarUIView : UIView{
    
    UILabel *alertLabel;
    
}

@property (nonatomic,strong) NSString *alertMessage;

@property (nonatomic,strong) NSArray *deviceList;

@end
