//
//  FilterUIView.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/29.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "FilterUIView.h"

@implementation FilterUIView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        
        self.backgroundColor=[UIColor whiteColor];
        
        [self initLayout];
        
    }
    return self;
}

-(id)init{
    if (self==[super init]) {
        self.backgroundColor=[UIColor whiteColor];
        [self initLayout];
    }
    return self;
}

-(void)initLayout{
    
    float width = ScreenSize.width * 2 / 3;
    
    UILabel *spendtitle = [[UILabel alloc] initWithFrame:CGRectMake(5, 15, width -10, 20)];
    [spendtitle setStyle:fontsize_13 color:UIColorFromRGB(0xcccccc)];
    spendtitle.textAlignment=NSTextAlignmentLeft;
    [spendtitle setText:@"消费/收入区间"];
    [self addSubview:spendtitle];
    
    UIView *betweenview = [[UIView alloc] initWithFrame:CGRectMake(5, 50, width -10, 40)];
    betweenview.backgroundColor = UIColorFromRGB(0xeeeeee);
    [self addSubview:betweenview];
    
    self.minfield = [[UITextField alloc] initWithFrame:CGRectMake(5, 5, (width -50)/2, 30)];
    self.minfield.placeholder = @"最低";
    self.minfield.textColor=UIColorFromRGB(0x333333);
    self.minfield.keyboardType=UIKeyboardTypeNumberPad;
    self.minfield.backgroundColor = [UIColor whiteColor];
    [betweenview addSubview:self.minfield];
    
    UILabel *middlelabel = [[UILabel alloc] initWithFrame:CGRectMake(width -10 - 5 - (width -50)/2, 5, 30, 30)];
    [middlelabel setStyle:fontsize_14 color:UIColorFromRGB(0xAAAAAA)];
    middlelabel.textAlignment=NSTextAlignmentCenter;
    [middlelabel setText:@"123"];
    [betweenview addSubview:middlelabel];
    
    self.maxfield = [[UITextField alloc] initWithFrame:CGRectMake(width -10 - 5 - (width -50)/2, 5, (width -50)/2, 30)];
    self.maxfield.placeholder = @"最高";
    self.maxfield.textColor=UIColorFromRGB(0x333333);
    self.maxfield.keyboardType=UIKeyboardTypeNumberPad;
    self.maxfield.backgroundColor = [UIColor whiteColor];
    [betweenview addSubview:self.maxfield];
    
    UILabel *categorytitle = [[UILabel alloc] initWithFrame:CGRectMake(5, betweenview.frame.size.height+betweenview.frame.origin.y+10, width -10, 20)];
    [categorytitle setStyle:fontsize_13 color:UIColorFromRGB(0xcccccc)];
    categorytitle.textAlignment=NSTextAlignmentLeft;
    [categorytitle setText:@"消费/收入类型(支持多选)"];
    [self addSubview:categorytitle];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 20;
    //最小两行之间的间距
    layout.minimumLineSpacing = 15;
    
    float top = categorytitle.frame.size.height+categorytitle.frame.origin.y+10;
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(5, top, width -10, ScreenSize.height-top-30) collectionViewLayout:layout];
    _collectionView.backgroundColor=[UIColor clearColor];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.allowsMultipleSelection=YES;
    [_collectionView registerClass:[CategoryViewCell class] forCellWithReuseIdentifier:@"CategoryViewCell"];
    [self addSubview:_collectionView];
    
    
    UIButton *resetbutton = [[UIButton alloc] initWithFrame:CGRectMake(0, ScreenSize.height-40, width/2, 40)];
    resetbutton.backgroundColor = UIColorFromRGB(0xcccccc);
    [resetbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [resetbutton setTitle:@"重置" forState:UIControlStateNormal];
    [self addSubview:resetbutton];
    
    UIButton *savebutton = [[UIButton alloc] initWithFrame:CGRectMake(width/2, ScreenSize.height-40, width/2, 40)];
    savebutton.backgroundColor = get_theme_color;
    [savebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [savebutton setTitle:@"完成" forState:UIControlStateNormal];
    [self addSubview:savebutton];
}

#pragma mark---属性赋值
-(void)setCategorySource:(NSArray *)categorySource{
    
    _categorySource = categorySource;
    [_collectionView reloadData];
    
}

#pragma mark--uicollectionview视图
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _categorySource.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"CategoryViewCell";
    CategoryViewCell *cell = (CategoryViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    //最后一项为添加
    
    CategoryModel *model = [_categorySource objectAtIndex:indexPath.item];
    [cell setAnchorImage:[UIImage imageNamed:[NSString stringWithFormat:@"category_%@",model.CCOLOR]]];
    [cell setLabelText:model.CNAME];
    
    UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
    UIView *bottomview = [[UIView alloc] initWithFrame:CGRectMake(0, cell.bounds.size.height-4, cell.bounds.size.width, 4)];
    bottomview.backgroundColor = get_theme_color;
    [selectedBGView addSubview:bottomview];
    selectedBGView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView = selectedBGView;
    
    return cell;
    
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryViewCell *cell = (CategoryViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell) {
//        self.viewmodel.model.CCOLOR = [NSString stringWithFormat:@"%ld",indexPath.item+1];
    }
}

@end
