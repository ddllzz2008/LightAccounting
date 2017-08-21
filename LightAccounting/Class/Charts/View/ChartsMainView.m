//
//  ChartsMainView.m
//  LightAccounting
//
//  Created by ddllzz on 2017/8/15.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "ChartsMainView.h"

//页签宽度
//static const float tabwidth = 95.0f;
////间距
//static const float margin = 12.0f;

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
    
    [self.topscrollview setBackgroundColor:get_theme_color];
    [self.label_contanier setBackgroundColor:get_theme_color];
    
    [self.label_category setTextColor:UIColorFromRGB(0xffffff)];
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
    
//    self.webview_chart1.scrollView.scrollEnabled=NO;
    
    [self.image_chart1start setBounds:CGRectMake(0, 0, 30, 30)];
    [self.image_chart1end setBounds:CGRectMake(0, 0, 30, 30)];
    
    self.chart1Range = [[[NSDate dateWithZone] dateForCurrentMonth] mutableCopy];
    
    [self.label_chart1start setText:[[self.chart1Range objectAtIndex:0] formatWithCode:@"yyyy年MM月dd日"]];
    self.label_chart1start.userInteractionEnabled=YES;
    UITapGestureRecognizer *chart1start_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseDate:)];
    [self.label_chart1start addGestureRecognizer:chart1start_tap];
    
    [self.label_chart1end setText:[[self.chart1Range objectAtIndex:1] formatWithCode:@"yyyy年MM月dd日"]];
    self.label_chart1end.userInteractionEnabled=YES;
    UITapGestureRecognizer *chart1end_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseDate:)];
    [self.label_chart1end addGestureRecognizer:chart1end_tap];
}

-(void)addTabAction:(UILabel *)label{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabChanged:)];
    label.userInteractionEnabled=YES;
    [label addGestureRecognizer:tap];
    
}

-(void)chooseDate:(UITapGestureRecognizer *)sender{
    
    UILabel *label = (UILabel *)sender.view;
    
    DLFullDatePicker *picker = [[DLFullDatePicker alloc] initWithFrame:CGRectMake(20, 60, ScreenSize.width-40, 400)];
    picker.selectedDate = [label.text convertDateFromString:@"yyyy年MM月dd日"];
    [picker showDatePicker:^(NSDate *result) {
        
        if ([label isEqual:self.label_chart1start]) {

            [self.chart1Range replaceObjectAtIndex:0 withObject:result];
            
        }else if([label isEqual:self.label_chart1end]){
            
            [self.chart1Range replaceObjectAtIndex:1 withObject:result];
            
        }
        
        if (self.didChanged) {
            self.didChanged(0);
        }
        
        [label setText:[result formatWithCode:@"yyyy年MM月dd日"]];
    }];
    
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
    [label setTextColor:UIColorFromRGB(0xffffff)];
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

-(void)loadData{
    NSString *chart1path = [[NSBundle mainBundle] pathForResource:@"PieChart" ofType:@"html"];
    NSURL *chart1url = [NSURL fileURLWithPath:chart1path];
    NSURLRequest *chart1request = [NSURLRequest requestWithURL:chart1url];
    [self.webview_chart1 loadRequest:chart1request];
}


@end
