//
//  AccountChooseView.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/5.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "AccountChooseView.h"

const double lineHeight = 25;
const double borderWidth = 2;

@implementation AccountChooseView

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
    
    uicanTouch =  YES;
    
    container = [[UIView alloc] initWithFrame:CGRectMake(0, 70-lineHeight, 100, lineHeight)];
    container.layer.cornerRadius = 5;
    container.layer.masksToBounds=YES;
    container.layer.borderWidth=1;
    container.layer.borderColor=UIColorFromRGB(0xdddddd).CGColor;
    
    panmove = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(containerMove:)];
    panmove.cancelsTouchesInView = NO;
    [self addGestureRecognizer:panmove];
    [self addSubview:container];
    
//    __weak typeof(self) weakSelf = self;
//    [container mas_makeConstraints:^(MASConstraintMaker *make) {
//        __strong __typeof(weakSelf) strongSelf = weakSelf;
//        make.width.equalTo(strongSelf);
//        make.left.equalTo(@0);
//        make.bottom.equalTo(strongSelf.mas_bottom);
//        make.height.mas_equalTo(lineHeight);
//    }];
    
}

-(void)setSource:(NSMutableArray *)source{
    
    _source = source;
    self.selectedValue = [source objectAtIndex:0];
    for (int i=0; i<source.count; i++) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, i*lineHeight, 100, lineHeight)];
        if ([[source objectAtIndex:i] isEqualToString:self.selectedValue]) {
            [label setStyle:fontsize_13 color:_textColor];
        }else{
            [label setStyle:fontsize_13 color:UIColorFromRGB(0xcccccc)];
        }
        
        label.textAlignment=NSTextAlignmentCenter;
        [label setText:[source objectAtIndex:i]];
        [container addSubview:label];
        
        label.userInteractionEnabled=NO;
        label.tag = i;
        UITapGestureRecognizer *chooseTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseAccount:)];
        [label addGestureRecognizer:chooseTap];
    }
}

-(void)setContainerColor:(UIColor *)containerColor{
    
    _containerColor = containerColor;
    
    container.backgroundColor = containerColor;
    
}

-(void)setTextColor:(UIColor *)textColor{
    
    _textColor = textColor;
    for (UILabel *label in container.subviews) {
        [label setStyle:fontsize_13 color:_textColor];
    }
    
}

-(void)layoutSubviews{
    
//    container.frame=CGRectMake(0, self.frame.size.height - lineHeight, self.frame.size.width, lineHeight);
    NSLog(@"执行一次layoutSubviews");
    
}

-(void)containerMove:(UIPanGestureRecognizer *)rec{
    
    CGPoint point = [rec translationInView:self];
    CGRect currentframe = self.frame;
    if (currentframe.size.height+point.y < self.oriFrame.size.height) {
        return;
    }else{
        self.frame = CGRectMake(currentframe.origin.x, currentframe.origin.y, currentframe.size.width, currentframe.size.height+point.y);
        container.frame=CGRectMake(0, self.frame.size.height - lineHeight, self.frame.size.width, lineHeight);
    }
    [rec setTranslation:CGPointMake(0, 0) inView:self];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (!uicanTouch) {
        return;
    }
    
    int i = 0;
    for (UILabel *label in container.subviews) {
        label.userInteractionEnabled = YES;
        [label setText:[_source objectAtIndex:i]];
        if ([[_source objectAtIndex:i] isEqualToString:self.selectedValue]) {
            [label setStyle:fontsize_13 color:_textColor];
        }else{
            [label setStyle:fontsize_13 color:UIColorFromRGB(0xcccccc)];
        }
        i++;
    }
    
    self.oriFrame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.oriFrame.size.width, self.oriFrame.size.height);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(self.oriFrame.origin.x, self.oriFrame.origin.y, self.oriFrame.size.width, self.oriFrame.size.height);
        container.frame=CGRectMake(0, self.oriFrame.size.height - lineHeight, self.oriFrame.size.width, lineHeight);
    } completion:^(BOOL finished) {
//        container.frame=CGRectMake(0, 0, self.oriFrame.size.width, lineHeight*_source.count);
        [UIView animateWithDuration:0.5 animations:^{
            
//            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - lineHeight + (lineHeight * _source.count));
//            
            container.frame=CGRectMake(0, container.frame.origin.y, self.oriFrame.size.width, lineHeight * _source.count);
            
        } completion:^(BOOL finished) {
            
            self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height - lineHeight + (lineHeight * _source.count));
            [self removeGestureRecognizer:panmove];
            uicanTouch = NO;
            
        }];
        
    }];
}

/**
 选择账户

 @param sender <#sender description#>
 */
-(void)chooseAccount:(UITapGestureRecognizer *)sender{
    
    NSInteger i = sender.view.tag;
    self.selectedValue = [_source objectAtIndex:i];
    
    UILabel *defaultLabel = [container.subviews objectAtIndex:0];
    [defaultLabel setText:((UILabel *)sender.view).text];
    [defaultLabel setStyle:fontsize_13 color:_textColor];
    
    container.frame=CGRectMake(0, container.frame.origin.y, self.oriFrame.size.width, lineHeight);
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.oriFrame.size.width, self.oriFrame.size.height);
    
    [self addGestureRecognizer:panmove];
    uicanTouch = YES;
    
    for (UILabel *label in container.subviews) {
        label.userInteractionEnabled = NO;
    }
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [_containerColor setStroke];
    CGContextMoveToPoint(context, (rect.size.width-borderWidth)/2, 0);
    CGContextAddLineToPoint(context, (rect.size.width-borderWidth)/2, rect.size.height-10);
    CGContextStrokePath(context);
}

@end
