//
//  BillDetailTableCell.m
//  LightAccounting
//
//  Created by ddllzz on 2017/4/19.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BillDetailTableCell.h"

@implementation BillDetailTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    if (self) {
        
        __weak __typeof(self) weakself = self;
        
        imagetype = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [self.contentView addSubview:imagetype];
        
        [imagetype mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakself) strongself = weakself;
            make.left.equalTo(strongself.contentView.mas_left).with.offset(30);
            make.centerY.equalTo(strongself.contentView);
        }];
        
    }
    
    return self;
}

-(void)setTypeImage:(UIImage *)typeImage{
    _typeImage = typeImage;
    [imagetype setImage:typeImage];
    
}

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx,2);
    //        CGContextMoveToPoint(ctx, 10, 0);//设置Path的起点
    //        CGContextAddLineToPoint(ctx, 10, self.contentView.frame.size.height);
    //
    [UIColorFromRGB(color_theme_green) setStroke];
    
    //        CGContextStrokePath(ctx);
    
    CGPoint aPoints[2];//坐标点
    aPoints[0] =CGPointMake(10, 0);//坐标1
    aPoints[1] =CGPointMake(10, self.contentView.frame.size.height);//坐标2
    //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
    //points[]坐标数组，和count大小
    CGContextAddLines(ctx, aPoints, 2);//添加线
    CGContextDrawPath(ctx, kCGPathStroke); //根据坐标绘制路径
    
}

@end
