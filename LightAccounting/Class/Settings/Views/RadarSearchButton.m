//
//  RadarSearchButton.m
//  LightAccounting
//
//  Created by ddllzz on 2017/5/27.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "RadarSearchButton.h"

@implementation RadarSearchButton
    
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
    
    __weak typeof(self) weakSelf = self;
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
    [title setStyle:fontsize_13 color:UIColorFromRGB(0xdddddd)];
    [title setText:@"点击添加长按搜索"];
    title.textAlignment=NSTextAlignmentCenter;
    [self addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.left.equalTo(strongSelf);
        make.bottom.equalTo(strongSelf.mas_bottom).with.offset(-10);
        make.width.equalTo(strongSelf);
        make.height.equalTo(@20);
    }];
}
    


-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    [get_theme_color setFill];
    
    CGContextMoveToPoint(context, rect.size.width/2, rect.size.height);//移动画笔到指定坐标点
    
    CGContextAddArc(context, rect.size.width/2, rect.size.height, rect.size.width/2, 2*M_PI, M_PI, 1);
    //绘制圆弧
    CGContextDrawPath(context, kCGPathFill);
}
    
-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    DDLogDebug(@"RadarSearchButton touches end");
    
    if (self.delegate) {
        [self.delegate RadarSearchButtonTouchEnd];
    }
}
    
@end
