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


/**
 开始布局
 */
-(void)startlayout{
    
    WaterWareView *waterview = [[WaterWareView alloc] initWithFrame:self.bounds];
    [self addSubview:waterview];
    
    UILabel *currentSpendtitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, self.bounds.size.width/2, 20)];
    [currentSpendtitle setTextColor:UIColorFromRGB(0xffffff)];
    [currentSpendtitle setTextAlignment:NSTextAlignmentCenter];
    [currentSpendtitle setFont:fontsize_16];
    [currentSpendtitle setText:@"本月支出"];
    [self addSubview:currentSpendtitle];
    
    UILabel *currentSpend = [[UILabel alloc] initWithFrame:CGRectMake(0, 35, self.bounds.size.width/2, 30)];
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
    
    UILabel *currentPlan = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2, 35, self.bounds.size.width/2, 30)];
    [currentPlan setTextColor:UIColorFromRGB(0xffffff)];
    [currentPlan setTextAlignment:NSTextAlignmentCenter];
    [currentPlan setFont:fontsize_24];
    [currentPlan setText:@"3098.00"];
    [self addSubview:currentPlan];
    
    [self addscrollview];
    
    UIImageView *addview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [addview setImage:[UIImage imageNamed:@"icon_new"]];
    UITapGestureRecognizer *addaccountTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigateAccount)];
    addview.userInteractionEnabled=YES;
    [addview addGestureRecognizer:addaccountTap];
    [self addSubview:addview];
    [addview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).with.offset(80);
    }];
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
        
        //获取支付类型图标
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"configinfo" ofType:@"plist"];
//        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
//        paytypeDictionry = [dic objectForKey:@"PaytypeIcons"];
        
        
        if (self.source.count>=5) {
            for (int i=0; i<5; i++) {
                [mapsourceArray addObject:[self.source objectAtIndex:i]];
            }
        }else{
            for (int i=0; i<self.source.count; i++) {
                [mapsourceArray addObject:[self.source objectAtIndex:i]];
            }
        }
        
//        double viewheight = (self.frame.size.height/4) * 3;
        
//        double viewspacetop = self.frame.size.height/4;
        
        double viewheight = self.frame.size.height - 100;
        
        double viewspacetop = 100;
        
        double mapwidth = self.frame.size.width-80;
        
        for (int i=0; i<mapsourceArray.count; i++) {
            
            ExpenditureView *view = [[ExpenditureView alloc] init];
//            view.updatePhotoBlock=^(NSString *eid,NSString *photopath){
//                
//                if (self.updatePhotoBlock) {
//                    self.updatePhotoBlock(eid,photopath);
//                }
//                
//                return YES;
//            };
            [self addSubview:view];
            
            if (i==0) {
                
                [view setFrame:CGRectMake(40, viewspacetop + 30, mapwidth, viewheight-40)];
                
            }else{
                
                [view setFrame:CGRectMake(40 + i*mapwidth + i*10, viewspacetop + 50, mapwidth, viewheight - 80)];
                
            }
            MainGroupModel *model = [self.source objectAtIndex:i];
//            model.PAYTYPEICON = [paytypeDictionry objectForKey:[NSString stringWithFormat:@"%d",model.PAYTYPE]];
            
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
        
        mapindex = 0;
        sourceindex = 0;
        
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
        
//        double viewheight = (self.frame.size.height/4) * 3;
//        
//        double viewspacetop = self.frame.size.height/4;
        
        double viewheight = self.frame.size.height - 100;
        
        double viewspacetop = 100;
        
        double mapwidth = self.frame.size.width-80;
        
        if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
            
            if(((UIView *)[mapArray objectAtIndex:(mapArray.count-1)]).frame.size.height == viewheight-40){
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
                    
//                    DDLogDebug(@"当前对象%@",[self.source objectAtIndex:sourceindex]);
                    
                    if(((UIView *)[mapArray objectAtIndex:3]).frame.size.height == viewheight-40){
                        //表示已经滑到了第4块
                        if(self.source.count>sourceindex+2){
                            //删除最前面一块，目的始终保持屏幕上只有5块
//                            [mapsourceArray removeObjectAtIndex:0];
                            //从界面上移除
                            [[mapArray objectAtIndex:0] removeFromSuperview];
                            [mapArray removeObjectAtIndex:0];
                            
                            //取出要添加的对象
                            MainGroupModel *model = [self.source objectAtIndex:sourceindex+2];
//                            model.PAYTYPEICON = [paytypeDictionry objectForKey:[NSString stringWithFormat:@"%d",model.PAYTYPE]];
                            
                            ExpenditureView *view = [[ExpenditureView alloc] init];
                            [self addSubview:view];
                            
                            [view setFrame:CGRectMake(40 + 2*mapwidth + 2*10, viewspacetop + 50, mapwidth, viewheight - 80)];
                            
                            [view setmodel:model];
                            
                            [mapArray addObject:view];
                        }
                    }
                    
                }else{
                    
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
//                for (UIView *view in mapArray) {
                    //判断当前view为中间view
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
                    
                    if(sourceindex-1>0&&sourceindex+3<self.source.count){
                        
                        //删除最前面一块，目的始终保持屏幕上只有5块
//                        [mapsourceArray removeObjectAtIndex:0];
                        //从界面上移除
                        [[mapArray objectAtIndex:(mapArray.count-1)] removeFromSuperview];
                        [mapArray removeObjectAtIndex:(mapArray.count-1)];
                        
                        //取出要添加的对象
                        MainGroupModel *model = [self.source objectAtIndex:sourceindex-2];
//                        model.PAYTYPEICON = [paytypeDictionry objectForKey:[NSString stringWithFormat:@"%d",model.PAYTYPE]];
                        
                        ExpenditureView *view = [[ExpenditureView alloc] init];
                        [self addSubview:view];
                        
                        [view setFrame:CGRectMake(0-2*mapwidth + 20, viewspacetop + 50, mapwidth, viewheight - 80)];
                        
                        [view setmodel:model];
                        
                        [mapArray insertObject:view atIndex:0];
                        
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

@end
