//
//  UITableView+EmptyPhoto.m
//  LightAccounting
//
//  Created by ddllzz on 2017/7/5.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "UITableView+EmptyPhoto.h"

@implementation UITableView (EmptyPhoto)

/**
 设置UITableView空白图片

 @param count 源数目
 */
-(void)setsourceCount:(NSInteger)count{
    
    if (count==0) {
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                [view removeFromSuperview];
                break;
            }
        }
        //暂无数据
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:self.bounds];
        [imgview setImage:[UIImage imageNamed:@"icon_nodata"]];
        [imgview setContentMode:UIViewContentModeCenter];
        [self addSubview:imgview];
        
        self.scrollEnabled=NO;
        
    }else{
        
        self.scrollEnabled=YES;
        
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                [view removeFromSuperview];
                break;
            }
        }
        
    }
    
}

@end
