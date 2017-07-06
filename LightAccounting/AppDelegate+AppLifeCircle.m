//
//  AppDelegate+AppLifeCircle.m
//  DLZProject
//
//  Created by ddllzz on 16/11/16.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "AppDelegate+AppLifeCircle.h"

#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWith [[UIScreen mainScreen] bounds].size.width

@implementation AppDelegate (AppLifeCircle)

#pragma mark - ScaleSize
- (CGFloat)countScaleW{
    
    CGFloat scalew = 0;
    
    if (kScreenHeight==480) {
        //4s
        scalew =kScreenWith/375;
    }else if(kScreenHeight==568) {
        //5
        scalew =kScreenWith/375;
    }else if(kScreenHeight==667){
        //6
        scalew =kScreenWith/375;
    }else if(kScreenHeight==736){
        //6p
        scalew =kScreenWith/375;
    }else{
        scalew =1;
    }
    
    return scalew;
    
}

- (CGFloat)countScaleH{
    
    CGFloat scaleh = 0;
    
    if (kScreenHeight==480) {
        //4s
        scaleh =kScreenHeight/667;
    }else if(kScreenHeight==568) {
        //5
        scaleh =kScreenHeight/667;
    }else if(kScreenHeight==667){
        //6
        scaleh =kScreenHeight/667;
    }else if(kScreenHeight==736){
        //6p
        scaleh =kScreenHeight/667;
    }else{
        scaleh =1;
    }
    
    return scaleh;
    
}

- (CGFloat)autoScaleW:(CGFloat)w{
    
    return w * [self countScaleW];
    
}

- (CGFloat)autoScaleH:(CGFloat)h{
    
    return h * [self countScaleH];
    
}

@end
