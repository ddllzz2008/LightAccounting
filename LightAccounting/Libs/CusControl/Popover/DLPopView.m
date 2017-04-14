//
//  DLPopView.m
//  DLZProject
//
//  Created by ddllzz on 16/12/16.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "DLPopView.h"
#import "UIView+ExtMethod.h"

@implementation DLPopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    
    self.contentBackground = [UIColor whiteColor];
    self.borderColor = [UIColor whiteColor];
    self.borderWidth = 1;
    self.borderRadius = 5;
    self.arrowHeight = 10;
}

-(void)show:(__weak UIView *)sender{
    UIViewController *viewcontroller = [self viewController];
    self.isShow=YES;
    pointSender = sender;

    viewhidden = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height)];
    [viewhidden setBackgroundColor:[UIColor grayColor]];
    [viewhidden setAlpha:0.3f];
    [viewcontroller.view addSubview:viewhidden];
    [viewcontroller.view bringSubviewToFront:viewhidden];
    
    [viewcontroller.view bringSubviewToFront:self];
    
    UITapGestureRecognizer *hiddenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenPopover:)];
    [viewhidden addGestureRecognizer:hiddenTap];
    
    [self setNeedsDisplay];
}

-(void)hiddenPopover:(UITapGestureRecognizer *)sender{
    
    [viewhidden removeFromSuperview];
    self.isShow = NO;
    [self setNeedsDisplay];
    
}

-(void)drawRect:(CGRect)rect{
    
    if (self.isShow) {
        
        [self setHidden:NO];
        
        [self showSubViews:self];
        
    }else{
        [self setHidden:YES];
        
        [self hiddenSubViews:self];
        
        return;
    }
    
    float pointx = rect.size.width / 2;
    
    if (pointSender!=nil) {
        UIViewController *viewcontroller = [self viewController];
        CGPoint pointRect = [viewcontroller.view convertPoint:CGPointZero fromView:pointSender];
        float fromx = pointRect.x + pointSender.frame.size.width /2;
        float marginright = ScreenSize.width - rect.size.width - self.frame.origin.x;
        float marginleft = self.frame.origin.x;
        if ((fromx + rect.size.width /2 + marginright) > ScreenSize.width) {
            //箭头需要偏右
            pointx = rect.size.width /2 + (fromx + rect.size.width /2 + marginright - ScreenSize.width);
        }else if(rect.size.width /2 > (fromx + marginleft)){
            //箭头需要偏左
            pointx = rect.size.width /2 - (rect.size.width /2 - marginleft - fromx);
        }
        else{
            //正中间
            pointx = rect.size.width / 2;
        }
    }
    
    
    [[UIColor clearColor]set];
    
    double width = rect.size.width;
    double height = rect.size.height;
    double dis = self.arrowHeight;
    double radius = self.borderRadius;
//    double radius = 20;
    double borderWidth = self.borderWidth;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    
    CGContextSetFillColorWithColor(context, self.contentBackground.CGColor);
    
    CGContextSetLineWidth(context, borderWidth);//线宽
    
    CGPoint aPoints[3];
    aPoints[0] = CGPointMake(pointx - dis, dis);
    aPoints[1] = CGPointMake(pointx, 0);
    aPoints[2] = CGPointMake(pointx + dis, dis);
    
    CGContextAddLines(context, aPoints, 3);
    
    CGPoint lPoints[2];
    lPoints[0] = CGPointMake(radius, dis);
    lPoints[1] = CGPointMake(pointx - dis, dis);
    CGContextAddLines(context, lPoints, 2);
    
    CGPoint rPoints[2];
    rPoints[0] = CGPointMake(pointx + dis, dis);
    rPoints[1] = CGPointMake(width - borderWidth - radius, dis);
    CGContextAddLines(context, rPoints, 2);
    
//    CGContextClosePath(context);//封闭形状
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextMoveToPoint(context, width-borderWidth - radius, 0+dis);//起点，坐标右上角（上）
    CGContextAddArcToPoint(context, width - borderWidth, 0+dis, width - borderWidth, radius+dis, radius);//右上角，右上角（下）
    CGContextAddArcToPoint(context, width, height - borderWidth, width-radius, height - borderWidth, radius);//右下角，右下角（左）
    CGContextAddArcToPoint(context, borderWidth, height - borderWidth, borderWidth, height-radius, radius);//左下角，左下角（上）
    CGContextAddArcToPoint(context, borderWidth, 0+dis, radius, 0+dis, radius);//左上角，左上角（右）
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    if (self.isShow) {
        [self setHidden:!self.isShow];
    }else{
        [self setHidden:YES];
    }
}

-(void)hiddenSubViews:(UIView *)view{
    if (view.subviews!=nil&&view.subviews.count>0) {
        for (UIView *subview in view.subviews) {
            if (subview.subviews!=nil&&subview.subviews.count>0) {
                [self hiddenSubViews:subview];
            }else{
                [subview setHidden:YES];
                [subview setAlpha:0.0f];
            }
        }
    }else{
        return;
    }
}

-(void)showSubViews:(UIView *)view{
    if (view.subviews!=nil&&view.subviews.count>0) {
        for (UIView *subview in view.subviews) {
            if (subview.subviews!=nil&&subview.subviews.count>0) {
                [self showSubViews:subview];
            }else{
                [subview setHidden:NO];
                [subview setAlpha:1.0f];
            }
        }
    }else{
        return;
    }
}

@end
