//
//  TopLineView.m
//  LightAccounting
//
//  Created by ddllzz on 17/3/8.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "TopLineView.h"

@implementation TopLineView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=UIColorFromRGB(0xFFFFFF);
    }
    return self;
}

-(id)init{
    if (self==[super init]) {
        self.backgroundColor=UIColorFromRGB(0xFFFFFF);
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    /*写文字*/
    CGContextSetStrokeColorWithColor(context, UIColorFromRGB(0xEEEEEE).CGColor);
    CGContextMoveToPoint(context, 0, 1);
    CGContextAddLineToPoint(context, rect.size.width, 1);
//    CGContextSetShadow(context, CGSizeMake(rect.size.width, 3), 4);
    CGContextDrawPath(context,kCGPathStroke);
}

@end
