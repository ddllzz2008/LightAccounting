//
//  TapPassView.m
//  LightAccounting
//
//  Created by ddllzz on 17/4/19.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "TapPassView.h"

@implementation TapPassView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        [self initlayout];
    }
    return self;
}

-(id)init{
    if (self==[super init]) {
        self.backgroundColor=[UIColor whiteColor];
         [self initlayout];
    }
    return self;
}

-(void)initlayout{
    
    arrayCircleList = [[NSMutableArray alloc] init];
    arrayPassword = [[NSMutableArray alloc] init];
    arrayImageView = [[NSMutableArray alloc] init];
    
    __weak __typeof(self) weakself = self;
    int radius = 50;
    int space = 30;
    
    for (int a = 1; a<=9; a++) {
        
        if (a%3==0) {
            int row = a/3;
            int col = 3;
            PassCircleView *circle = [self createCircle];
            circle.tag = a;
            [self addSubview:circle];
            [circle mas_makeConstraints:^(MASConstraintMaker *make) {
                __strong __typeof(weakself) strongself = weakself;
                make.right.equalTo(strongself.mas_right).with.offset(0-space);
                make.top.equalTo(strongself.mas_top).with.offset((row-1)*radius+row*space);
                make.size.mas_equalTo(CGSizeMake(50, 50));
            }];
            
            [arrayCircleList addObject:circle];
        }else{
            int row = a/3 + 1;
            int col = a%3;
            PassCircleView *circle = [self createCircle];
            circle.tag=a;
            [self addSubview:circle];
            [circle mas_makeConstraints:^(MASConstraintMaker *make) {
                __strong __typeof(weakself) strongself = weakself;
                if (col==1) {
                    make.left.equalTo(strongself.mas_left).with.offset((col-1)*radius+col*space);
                }else{
                    make.centerX.equalTo(strongself);
                }
                make.top.equalTo(strongself.mas_top).with.offset((row-1)*radius+row*space);
                make.size.mas_equalTo(CGSizeMake(50, 50));
            }];
            
            [arrayCircleList addObject:circle];
        }
    }
    
}

-(PassCircleView *)createCircle{
    PassCircleView *circle  = [[PassCircleView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    circle.Status = PassCircleViewStatusNormal;
    return circle;
}

-(void)showError{
    for (PassCircleView *circle in arrayCircleList) {
        circle.Status = PassCircleViewStatusError;
    }
    
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            for (PassCircleView *circle in arrayCircleList) {
                circle.Status = PassCircleViewStatusNormal;
            }
        });
    });
}

#pragma mark---触摸手势

-(UIImage *)drawImage:(CGPoint)startpoint endpoint:(CGPoint)endpoint{
    
    UIImage *image = nil;
    
    UIGraphicsBeginImageContext(self.frame.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 2);
    CGContextSetStrokeColorWithColor(ctx, [get_theme_color CGColor]);
    CGPoint aPoints[2];//坐标点
    aPoints[0] =startpoint;//坐标1
    aPoints[1] =endpoint;//坐标2
    CGContextAddLines(ctx, aPoints, 2);//添加线
    CGContextDrawPath(ctx, kCGPathStroke); //根据坐标绘制路径
    
    image = UIGraphicsGetImageFromCurrentImageContext();//画图输出
    UIGraphicsEndImageContext();//结束画线
    return image;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if (touch) {
        for (PassCircleView *circle in arrayCircleList) {
            CGPoint po = [touch locationInView:circle];
            if ([circle pointInside:po withEvent:nil]) {
                
                
                [arrayPassword addObject:[NSNumber numberWithInteger:circle.tag]];
                movestartpoint = circle.center;
                circle.Status = PassCircleViewStatusSelected;
                
                break;
                
            }
        }
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    if (touch) {
        moveendpoint = [touch locationInView:self];
        [self setNeedsDisplay];
        for (PassCircleView *circle in arrayCircleList) {
            CGPoint po = [touch locationInView:circle];
            if ([circle pointInside:po withEvent:nil]) {
                BOOL contains = [arrayPassword containsObject:[NSNumber numberWithInteger:circle.tag]];
                if (contains) {
                    break;
                }else{
                    [arrayPassword addObject:[NSNumber numberWithInteger:circle.tag]];
                    circle.Status = PassCircleViewStatusSelected;
                    CGPoint endcenter = circle.center;
                    
                    UIImage *img = [self drawImage:movestartpoint endpoint:endcenter];
                    UIImageView *imgview = [[UIImageView alloc] initWithImage:img];
                    [self addSubview:imgview];
                    [arrayImageView addObject:imgview];
                    
                    movestartpoint = endcenter;
                    break;
                }
            }
        }
    }
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    movestartpoint = CGPointZero;
    moveendpoint = CGPointZero;
    [self setNeedsDisplay];
    
    for (PassCircleView *circle in arrayCircleList) {
        circle.Status = PassCircleViewStatusNormal;
    }
    
    for (UIImageView *imageView in arrayImageView) {
        [imageView removeFromSuperview];
    }
    
    
    if (self.delegate) {
        [self.delegate tappassviewdidfinished:[arrayPassword componentsJoinedByString:@"-"]];
    }
    
    [arrayPassword removeAllObjects];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 2);
    CGContextSetStrokeColorWithColor(ctx, [get_theme_color CGColor]);
    CGPoint aPoints[2];//坐标点
    aPoints[0] =movestartpoint;//坐标1
    aPoints[1] =moveendpoint;//坐标2
    CGContextAddLines(ctx, aPoints, 2);//添加线
    CGContextDrawPath(ctx, kCGPathStroke); //根据坐标绘制路径
}

-(void)clear{
    if (arrayCircleList!=nil) {
        [arrayCircleList removeAllObjects];
        arrayCircleList = nil;
    }
    if (arrayPassword!=nil) {
        [arrayPassword removeAllObjects];
        arrayPassword = nil;
    }
    if (arrayImageView!=nil) {
        [arrayImageView removeAllObjects];
        arrayImageView = nil;
    }
}

@end
