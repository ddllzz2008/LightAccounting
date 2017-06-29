//
//  BillDetailSectionCell.m
//  LightAccounting
//
//  Created by ddllzz on 2017/4/20.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BillDetailSectionCell.h"

@implementation BillDetailSectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor whiteColor];
        
        [self initLayout];
        
    }
    return self;
}
    
-(id)init{
    if (self==[super init]) {
        self.backgroundColor=[UIColor whiteColor];
        [self initLayout];
    }
    return self;
}

-(void)initLayout{
    
    double width = ScreenSize.width-30;
    
    currentLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 40, 40)];
    [currentLabel setStyle:fontsize_16 color:UIColorFromRGB(0xAAAAAA)];
    currentLabel.textAlignment=NSTextAlignmentLeft;
    [self addSubview:currentLabel];
    
//    __weak __typeof(self) weakself = self;
//    
//    [currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        __strong __typeof(weakself) strongself = weakself;
//        make.left.equalTo(strongself.mas_left).with.offset(40);
//        make.width.mas_equalTo(@40);
//        make.height.equalTo(strongself);
//    }];
    
    numberLabel = [[UILabel alloc] initWithFrame:CGRectMake(width/2, 0, width/2, 40)];
    [numberLabel setStyle:fontsize_20 color:UIColorFromRGB(0xAAAAAA)];
    numberLabel.textAlignment=NSTextAlignmentRight;
    [self addSubview:numberLabel];
    
//    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        __strong __typeof(weakself) strongself = weakself;
//        make.right.equalTo(strongself.mas_right);
//        make.width.mas_equalTo(strongself.mas_width).multipliedBy(0.5);
//        make.height.equalTo(strongself);
//    }];
}

-(void)setDate:(NSString *)date{
    _date = date;
    [currentLabel setText:date];
}

-(void)setMoney:(NSString *)money{
    _money = money;
    [numberLabel setText:money];
}
    
-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    
    double radius = 10;
    
//    CGRect bigrect = CGRectMake(2, 2, rect.size.width-4, rect.size.height-4);
    
    CGRect frame = CGRectMake(20-radius, (rect.size.height - radius*2)/2, radius*2, radius*2);

    CGContextAddEllipseInRect(ctx, frame);
    [get_theme_color set];
    CGContextFillPath(ctx);
    
    CGContextSetLineWidth(ctx,2);
    //        CGContextMoveToPoint(ctx, 10, 0);//设置Path的起点
    //        CGContextAddLineToPoint(ctx, 10, self.contentView.frame.size.height);
    //
    [get_theme_color setStroke];
    
    //        CGContextStrokePath(ctx);
    
    CGPoint aPoints[2];//坐标点
    aPoints[0] =CGPointMake(20, rect.size.height/2+radius);//坐标1
    aPoints[1] =CGPointMake(20, rect.size.height);//坐标2
    //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
    //points[]坐标数组，和count大小
    CGContextAddLines(ctx, aPoints, 2);//添加线
    CGContextDrawPath(ctx, kCGPathStroke); //根据坐标绘制路径
    
    if (self.ifFirstLine) {
        [currentLabel setStyle:fontsize_16 color:get_theme_color];
        [numberLabel setStyle:fontsize_20 color:get_theme_color];
    }else{
        CGPoint aPoints[2];//坐标点
        aPoints[0] =CGPointMake(20, 0);//坐标1
        aPoints[1] =CGPointMake(20, rect.size.height/2 - radius);//坐标2
        //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
        //points[]坐标数组，和count大小
        CGContextAddLines(ctx, aPoints, 2);//添加线
        CGContextDrawPath(ctx, kCGPathStroke); //根据坐标绘制路径
    }
    
}

@end
