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
    
    __weak __typeof(self) weakself = self;
    int radius = 50;
    int space = 30;
    
    for (int a = 1; a<=9; a++) {
        
        if (a%3==0) {
            int row = a/3;
            int col = 3;
            PassCircleView *circle = [self createCircle];
            [self addSubview:circle];
            [circle mas_makeConstraints:^(MASConstraintMaker *make) {
                __strong __typeof(weakself) strongself = weakself;
                make.right.equalTo(strongself.mas_right).with.offset(0-space);
                make.top.equalTo(strongself.mas_top).with.offset((row-1)*radius+row*space);
                make.size.mas_equalTo(CGSizeMake(50, 50));
            }];
        }else{
            int row = a/3 + 1;
            int col = a%3;
            PassCircleView *circle = [self createCircle];
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
        }
    }
    
}

-(PassCircleView *)createCircle{
    PassCircleView *circle  = [[PassCircleView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    circle.Status = PassCircleViewStatusNormal;
    return circle;
}

@end
