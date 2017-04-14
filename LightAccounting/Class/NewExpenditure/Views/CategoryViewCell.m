//
//  CategoryViewCell.m
//  LightAccounting
//
//  Created by ddllzz on 17/4/5.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "CategoryViewCell.h"

@implementation CategoryViewCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.width)];
        [self addSubview:imageview];
        
        title = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.width+3, frame.size.width, frame.size.height-frame.size.width)];
        [title setTextColor:UIColorFromRGB(0xcccccc)];
        [title setTextAlignment:NSTextAlignmentCenter];
        [title setFont:fontsize_14];
        [self addSubview:title];
        
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(void)setAnchorImage:(UIImage *)anchorImage{
    if (imageview!=nil) {
        _anchorImage = anchorImage;
        [imageview setImage:anchorImage];
    }
}

-(void)setLabelText:(NSString *)labelText{
    if (title!=nil) {
        _labelText = labelText;
        [title setText:labelText];
    }
}

-(void)setLabelColor:(UIColor *)color{
    [title setTextColor:color];
}

@end
