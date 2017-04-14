//
//  DLTabView.h
//  DLZProject
//
//  Created by ddllzz on 16/12/13.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DLTabViewDelegate <NSObject>

@required
-(BOOL)dltabviewSelectedChanged:(NSInteger)currentIndex label:(UILabel *)label;

@end

IB_DESIGNABLE
@interface DLTabView : UIView{
    
    UIView *bottomview;
    
    NSArray *titleArray;
    
}
/*!
 *  @brief 页签内容，逗号分隔
 *
 *  @since 1.0
 */
@property (nonatomic,strong,readwrite) IBInspectable NSString *tabArray;

@property (nonatomic,strong,readwrite) IBInspectable UIColor *tabColor;

@property (nonatomic,strong,readwrite) IBInspectable UIColor *textColor;

@property (nonatomic,assign,readwrite) IBInspectable NSInteger fontSize;

@property (nonatomic,assign,readwrite) IBInspectable NSInteger selectedIndex;

@property (nonatomic,assign,readwrite) IBInspectable CGPoint Margin;

@property (nonatomic,retain) id<DLTabViewDelegate> delegate;

@end
