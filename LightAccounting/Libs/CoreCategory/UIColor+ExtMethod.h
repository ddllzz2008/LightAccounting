//
//  UIColor+ExtMethod.h
//  LightAccounting
//
//  Created by ddllzz on 17/4/26.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ExtMethod)

+ (UIColor*) colorWithHex:(NSInteger)hexValue alpha:(CGFloat)alphaValue;

+ (UIColor*) colorWithHex:(NSInteger)hexValue;

+ (NSString *) hexFromUIColor: (UIColor*) color;

+ (UIColor *) colorWithHexString: (NSString *)color;

@end
