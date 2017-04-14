//
//  BillCollectionView.m
//  LightAccounting
//
//  Created by ddllzz on 17/4/11.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BillCollectionView.h"

@implementation BillCollectionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
    }
    return self;
}

-(id)init{
    if (self==[super init]) {
        self.backgroundColor=[UIColor whiteColor];
    }
    return self;
}

-(void)initlayout{
    
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10;
    
}

@end
