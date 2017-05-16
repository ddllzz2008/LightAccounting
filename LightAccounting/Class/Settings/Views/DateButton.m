//
//  DateButton.m
//  LightAccounting
//
//  Created by ddllzz on 17/5/7.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "DateButton.h"

@implementation DateButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=UIColorFromRGB(0xFFFFFF);
        _isSelected = NO;
    }
    return self;
}

-(id)init{
    if (self==[super init]) {
        self.backgroundColor=UIColorFromRGB(0xFFFFFF);
        _isSelected = NO;
    }
    return self;
}

-(void)setIsSelected:(BOOL)isSelected{
    
    _isSelected = isSelected;
    
    [self setNeedsDisplay];
    
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    if (_isSelected) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        /*写文字*/
        CGContextSetFillColorWithColor(context,[UIColor whiteColor].CGColor);
        //    CGContextSetRGBFillColor (context,  166, 209, 87, 1.0);//设置填充颜色
        CGContextFillRect(context,CGRectMake(0, rect.size.height-10, rect.size.width, 10));//填充框
    }
    
}

@end
