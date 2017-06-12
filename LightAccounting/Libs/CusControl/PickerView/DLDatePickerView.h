//
//  DLDatePickerView.h
//  DLZProject
//
//  Created by ddllzz on 16/12/29.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DLDatePickerViewDelegate <NSObject>
/*!
 *  @brief 选择行
 *
 *  @param index 列索引
 *  @param obj   所选对象
 *
 *  @since 1.0
 */
-(void)DLDatePickerView:(NSInteger)tag didSelectDate:(NSDate*)date;

@end

@interface DLDatePickerView : UIWindow<UIPickerViewDataSource,UIPickerViewDelegate>{
    
    UIView *backgroundView;
    
    UIDatePicker *picker;
    
    NSDate *selectedDate;
    
}

+(id)sharedInstance;

@property (nonatomic,assign) UIDatePickerMode dateMode;

@property (nonatomic,assign) NSDate *minDate;

@property (nonatomic,assign) NSDate *maxDate;

@property (nonatomic,assign) NSDate *date;

@property (nonatomic,strong) id<DLDatePickerViewDelegate> delegate;

-(void)show;

@end
