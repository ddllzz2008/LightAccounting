//
//  WaterWareView.m
//  ios 动画
//
//  Created by tepusoft on 16/4/22.
//  Copyright © 2016年 tepusoft. All rights reserved.
//

#import "WaterWareView.h"

@interface WaterWareView()

@property (nonatomic, strong) CADisplayLink *waveDisplaylink;
@property (nonatomic, strong) CAShapeLayer *firstWaveLayer;
@property (nonatomic, strong) UIColor *firstWaveColor;

@end

@implementation WaterWareView
{
    CGFloat waveA;//水纹振幅
    CGFloat waveW ;//水纹周期
    CGFloat offsetX; //位移
    CGFloat currentK; //当前波浪高度Y
    CGFloat waveSpeed;//水纹速度
    CGFloat waterWaveWidth; //水纹宽度
}
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor clearColor];
        self.backgroundColor = [UIColor colorWithRed:166/255.0 green:209/255.0 blue:87/255.0 alpha:1];
        self.layer.masksToBounds  = YES;
        [self setUp];
    }
    
    return self;
}


-(void)setUp
{
    //设置波浪的宽度
    waterWaveWidth = self.frame.size.width;
    //设置波浪的颜色
//    _firstWaveColor = [UIColor colorWithRed:166/255.0 green:209/255.0 blue:87/255.0 alpha:1];
    _firstWaveColor = [UIColor whiteColor];
    //设置波浪的速度
    waveSpeed = 0.4/M_PI;
    
    //初始化layer
    if (_firstWaveLayer == nil) {
        //初始化
        _firstWaveLayer = [CAShapeLayer layer];
        //设置闭环的颜色
        _firstWaveLayer.fillColor = _firstWaveColor.CGColor;
        //设置边缘线的颜色
        _firstWaveLayer.strokeColor = [UIColor clearColor].CGColor;
        //设置边缘线的宽度
        _firstWaveLayer.lineWidth = 4.0;
        _firstWaveLayer.strokeStart = 0.0;
        _firstWaveLayer.strokeEnd = 0.8;
        [self.layer addSublayer:_firstWaveLayer];
    }
    
    //设置波浪流动速度
    waveSpeed = 0.1;
    //设置振幅
    waveA = 10;
    //设置周期
    waveW = 1/30.0;
    //设置波浪纵向位置
//    currentK = self.frame.size.height/4;//屏幕居中
    currentK = 100;
    //启动定时器
    _waveDisplaylink = [CADisplayLink displayLinkWithTarget:self selector:@selector(getCurrentWave:)];
    [_waveDisplaylink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)getCurrentWave:(CADisplayLink *)displayLink
{
    //实时的位移
    offsetX += waveSpeed;
    [self setCurrentFirstWaveLayerPath];
}

-(void)setCurrentFirstWaveLayerPath
{
    //创建一个路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGFloat y = currentK;
    //将点移动到 x=0,y=currentK的位置
    CGPathMoveToPoint(path, nil, 0, y);
    for (NSInteger x = 0.0f; x<=waterWaveWidth; x++) {
        //正玄波浪公式
        y = waveA * sin(waveW * x+ offsetX)+currentK;
        //将点连成线
        CGPathAddLineToPoint(path, nil, x, y);
    }
    CGPathAddLineToPoint(path, nil, waterWaveWidth, self.frame.size.height);
    CGPathAddLineToPoint(path, nil, 0, self.frame.size.height);
    CGPathCloseSubpath(path);
    _firstWaveLayer.path = path;
    CGPathRelease(path);
    
    [_waveDisplaylink invalidate];
    _waveDisplaylink = nil;
}

-(void)dealloc
{
    [_waveDisplaylink invalidate];
}

@end
