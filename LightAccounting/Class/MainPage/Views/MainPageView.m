//
//  MainPageView.m
//  LightAccounting
//
//  Created by ddllzz on 17/3/19.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "MainPageView.h"

@implementation MainPageView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor whiteColor];
        mapsourceArray = [[NSMutableArray alloc] initWithCapacity:5];
        mapArray = [[NSMutableArray alloc] initWithCapacity:5];
    }
    return self;
}

-(id)init{
    if (self==[super init]) {
        self.backgroundColor=[UIColor whiteColor];
        mapsourceArray = [[NSMutableArray alloc] initWithCapacity:5];
        mapArray = [[NSMutableArray alloc] initWithCapacity:5];
    }
    return self;
}

-(void)setCurrentExpend:(CGFloat)currentExpend{
    
    _currentExpend = currentExpend;
    [currentSpend setText:[NSString stringWithFormat:@"%.1f",currentExpend]];
    
}

-(void)setCurrentBudget:(CGFloat)currentBudget{
    
    _currentBudget = currentBudget;
    [currentPlan setText:[NSString stringWithFormat:@"%.1f",currentBudget]];
}

/**
 刷新主题
 */
-(void)refreshTheme{
    waterview.backgroundColor = get_theme_color;
}
/**
 开始布局
 */
-(void)startlayout{
    
    waterview = [[WaterWareView alloc] initWithFrame:self.bounds];
    [self addSubview:waterview];
    
    UILabel *currentSpendtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, self.bounds.size.width/2, 20)];
    [currentSpendtitle setTextColor:UIColorFromRGB(0xffffff)];
    [currentSpendtitle setTextAlignment:NSTextAlignmentCenter];
    [currentSpendtitle setFont:fontsize_16];
    [currentSpendtitle setText:@"本月支出"];
    [self addSubview:currentSpendtitle];
    
    currentSpend = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, self.bounds.size.width/2, 30)];
    [currentSpend setTextColor:UIColorFromRGB(0xffffff)];
    [currentSpend setTextAlignment:NSTextAlignmentCenter];
    [currentSpend setFont:fontsize_24];
    [currentSpend setText:@"3098.00"];
    [self addSubview:currentSpend];
    
    UILabel *currentPlantitle = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2, 15, self.bounds.size.width/2, 20)];
    [currentPlantitle setTextColor:UIColorFromRGB(0xffffff)];
    [currentPlantitle setTextAlignment:NSTextAlignmentCenter];
    [currentPlantitle setFont:fontsize_16];
    [currentPlantitle setText:@"本月预算"];
    [self addSubview:currentPlantitle];
    
    currentPlan = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2, 35, self.bounds.size.width/2, 30)];
    [currentPlan setTextColor:UIColorFromRGB(0xffffff)];
    [currentPlan setTextAlignment:NSTextAlignmentCenter];
    [currentPlan setFont:fontsize_24];
    [currentPlan setText:@"3098.00"];
    [self addSubview:currentPlan];
    
//    [self addscrollview];
}

-(void)loadData{
    
    for (UIView *subview in self.subviews) {
        if ([subview isKindOfClass:[ExpenditureView class]]) {
            [subview removeFromSuperview];
        }
    }
    
    mapsourceArray = [[NSMutableArray alloc] initWithCapacity:5];
    mapArray = [[NSMutableArray alloc] initWithCapacity:5];
    
    [self addscrollview];
    
}

#pragma mark--回调方法
-(void)navigateAccount{
    if (self.addnewAccount) {
        self.addnewAccount();
    }
}

/**
 没有数据时的布局
 */
-(void)nodatalayout{
    UIImageView *imgview = [[UIImageView alloc] initWithFrame:self.bounds];
    [imgview setImage:[UIImage imageNamed:@"icon_nodata"]];
    [imgview setContentMode:UIViewContentModeCenter];
    [self addSubview:imgview];
}

#pragma mark--私有方法
-(void)addscrollview{
    if (self.source!=nil&&self.source.count>0) {
        
        //计算一个与当天日期最接近的开始
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"dateDiff" ascending:YES];
        NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:&sortDescriptor count:1];
        NSArray *temparray = [self.source sortedArrayUsingDescriptors:sortDescriptors];
        MainGroupModel *model = [temparray objectAtIndex:0];
        
        long minindex = 0;
        long maxindex = 0;
        
        if (self.source.count>=5) {
            
            if (model.currentIndex+2>=self.source.count) {
                //到最右边了
                maxindex = self.source.count-1;
                minindex = self.source.count-1-4;
            }else if(model.currentIndex-2<=0){
                minindex = 0;
                maxindex = 5;
            }else{
                minindex = model.currentIndex - 2;
                maxindex = model.currentIndex + 2;
            }
            
//            minindex = model.currentIndex - 2 >=0 ? (model.currentIndex - 2): 0;
//            
//            maxindex = minindex + 4 >= self.source.count ? (self.source.count - 1): (minindex + 4);
            
//            if (model.currentIndex>0) {
//                
//                
//                
//                //中间位置
//                if (model.currentIndex>=2) {
//                    //左边还有两个
//                    minindex = model.currentIndex - 2;
//                    maxindex = model.currentIndex + 2;
//                }else{
//                    //左边只有1个
//                    minindex = model.currentIndex - 1;
//                    maxindex = model.currentIndex + 3;
//                }
//            }else{
//                //左边没有
//                minindex = 0;
//                
//                if (model.currentIndex+5>self.source.count) {
//                    maxindex = self.source.count;
//                }else{
//                    maxindex = model.currentIndex+5;
//                }
//                
//            }
            
            sourceindex = model.currentIndex;
            
            for (long i=minindex; i<=maxindex; i++) {
                if (i<self.source.count) {
                    [mapsourceArray addObject:[self.source objectAtIndex:i]];
                }
            }
        }else{
            
            minindex = 0;
            maxindex = self.source.count - 1;
            
//            if (model.currentIndex>0) {
//                //中间位置
//                if (model.currentIndex>=2) {
//                    //左边还有两个
//                    minindex = model.currentIndex - 2;
//                    maxindex = model.currentIndex + 2;
//                }else{
//                    //左边只有1个
//                    minindex = model.currentIndex - 1;
//                    maxindex = model.currentIndex + 3;
//                }
//            }else{
//                //左边没有
//                minindex = 0;
//                
//                if (model.currentIndex+5>self.source.count) {
//                    maxindex = self.source.count;
//                }else{
//                    maxindex = model.currentIndex+5;
//                }
//                
//            }
            
            sourceindex = model.currentIndex;
            
            for (long i=minindex; i<=maxindex; i++) {
                if (i<self.source.count) {
                    [mapsourceArray addObject:[self.source objectAtIndex:i]];
                }
            }
        }
        
        double viewheight = self.frame.size.height - 100;
        
        double viewspacetop = 100;
        
        double mapwidth = self.frame.size.width-80;
        
        for (int i=0; i<mapsourceArray.count; i++) {
            
            ExpenditureView *view = [[ExpenditureView alloc] init];
            UITapGestureRecognizer *detailtap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navdetail:)];
            [view addGestureRecognizer:detailtap];

            [self addSubview:view];
            
            MainGroupModel *model = [self.source objectAtIndex:[[mapsourceArray objectAtIndex:i] currentIndex]];
            
            if (model.currentIndex==sourceindex) {
                mapindex = i;
                //当前正中间的画面
                [view setFrame:CGRectMake(40, viewspacetop + 30, mapwidth, viewheight-40)];
            }else{
                if (model.currentIndex<sourceindex) {
                    long diff = sourceindex - model.currentIndex;
                    [view setFrame:CGRectMake(0 - ((mapwidth*diff) + (diff-1)*10 - 30), viewspacetop + 50, mapwidth, viewheight - 80)];
                }else{
                    long diff = model.currentIndex - sourceindex;
                    [view setFrame:CGRectMake(40 + diff*mapwidth + diff*10, viewspacetop + 50, mapwidth, viewheight - 80)];
                }
            }
            
//            if (i==0) {
//                
//                [view setFrame:CGRectMake(40, viewspacetop + 30, mapwidth, viewheight-40)];
//                
//            }else{
//                
//                [view setFrame:CGRectMake(40 + i*mapwidth + i*10, viewspacetop + 50, mapwidth, viewheight - 80)];
//                
//            }
            
            [view setmodel:model];
            
            [mapArray addObject:view];
        }
        
        if(self.source.count>1){
            swipeleft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(mapviewmove:)];
            [swipeleft setDirection:UISwipeGestureRecognizerDirectionLeft];
            [self addGestureRecognizer:swipeleft];
            
            swiperight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(mapviewmove:)];
            [swiperight setDirection:UISwipeGestureRecognizerDirectionRight];
            [self addGestureRecognizer:swiperight];
        }
        
        
//        sourceindex = 0;
        
    }else{
        [self nodatalayout];
    }
}

-(void)createdetail:(BusExpenditure *)model{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.layer.cornerRadius = 10;
    view.clipsToBounds=YES;
    view.layer.borderWidth=1.0f;
    view.layer.borderColor=UIColorFromRGB(0xcccccc).CGColor;
    [view setBackgroundColor:[UIColor redColor]];
    [self addSubview:view];
}

#pragma mark--手势特效
-(void)mapviewmove:(UISwipeGestureRecognizer*)recognizer{
    @try {
        
        double viewheight = self.frame.size.height - 100;
        
        double viewspacetop = 100;
        
        double mapwidth = self.frame.size.width-80;
        
        if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
            
            if (sourceindex+1>=self.source.count) {
                return;
            }
            
            [UIView animateWithDuration:0.5 animations:^{
                
                bool current = NO;
                for (UIView *view in mapArray) {
                    //判断当前view为中间view
                    if(view.bounds.size.height == viewheight-40){
                        
                        view.frame = CGRectMake(view.frame.origin.x - mapwidth - 10, viewspacetop + 50, mapwidth, viewheight - 80);
                        
                        current = YES;
                    }else{
                        if(current){
                            view.frame = CGRectMake(40, viewspacetop + 30, mapwidth, viewheight-40);
                            current = NO;
                        }else{
                            view.frame = CGRectMake(view.frame.origin.x - mapwidth - 10, viewspacetop + 50, mapwidth, viewheight - 80);
                        }
                    }
                }
                
            } completion:^(BOOL finished) {
                
                sourceindex++;
                if(self.source.count>5){
                    //第一步判断当前索引是倒数第一个还是最后一个
                    if (sourceindex ==self.source.count-2 || sourceindex == self.source.count-1) {
                        //无需做任何事情
                    }else{
                        //如果sourceindex>2就开始删除第一个，添加最后一个
                        if (sourceindex>2) {
                            //移除第一个
                            //从界面上移除
                            [[mapArray objectAtIndex:0] removeFromSuperview];
                            [mapArray removeObjectAtIndex:0];
                            
                            //取出要添加的对象
                            MainGroupModel *model = [self.source objectAtIndex:sourceindex+2];
                            
                            ExpenditureView *view = [[ExpenditureView alloc] init];
                            [self addSubview:view];
                            
                            [view setFrame:CGRectMake(40 + 2*mapwidth + 2*10, viewspacetop + 50, mapwidth, viewheight - 80)];
                            
                            [view setmodel:model];
                            
                            [mapArray addObject:view];
                        }
                    }
                }
                
            }];
            
            
        }else if (recognizer.direction==UISwipeGestureRecognizerDirectionRight){
            
            if(sourceindex==0){
                return;
            }
            
            [UIView animateWithDuration:0.5 animations:^{
                bool current = NO;
                UIView *view;
                for(long i=mapArray.count-1;i>=0;i--){

                    view = [mapArray objectAtIndex:i];

                    if(view.bounds.size.height == viewheight-40){
                        current = YES;
                        
                        view.frame = CGRectMake(view.frame.origin.x + mapwidth + 10, viewspacetop + 50, mapwidth, viewheight - 80);
                    }else{
                        if(current){
                            view.frame = CGRectMake(40, viewspacetop + 30, mapwidth, viewheight-40);
                            current = NO;
                        }else{
                            view.frame = CGRectMake(view.frame.origin.x + mapwidth + 10, viewspacetop + 50, mapwidth, viewheight - 80);
                        }
                    }
                    
                }
                
            } completion:^(BOOL finished) {
                
                sourceindex --;
                
                if(self.source.count>5){
                    
                    //第一步判断是否为第一个或者第二个
                    if (sourceindex==0 || sourceindex ==1) {
                        //无需做任何事情
                    }else{
                        if (sourceindex<self.source.count-3) {
                            //删除最后边一块
                            //从界面上移除
                            [[mapArray objectAtIndex:(mapArray.count-1)] removeFromSuperview];
                            [mapArray removeObjectAtIndex:(mapArray.count-1)];
                            
                            //最左边添加一块
                            //取出要添加的对象
                            MainGroupModel *model = [self.source objectAtIndex:sourceindex-2];
                            
                            ExpenditureView *view = [[ExpenditureView alloc] init];
                            [self addSubview:view];
                            
                            [view setFrame:CGRectMake(0-2*mapwidth + 20, viewspacetop + 50, mapwidth, viewheight - 80)];
                            
                            [view setmodel:model];
                            
                            [mapArray insertObject:view atIndex:0];
                        }
                    }
                    
                }else {
                    
                }
                
            }];
            
        }
    } @catch (NSException *exception) {
        DDLogError(@"首页移动手势错误，错误详情：%@",exception);
    } @finally {
        
    }
}

-(void)navdetail:(id)sender{
    
    BillDetailPageController *billdetailcontroller = [[BillDetailPageController alloc] init];
    billdetailcontroller.currentDate = [NSDate dateWithZone];
    [[self viewController].navigationController pushViewController:billdetailcontroller animated:YES];
    
}

@end
