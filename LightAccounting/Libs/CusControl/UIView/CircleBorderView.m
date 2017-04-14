//
//  CircleBorderView.m
//  DLZProject
//
//  Created by ddllzz on 16/12/27.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "CircleBorderView.h"

@implementation CircleBorderView

-(void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context,kCGLineCapSquare);
    
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    
    CGContextSetFillColorWithColor(context, self.topBackground.CGColor);
    
    CGContextSetLineWidth(context,self.borderWidth);
    
    double width = rect.size.width;
    
    double topheight = rect.size.height - self.bottomHeight;
    
    double radius = 5;
    
    CGContextMoveToPoint(context, self.borderWidth, topheight);
    
    CGContextAddLineToPoint(context, self.borderWidth, radius);
    
    CGContextAddArcToPoint(context, 0, 0, radius, 0, radius);
    CGContextAddArcToPoint(context, width - self.borderWidth, 0, width-self.borderWidth, radius, radius);
    
    CGContextAddLineToPoint(context, width, topheight);
    
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
    CGContextSetFillColorWithColor(context, self.bottomBackground.CGColor);
    
    
    CGContextMoveToPoint(context, self.borderWidth, topheight);
    
    CGContextAddArcToPoint(context, self.borderWidth, rect.size.height, radius, rect.size.height, radius);
    
    CGContextAddArcToPoint(context, width - self.borderWidth, rect.size.height, width-self.borderWidth, rect.size.height - radius, radius);
    
    CGContextAddLineToPoint(context, width, topheight);
    
    CGContextClosePath(context);
    
    CGContextDrawPath(context, kCGPathFillStroke);
    
//    CGContextFillPath(context);
}

-(void)layoutSubviews{
    
    CGRect rect = self.frame;
    
    double width = rect.size.width;
    
    double topheight = rect.size.height - self.bottomHeight;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, topheight, width, self.bottomHeight)];
    [label setText:self.title];
    [label setTextColor:self.tintColor];
    [label setFont:self.font];
    label.textAlignment=NSTextAlignmentCenter;
    [self addSubview:label];
    
    
    UIImageView *imageview = [[UIImageView alloc] initWithImage:self.image];
    imageview.frame=CGRectMake(1, 1, width-2, topheight);
    imageview.contentMode = UIViewContentModeCenter;
    [self addSubview:imageview];
}

@end
