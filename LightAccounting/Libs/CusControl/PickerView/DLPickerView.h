//
//  DLPickerView.h
//  DLZProject
//
//  Created by ddllzz on 16/12/28.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DLPickerViewDelegate <NSObject>
/*!
 *  @brief 选择行
 *
 *  @param obj   所选对象
 *
 *  @since 1.0
 */
-(void)DLPickerView:(NSInteger)tag didSelectObject:(NSMutableArray*)obj;

@end

@interface DLPickerView : UIWindow<UIPickerViewDataSource,UIPickerViewDelegate>{
    
    UIView *backgroundView;
    
    UIPickerView *picker;
    
    NSMutableArray *selectedArray;
    
}

+(id)sharedInstance;

@property (nonatomic,strong) id<DLPickerViewDelegate> delegate;
/*!
 *  @brief 数据源
 *  格式：@[@[@"1",@"1.1"],@[@"2",@"2.2"]];
 *
 *  @since 1.0
 */
@property (nonatomic,strong) NSArray *itemSource;

-(void)show;

@end
