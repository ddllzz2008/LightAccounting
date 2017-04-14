//
//  BorderView.m
//  DLZProject
//
//  Created by ddllzz on 16/12/26.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "BorderView.h"

@implementation BorderView

-(void)drawRect:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineCap(context,kCGLineCapSquare);
    
    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    
    CGContextBeginPath(context);
    
    if (self.borderLeft>0) {
        
        CGContextSetLineWidth(context,self.borderLeft);
        
        CGContextMoveToPoint(context,0,0);
        
        CGContextAddLineToPoint(context,0,rect.size.height);
        
        CGContextDrawPath(context, kCGPathStroke);
    }
    
    if (self.borderTop>0) {
        
        CGContextSetLineWidth(context,self.borderTop);
        
        CGContextMoveToPoint(context,0,0);
        
        CGContextAddLineToPoint(context,rect.size.width,0);
        
        CGContextDrawPath(context, kCGPathStroke);
        
    }
    
    if (self.borderRight>0) {
        
        CGContextSetLineWidth(context,self.borderRight);
        
        CGContextMoveToPoint(context,rect.size.width,0);
        
        CGContextAddLineToPoint(context,rect.size.width,rect.size.height);
        
        CGContextDrawPath(context, kCGPathStroke);
        
    }
    
    if (self.borderBottom>0) {
        
        CGContextSetLineWidth(context,self.borderBottom);
        
        CGContextMoveToPoint(context,0,rect.size.height);
        
        CGContextAddLineToPoint(context,rect.size.width,rect.size.height);
        
        CGContextDrawPath(context, kCGPathStroke);
        
    }
}

@end
