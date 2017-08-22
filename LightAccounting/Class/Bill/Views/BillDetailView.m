//
//  BillDetailView.m
//  LightAccounting
//
//  Created by ddllzz on 2017/8/15.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BillDetailView.h"

@implementation BillDetailView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
        [self setFrame:frame];
        
        [self.btn_close addTarget:self action:@selector(close_window:) forControlEvents:UIControlEventTouchUpInside];
        [self.btn_delete addTarget:self action:@selector(delete_model:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(instancetype)initWithFrameAndSection:(CGRect)frame section:(NSInteger)section item:(NSInteger)item{
    self = [self initWithFrame:frame];
    _section = section;
    _item = item;
    return self;
}

-(void)setSource:(BusExpenditure *)source{

    self.label_time.text = source.CREATETIME;
    self.label_address.text = [source.BDADDRESS isEqual:@"(null)"]?@"":source.BDADDRESS;;
    self.label_category.text = source.CNAME;
    self.label_money.text = [NSString stringWithFormat:@"%.1f",fabs(source.EVALUE)];
    self.label_note.text = [source.IMARK isEqual:@"(null)"]?@"":source.IMARK;
    
}

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    [self.label_time setFont:fontsize_14];
    [self.label_address setFont:fontsize_14];
    [self.label_category setFont:fontsize_14];
    [self.label_money setFont:fontsize_14];
    [self.label_note setFont:fontsize_14];
    
    [self.icon_alarm setBounds:CGRectMake(0, 0, autoScaleW(40), autoScaleW(40))];
    [self.icon_map setBounds:CGRectMake(0, 0, autoScaleW(40), autoScaleW(40))];
    [self.icon_category setBounds:CGRectMake(0, 0, autoScaleW(40), autoScaleW(40))];
    [self.icon_budget setBounds:CGRectMake(0, 0, autoScaleW(40), autoScaleW(40))];
    [self.icon_note setBounds:CGRectMake(0, 0, autoScaleW(40), autoScaleW(40))];
    
    
//    float btnwidth = (rect.size.width-32-10)/2;
    
    
    [self.btn_delete setBackgroundColor:get_theme_color];
//    [self.btn_delete setBounds:CGRectMake(0, 0, btnwidth, 35)];
//    [self.btn_close setBounds:CGRectMake(0, 0, btnwidth, 35)];
}

#pragma mark---事件操作
-(void)close_window:(id)btn{
    
    if (self.delegate) {
        [self.delegate billdetailview:YES];
    }
    
}

-(void)delete_model:(id)btn{
    if (self.delegate) {
        [self.delegate billdetailview:_section item:_item];
    }
}

@end
