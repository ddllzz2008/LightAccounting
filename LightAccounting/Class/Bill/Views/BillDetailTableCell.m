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
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
        
        __weak __typeof(self.contentView) weakself = self.contentView;
        
        imagetype = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
        [self.contentView addSubview:imagetype];
        
        [imagetype mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakself) strongself = weakself;
            make.left.equalTo(strongself.mas_left).with.offset(40);
            make.centerY.equalTo(strongself);
        }];
        
        typenameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 90, 20)];
        typenameLabel.textAlignment=NSTextAlignmentLeft;
        [typenameLabel setStyle:fontsize_16 color:UIColorFromRGB(0xbbbbbb)];
        [self.contentView addSubview:typenameLabel];
        
        [typenameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            __strong __typeof(weakself) strongself = weakself;
            make.left.equalTo(imagetype.mas_right).with.offset(5);
            make.centerY.equalTo(imagetype);
            make.size.mas_equalTo(CGSizeMake(90, 20));
        }];
        
        typesectionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        typesectionLabel.textAlignment=NSTextAlignmentLeft;
        [typesectionLabel setStyle:fontsize_13 color:UIColorFromRGB(0xbbbbbb)];
        [self.contentView addSubview:typesectionLabel];
        
        [typesectionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(typenameLabel.mas_right).with.offset(15);
            make.centerY.equalTo(imagetype);
            make.size.mas_equalTo(CGSizeMake(40, 20));
        }];
        
        detailnumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
        detailnumberLabel.textAlignment=NSTextAlignmentRight;
        [detailnumberLabel setStyle:fontsize_16 color:UIColorFromRGB(0xAAAAAA)];
        [self.contentView addSubview:detailnumberLabel];
        
        [detailnumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakself) strongself = weakself;
            make.right.equalTo(strongself.mas_right).with.offset(-15);
            make.centerY.equalTo(imagetype);
            make.width.equalTo(strongself.mas_width).multipliedBy(0.4);
        }];
    }
    
    return self;
}

-(void)setTypeImage:(UIImage *)typeImage{
    _typeImage = typeImage;
    [imagetype setImage:typeImage];
    
}

-(void)setTypeName:(NSString *)typeName{
    _typeName = typeName;
    [typenameLabel setText:typeName];
}

-(void)setTypeSection:(NSString *)typeSection{
    _typeSection = typeSection;
    [typesectionLabel setText:typeSection];
}

-(void)setDetailNumber:(NSString *)detailNumber{
    _detailNumber = detailNumber;
    [detailnumberLabel setText:detailNumber];
}


-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx,2);
    //        CGContextMoveToPoint(ctx, 10, 0);//设置Path的起点
    //        CGContextAddLineToPoint(ctx, 10, self.contentView.frame.size.height);
    //
//    [get_theme_color setStroke];
    [UIColorFromRGB(0xCCCCCC) setStroke];
    
    //        CGContextStrokePath(ctx);
    
    CGPoint aPoints[2];//坐标点
    aPoints[0] =CGPointMake(20, 0);//坐标1
    aPoints[1] =CGPointMake(20, self.contentView.frame.size.height);//坐标2
    //CGContextAddLines(CGContextRef c, const CGPoint points[],size_t count)
    //points[]坐标数组，和count大小
    CGContextAddLines(ctx, aPoints, 2);//添加线
    CGContextDrawPath(ctx, kCGPathStroke); //根据坐标绘制路径
    
}

@end
