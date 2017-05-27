//
//  RadarUIView.m
//  LightAccounting
//
//  Created by ddllzz on 2017/5/26.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "RadarUIView.h"

@implementation RadarUIView


-(void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIColor *bordercolor = get_theme_color;
    [[UIColor whiteColor] setFill];
    UIRectFill(rect);
    NSInteger pulsingCount = 5;
    double animationDuration = 3;
    
    CGSize size = CGSizeMake(rect.size.width/2, rect.size.width/2);
    
    if (alertLabel!=nil&&[alertLabel superview]!=nil) {
        
    }else{
       alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60+size.height/2-20, rect.size.width, 20)];
        [alertLabel setStyle:fontsize_14 color:UIColorFromRGB(0xDDDDDD)];
        alertLabel.textAlignment=NSTextAlignmentCenter;
        [alertLabel setText:self.alertMessage];
        [self addSubview:alertLabel];
    }
    
    CALayer * animationLayer = [CALayer layer];
    for (int i = 0; i < pulsingCount; i++) {
        CALayer * pulsingLayer = [CALayer layer];
        pulsingLayer.frame = CGRectMake(rect.size.width/4, 60, size.width, size.height);
        pulsingLayer.borderColor = bordercolor.CGColor;
        pulsingLayer.borderWidth = 1;
        pulsingLayer.cornerRadius = size.height / 2;
        
        CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        
        CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
        animationGroup.fillMode = kCAFillModeBackwards;
        animationGroup.beginTime = CACurrentMediaTime() + (double)i * animationDuration / (double)pulsingCount;
        animationGroup.duration = animationDuration;
        animationGroup.repeatCount = HUGE;
        animationGroup.timingFunction = defaultCurve;
        
        CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = @1.4;
        scaleAnimation.toValue = @2.2;
        
        CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.values = @[@1, @0.9, @0.8, @0.7, @0.6, @0.5, @0.4, @0.3, @0.2, @0.1, @0];
        opacityAnimation.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
        
        animationGroup.animations = @[scaleAnimation, opacityAnimation];
        [pulsingLayer addAnimation:animationGroup forKey:@"plulsing"];
        [animationLayer addSublayer:pulsingLayer];
    }
    [self.layer addSublayer:animationLayer];
}

@end
