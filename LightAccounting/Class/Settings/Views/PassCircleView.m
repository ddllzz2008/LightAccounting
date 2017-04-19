//
//  PassCircleView.m
//  LightAccounting
//
//  Created by ddllzz on 17/4/19.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "PassCircleView.h"

@implementation PassCircleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(id)init{
    if (self==[super init]) {
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)setStatus:(PassCircleViewStatus)Status{
    _Status = Status;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    CGRect bigrect;
    switch (_Status) {
        case PassCircleViewStatusNormal:
            
            bigrect = CGRectMake(2, 2, rect.size.width-4, rect.size.height-4);
            
            //设置空心圆的线条宽度
            CGContextSetLineWidth(ctx, 2);
            //以矩形bigRect为依据画一个圆
            CGContextAddEllipseInRect(ctx, bigrect);
            //填充当前绘画区域的颜色
            [UIColorFromRGB(color_theme_green) set];
            //(如果是画圆会沿着矩形外围描画出指定宽度的（圆线）空心圆)/（根据上下文的内容渲染图层）
            CGContextStrokePath(ctx);
            
            break;
            
        default:
            break;
    }
    
}

@end
