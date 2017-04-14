//
//  DLPickerView.m
//  DLZProject
//
//  Created by ddllzz on 16/12/28.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "DLPickerView.h"

static const float kButtonHeight = 40.0f;
static const float kContentHeight = 180.0f;

@implementation DLPickerView

+(id)sharedInstance{
    static DLPickerView *sharedAlert = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAlert = [[self alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    });
    return sharedAlert;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (picker==nil) {
        CGRect contentFrame = CGRectMake(0, ScreenSize.height-kContentHeight, ScreenSize.width, kContentHeight);
        
        UIView *hiddenview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, ScreenSize.height-kContentHeight)];
        hiddenview.backgroundColor=[UIColor grayColor];
        hiddenview.alpha=0.3;
        [self addSubview:hiddenview];
        
        backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenSize.height, ScreenSize.width, kContentHeight)];
        picker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kButtonHeight, contentFrame.size.width, contentFrame.size.height - kButtonHeight)];
        picker.delegate=self;
        picker.dataSource=self;
        [backgroundView setBackgroundColor:[UIColor whiteColor]];
        [backgroundView addSubview:picker];
        
        UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentFrame.size.width, kButtonHeight)];
        headerview.backgroundColor=[UIColor whiteColor];
        
        UIButton *cancelbutton = [[UIButton alloc] initWithFrame:CGRectMake(12, 7.5, 70, 25)];
        UIButton *confirmbutton = [[UIButton alloc] initWithFrame:CGRectMake(contentFrame.size.width-70-12, 7.5, 70, 25)];
        [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelbutton setBackgroundColor:UIColorFromRGB(color_theme_green)];
        [cancelbutton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [headerview addSubview:cancelbutton];
        
        [confirmbutton setTitle:@"确定" forState:UIControlStateNormal];
        [confirmbutton setBackgroundColor:UIColorFromRGB(color_theme_green)];
        [confirmbutton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        [headerview addSubview:confirmbutton];
        [backgroundView addSubview:headerview];
        
        [self addSubview:backgroundView];
        
    }
    return self;
}

-(void)setItemSource:(NSArray *)itemSource{
    
    if (_itemSource!=nil) {
        for (int i=0; i<_itemSource.count; i++) {
            
            [picker selectRow:0 inComponent:i animated:YES];
            
        }
    }
    
    _itemSource = nil;
    
    _itemSource = itemSource;
    
    selectedArray = [[NSMutableArray alloc] init];
    
    for (NSArray *arr in itemSource) {
        [selectedArray addObject:[arr objectAtIndex:0]];
    }
    
    [picker reloadAllComponents];
}

-(void)show{
    
    self.windowLevel=UIWindowLevelAlert+1000;
    self.backgroundColor=[UIColor clearColor];
    self.alpha = 1;
    self.hidden = NO;
    
    [UIView beginAnimations:@"move" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    //改变它的frame的x,y的值
    backgroundView.frame=CGRectMake(0, ScreenSize.height-kContentHeight, ScreenSize.width, kContentHeight);
    [UIView commitAnimations];
}

-(void)confirm{
    
    if (self.delegate) {
        [self.delegate DLPickerView:self.tag didSelectObject:selectedArray];
    }
    [self close];
}

-(void)close{
    self.hidden=YES;
    
    backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenSize.height, ScreenSize.width, kContentHeight)];
}

#pragma mark---UIPickerView协议
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.itemSource!=nil) {
        return self.itemSource.count;
    }
    return 0;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.itemSource!=nil) {
        NSArray *array = [self.itemSource objectAtIndex:component];
        if (array) {
            return  array.count;
        }
    }
    return 0;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (self.itemSource) {
        NSArray *array = [self.itemSource objectAtIndex:component];
        if (array) {
            if (selectedArray!=nil) {
                [selectedArray replaceObjectAtIndex:component withObject:[array objectAtIndex:row]];
            }
        }
    }
}
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (self.itemSource!=nil) {
        NSArray *array = [self.itemSource objectAtIndex:component];
        if (array) {
            return  [NSString stringWithFormat:@"%@",[array objectAtIndex:row]];
        }
    }
    return @"";
}

@end
