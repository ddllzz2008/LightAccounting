//
//  ChartsMainView.m
//  LightAccounting
//
//  Created by ddllzz on 2017/8/15.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "ChartsMainView.h"

@implementation ChartsMainView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
        [self setFrame:frame];
        
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    [self.chart_category setBounds:CGRectMake(0, 0, autoScaleW(70), autoScaleW(70))];
    [self.chart_outrange setBounds:CGRectMake(0, 0, autoScaleW(70), autoScaleW(70))];
    [self.chart_month setBounds:CGRectMake(0, 0, autoScaleW(70), autoScaleW(70))];
    [self.chart_map setBounds:CGRectMake(0, 0, autoScaleW(70), autoScaleW(70))];
    [self.chart_generate setBounds:CGRectMake(0, 0, autoScaleW(70), autoScaleW(70))];
    
    [self.label_category setFont:fontsize_16];
    [self.label_outrange setFont:fontsize_16];
    [self.label_month setFont:fontsize_16];
    [self.label_map setFont:fontsize_16];
    [self.label_generate setFont:fontsize_16];
}


@end
