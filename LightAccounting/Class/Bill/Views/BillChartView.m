//
//  BillChartView.m
//  LightAccounting
//
//  Created by ddllzz on 17/4/11.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BillChartView.h"

@implementation BillChartView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor whiteColor];
        self.chartsource = @[@3000,@4500,@9000,@4500,@3000,@2400,@4670,@7800,@9000,@1000,@4666,@1899];
        self.selectedMonth = 4;
        
    }
    return self;
}

-(id)init{
    if (self==[super init]) {
        self.backgroundColor=[UIColor whiteColor];
        
        self.chartsource = @[@3000,@4500,@9000,@4500,@3000,@2400,@4670,@7800,@9000,@1000,@4666,@1899];
        
        self.selectedMonth = 4;
        
    }
    return self;
}

-(CGPoint) midpoint:(CGPoint)p0 p1:(CGPoint)p1 {
    return (CGPoint) {
        (p0.x + p1.x) / 2.0,
        (p0.y + p1.y) / 2.0
    };
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    
    CGFloat colors[] = {
        255 / 255.0, 255 / 255.0, 255 / 255.0, 1.00,
        225 / 255.0, 225 / 255.0, 225 / 255.0, 1.00,
    };
    
    //记录曲线顶点
//    NSMutableArray *pointarray = [[NSMutableArray alloc] initWithCapacity:12];
    //消费所有之和
    float maxvalue = [[self.chartsource valueForKeyPath:@"@max.floatValue"] floatValue];
    
    CGGradientRef _gradient = CGGradientCreateWithColorComponents(rgb, colors, NULL, sizeof(colors)/(sizeof(colors[0])*4));
    CGColorSpaceRelease(rgb);
    
    float laststarty = 0;
    float laststartx = 0;
    CGPoint middlepoint = CGPointMake(0, 0);
    
    float height = 20;
    float width = rect.size.width/12;
    for (int i=0; i<12; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*width, rect.size.height - height, width, height)];
        [label setTextColor:UIColorFromRGB(0xCCCCCC)];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:fontsize_13];
        [label setText:[NSString stringWithFormat:@"%d",i+1]];
        [self addSubview:label];
        
        CGContextSaveGState(ctx);
        //获得一个CGRect
        //    CGRect clip = CGRectInset(CGContextGetClipBoundingBox(ctx), 0, 0);
        //当月所占比例
        float percent = [[self.chartsource objectAtIndex:i] floatValue]/maxvalue;
        float actualheight = (rect.size.height - height) * percent;
        float starty = rect.size.height - height - actualheight;
        float startx = i*width + width/2;
//        [pointarray addObject:CGPointMake(i*width + width/2, starty)];
        if (i > 0) {
            CGContextMoveToPoint(ctx, laststartx, laststarty);//设置Path的起点
            
            middlepoint = [self midpoint:CGPointMake(laststartx, laststarty) p1:CGPointMake(startx, starty)];
            
            CGContextAddQuadCurveToPoint(ctx,middlepoint.x, middlepoint.y, startx, starty);//设置贝塞尔曲线的控制点坐标和终点坐
            
            [UIColorFromRGB(0xFEB1C2) setStroke];
            
            CGContextSetLineWidth(ctx, 2);
            
            CGContextStrokePath(ctx);
        }
        
        laststarty = starty;
        laststartx = startx;
//        float starty = 10;
        //剪切到合适的大小
        CGContextClipToRect(ctx, CGRectMake(i*width + width/2 -1, starty, 2, rect.size.height - height));
        
        DDLogDebug(@"starty:%f",starty);
        //定义起始点和终止点
        CGPoint start = CGPointMake(i*width + width/2 -1, starty);
        CGPoint end = CGPointMake(i*width + width/2 -1, rect.size.height - height);
        //绘制渐变, 颜色的0对应start点,颜色的1对应end点,第四个参数是定义渐变是否超越起始点和终止点
        CGContextDrawLinearGradient(ctx, _gradient, start, end, kCGGradientDrawsBeforeStartLocation);
        
        CGContextRestoreGState(ctx);
    }
    
    float percent = [[self.chartsource objectAtIndex:self.selectedMonth] floatValue]/maxvalue;
    float actualheight = (rect.size.height - height) * percent;
    float starty = rect.size.height - height - actualheight;
    float startx = self.selectedMonth*width + width/2;
    //画当前点
    CGContextAddEllipseInRect(ctx, CGRectMake(startx - 4, starty - 4, 8, 8));
    [UIColorFromRGB(0xF5739E) set];
    CGContextFillPath(ctx);
    
    
//    CGContextRef ctx=UIGraphicsGetCurrentContext();
//    CGContextMoveToPoint(ctx, rect.size.width/2, 0);
//    CGContextAddLineToPoint(ctx, rect.size.width/2-8, 10);
//    CGContextAddLineToPoint(ctx, rect.size.width/2+8, 10);
//    CGContextClosePath(ctx);
//    
//    [[UIColor colorWithRed:166/255.0 green:209/255.0 blue:87/255.0 alpha:1] setFill];
//    CGContextDrawPath(ctx, kCGPathFill);
}

@end
