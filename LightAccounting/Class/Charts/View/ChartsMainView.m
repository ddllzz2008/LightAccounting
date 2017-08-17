//
//  ChartsMainView.m
//  LightAccounting
//
//  Created by ddllzz on 2017/8/15.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "ChartsMainView.h"

//页签宽度
static const float tabwidth = 95.0f;
//间距
static const float margin = 12.0f;

@interface ChartsMainView(){
    
    UILabel *currentLabel;
    NSInteger currentPage;
    
}

@end


@implementation ChartsMainView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] lastObject];
        [self setFrame:frame];
        
    }
    return self;
}

-(void)awakeFromNib{
    
    [super awakeFromNib];
    
    [self.label_category setTextColor:get_theme_color];
    self.label_category.tag=1;
    [self.label_outrange setTextColor:UIColorFromRGB(0x333333)];
    self.label_outrange.tag=2;
    [self.label_month setTextColor:UIColorFromRGB(0x333333)];
    self.label_month.tag=3;
    [self.label_map setTextColor:UIColorFromRGB(0x333333)];
    self.label_map.tag=4;
    [self.label_generate setTextColor:UIColorFromRGB(0x333333)];
    self.label_generate.tag=5;
    //默认第一个页签为选中页签
    currentLabel = self.label_category;
    currentPage = 1;
    
    
    [self addTabAction:self.label_category];
    [self addTabAction:self.label_outrange];
    [self addTabAction:self.label_month];
    [self addTabAction:self.label_map];
    [self addTabAction:self.label_generate];
    
    self.contentscrollview.delegate=self;
}

-(void)addTabAction:(UILabel *)label{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabChanged:)];
    label.userInteractionEnabled=YES;
    [label addGestureRecognizer:tap];
    
}

/**
 tab标签点击事件

 @param sender 手势对象
 */
-(void)tabChanged:(UITapGestureRecognizer *)sender{
    
    if (currentLabel!=nil) {
        [currentLabel setTextColor:UIColorFromRGB(0x333333)];
    }
    
    UILabel *label = (UILabel *)sender.view;
    [label setTextColor:get_theme_color];
    currentLabel = label;
    if(currentPage!=label.tag){
        
        [self.contentscrollview setContentOffset:CGPointMake(self.frame.size.width*(label.tag-1), 0) animated:YES];
        
        currentPage = label.tag;
    }
    
    float x = label.frame.origin.x-label.frame.size.width/2;
    if (x<=0) {
        x=0;
    }
    
    [self.topscrollview setContentOffset:CGPointMake(x, 0) animated:YES];
    
}

/**
 滚动内容监听

 @param scrollView 滚动对象
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger page = scrollView.contentOffset.x/self.frame.size.width;
    
    if (currentLabel!=nil) {
        [currentLabel setTextColor:UIColorFromRGB(0x333333)];
    }
    
    UILabel *label = [[self.label_contanier subviews] objectAtIndex:page];
    [label setTextColor:get_theme_color];
    currentLabel = label;
    if(currentPage!=label.tag){
        
        currentPage = label.tag;
    }
    
    float x = label.frame.origin.x-label.frame.size.width/2;
    if (x<=0) {
        x=0;
    }
    
    [self.topscrollview setContentOffset:CGPointMake(x, 0) animated:YES];
}


@end
