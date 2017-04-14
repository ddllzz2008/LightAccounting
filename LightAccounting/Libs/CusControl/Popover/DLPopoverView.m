//
//  DLPopoverView.m it's only for ipad or ios8.0~ios9.0
//  DLZProject
//
//  Created by ddllzz on 16/12/15.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "DLPopoverView.h"
#define kArrowBase 30.0f
#define kArrowHeight 20.0f
#define kBorderInset 0.0f

@interface DLPopoverView()
@property (nonatomic, strong) UIImageView *arrowImageView;
- (UIImage *)drawArrowImage:(CGSize)size;
@end

@implementation DLPopoverView

@synthesize arrowDirection  = _arrowDirection;
@synthesize arrowOffset     = _arrowOffset;

#pragma mark - Graphics Methods
- (UIImage *)drawArrowImage:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [[UIColor clearColor] setFill];
    CGContextFillRect(ctx, CGRectMake(0.0f, 0.0f, size.width, size.height));
    
    CGMutablePathRef arrowPath = CGPathCreateMutable();
    CGPathMoveToPoint(arrowPath, NULL, (size.width/2.0f), 0.0f); //Top Center
    CGPathAddLineToPoint(arrowPath, NULL, size.width, size.height); //Bottom Right
    CGPathAddLineToPoint(arrowPath, NULL, 0.0f, size.height); //Bottom Right
    CGPathCloseSubpath(arrowPath);
    CGContextAddPath(ctx, arrowPath);
    CGPathRelease(arrowPath);
    
    UIColor *fillColor = [UIColor yellowColor];
    CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
    CGContextDrawPath(ctx, kCGPathFill);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
    
}


#pragma mark - UIPopoverBackgroundView Overrides
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //TODO: update with border image view
        UIImageView *arrowImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.arrowImageView = arrowImageView;
        [self addSubview:self.arrowImageView];
        
    }
    return self;
}

+ (CGFloat)arrowBase
{
    return kArrowBase;
}

+ (CGFloat)arrowHeight
{
    return kArrowHeight;
}

+ (UIEdgeInsets)contentViewInsets
{
    return UIEdgeInsetsMake(kBorderInset, kBorderInset, kBorderInset, kBorderInset);
}

+ (BOOL)wantsDefaultContentAppearance
{
    return NO;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //TODO: test for arrow UIPopoverArrowDirection
    CGSize arrowSize = CGSizeMake([[self class] arrowBase], [[self class] arrowHeight]);
    self.arrowImageView.image = [self drawArrowImage:arrowSize];
    
    self.arrowImageView.frame = CGRectMake(((self.bounds.size.width - arrowSize.width)- kBorderInset), 0.0f, arrowSize.width, arrowSize.height);
    
}

@end
