//
//  CategoryChooseView.m
//  LightAccounting
//
//  Created by ddllzz on 17/3/29.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "CategoryChooseView.h"

@implementation CategoryChooseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setFrame:frame];
    }
    return self;
}

-(id)init{
    if (self==[super init]) {
        [self setBackgroundColor:[UIColor clearColor]];
    }
    return self;
}

-(id)initwithTagView:(__weak UIImageView *)imgTap{
    if (self==[super initWithFrame:CGRectZero]) {
        imgView = imgTap;
        [self setBackgroundColor:[UIColor clearColor]];
        
        UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
        //同一行相邻两个cell的最小间距
        layout.minimumInteritemSpacing = 20;
        //最小两行之间的间距
        layout.minimumLineSpacing = 15;
        
        _collectionView=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor=[UIColor clearColor];
        _collectionView.delegate=self;
        _collectionView.dataSource=self;
        
        [self addSubview:_collectionView];
    }
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    if(backgroundview==nil){
        backgroundview = [[UIView alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 10, frame.size.height)];
        backgroundview.layer.cornerRadius = 5;
        [backgroundview setBackgroundColor:UIColorFromRGB(0xFAFAFA)];
        backgroundview.clipsToBounds=YES;
        [self addSubview:backgroundview];
    }else{

    }
}

-(void)setSource:(NSMutableArray *)source{
    _source = source;
    
    [_collectionView reloadData];
}

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    if(backgroundview==nil){
        backgroundview = [[UIView alloc] initWithFrame:CGRectMake(15, 0, rect.size.width - 15, rect.size.height)];
        backgroundview.layer.cornerRadius = 5;
        [backgroundview setBackgroundColor:UIColorFromRGB(0xFAFAFA)];
        backgroundview.clipsToBounds=YES;
        [self addSubview:backgroundview];
    }
    else if(backgroundview!=nil){
        [backgroundview setFrame:CGRectMake(15, 0, rect.size.width - 15, rect.size.height)];
    }
    
    if (_collectionView!=nil) {
        [_collectionView setFrame:CGRectMake(35, 20,rect.size.width - 55, rect.size.height - 40)];
        [_collectionView registerClass:[CategoryViewCell class] forCellWithReuseIdentifier:@"CategoryViewCell"];
    }
    
    double y = rect.size.height - 50 -30;
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, 0, y);
    CGContextAddLineToPoint(ctx, 15, y - 20);
    CGContextAddLineToPoint(ctx, 15, y - 5);
    CGContextClosePath(ctx);
    
    [UIColorFromRGB(0xFAFAFA) setFill];
    CGContextDrawPath(ctx, kCGPathFill);
    
    //缩放变化
//    [self performSelector:@selector(startAnimation) withObject:nil afterDelay:0.2];
    
    CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue =  [NSNumber numberWithFloat:0.0f];
    scaleAnimation.toValue =  [NSNumber numberWithFloat:1.0f];
    scaleAnimation.removedOnCompletion = NO;
    scaleAnimation.duration = 0.2;
    [self.layer addAnimation:scaleAnimation forKey:@"scaleAnimation"];
}

#pragma mark--uicollectionview视图
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.source.count +1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"CategoryViewCell";
    CategoryViewCell *cell = (CategoryViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    if (indexPath.item==self.source.count) {
        //最后一项为添加
        [cell setAnchorImage:[UIImage imageNamed:@"category_add"]];
        [cell setLabelText:@"添加"];
    }else{
        //正常项为实际项
        CategoryModel *model = [self.source objectAtIndex:indexPath.item];
        [cell setAnchorImage:[UIImage imageNamed:[NSString stringWithFormat:@"category_%@",model.CCOLOR]]];
        [cell setLabelText:model.CNAME];
    }
    return cell;
    
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(60, 50);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryViewCell *cell = (CategoryViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell) {
        
        if (indexPath.item==self.source.count) {
            [self.delegate categorychooseView:nil category:nil];
        }else{
            if (chooseCell!=nil) {
                [chooseCell setLabelColor:UIColorFromRGB(0xcccccc)];
            }
            
            chooseCell = cell;
            [cell setLabelColor:UIColorFromRGB(0xA6D157)];
            CategoryModel *model = [self.source objectAtIndex:indexPath.item];
            if (self.delegate) {
                [self.delegate categorychooseView:cell.anchorImage category:model];
            }
        }
        
    }
}

@end
