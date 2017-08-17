//
//  BillDetailView.h
//  LightAccounting
//
//  Created by ddllzz on 2017/8/15.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusExpenditure.h"

@protocol BillDetailViewDelegate <NSObject>

@required
-(void)billdetailview:(BOOL)closeWithAnimation;
-(void)billdetailview:(NSInteger)section item:(NSInteger)item;

@end

@interface BillDetailView : UIView{
    
    NSInteger _section;
    NSInteger _item;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *icon_alarm;
@property (weak, nonatomic) IBOutlet UIImageView *icon_map;
@property (weak, nonatomic) IBOutlet UIImageView *icon_category;
@property (weak, nonatomic) IBOutlet UIImageView *icon_budget;
@property (weak, nonatomic) IBOutlet UIImageView *icon_note;
@property (weak, nonatomic) IBOutlet UILabel *label_time;
@property (weak, nonatomic) IBOutlet UILabel *label_address;
@property (weak, nonatomic) IBOutlet UILabel *label_category;
@property (weak, nonatomic) IBOutlet UILabel *label_money;
@property (weak, nonatomic) IBOutlet UILabel *label_note;
@property (weak, nonatomic) IBOutlet UIButton *btn_delete;
@property (weak, nonatomic) IBOutlet UIButton *btn_close;

-(instancetype)initWithFrameAndSection:(CGRect)frame section:(NSInteger)section item:(NSInteger)item;

@property (weak,nonatomic) BusExpenditure *source;

@property (nonatomic,weak) id<BillDetailViewDelegate> delegate;


@end
