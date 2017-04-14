//
//  DLTabView.m
//  DLZProject
//
//  Created by ddllzz on 16/12/13.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "DLTabView.h"

@implementation DLTabView

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    
}

- (void)drawRect:(CGRect)rect {
    
    if(self.tabArray){
        titleArray = [self.tabArray componentsSeparatedByString:@","];
        for (int i=0; i<titleArray.count; i++) {
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i*ScreenSize.width/titleArray.count+self.Margin.x, self.Margin.y, ScreenSize.width/titleArray.count, 15)];
            label.textAlignment=NSTextAlignmentCenter;
            [label setText:[titleArray objectAtIndex:i]];
            if (self.textColor) {
                [label setTextColor:self.textColor];
            }else{
                [label setTextColor:[UIColor whiteColor]];
            }
            if(self.fontSize){
                [label setFont:[UIFont fontWithName:@"Arial" size:self.fontSize]];
            }else{
                [label setFont:[UIFont fontWithName:@"Arial" size:14]];
            }
            
            label.tag=i;
            label.userInteractionEnabled=YES;
            UITapGestureRecognizer *labelTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedChanged:)];
            [label addGestureRecognizer:labelTap];
            [self addSubview:label];
        }
        
        if (titleArray.count>0) {
            bottomview = [[UIView alloc] init];
            if (self.tabColor) {
                [bottomview setBackgroundColor:self.tabColor];
            }else{
                [bottomview setBackgroundColor:[UIColor whiteColor]];
            }
            bottomview.frame=CGRectMake(self.selectedIndex*ScreenSize.width/titleArray.count+10, self.Margin.y+5+15, ScreenSize.width/titleArray.count-30, 2);
            [self addSubview:bottomview];
        }
    }
}

-(void)selectedChanged:(UITapGestureRecognizer *)sender{
    switch (sender.view.tag) {
        case 0:
            if (self.selectedIndex==0) {
                return;
            }
            break;
        case 1:
            if (self.selectedIndex==1) {
                return;
            }
            break;
        case 2:
            if (self.selectedIndex==2) {
                return;
            }
            break;
        default:
            break;
    }
    
    BOOL returnValue = YES;
    
    if (self.delegate) {
        returnValue = [self.delegate dltabviewSelectedChanged:sender.view.tag label:(UILabel *)sender.view];
    }
    
    if (returnValue) {
        
        self.selectedIndex = sender.view.tag;
        
        [UIView beginAnimations:@"move" context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationDelegate:self];
        //改变它的frame的x,y的值
        bottomview.frame=CGRectMake(self.selectedIndex*ScreenSize.width/titleArray.count+10, self.Margin.y+5+15, ScreenSize.width/titleArray.count-20, 2);
        [UIView commitAnimations];
    }
}

@end
