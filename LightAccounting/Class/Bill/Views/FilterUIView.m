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
    
    float width = ScreenSize.width;
    
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
    
    cboutlet = [[SSCheckBoxView alloc] initWithFrame:CGRectMake(5, betweenview.frame.size.height+betweenview.frame.origin.y+10, width -10, 30) style:kSSCheckBoxViewStyleMono checked:YES];
    [cboutlet setText:@"显示额外消费"];
    [cboutlet.textLabel setStyle:fontsize_13 color:UIColorFromRGB(0x888888)];
    [cboutlet setStateChangedTarget:self selector:@selector(outletChanged:)];
    [self addSubview:cboutlet];
    
    cbprivate = [[SSCheckBoxView alloc] initWithFrame:CGRectMake(5, cboutlet.frame.size.height+cboutlet.frame.origin.y+10, width -10, 30) style:kSSCheckBoxViewStyleMono checked:YES];
    [cbprivate setText:@"显示隐私消费"];
    [cbprivate.textLabel setStyle:fontsize_13 color:UIColorFromRGB(0x888888)];
    [cbprivate setStateChangedTarget:self selector:@selector(privateChanged:)];
    [self addSubview:cbprivate];
    
    UILabel *categorytitle = [[UILabel alloc] initWithFrame:CGRectMake(5, cbprivate.frame.size.height+cbprivate.frame.origin.y+10, width -10, 20)];
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
    
    _collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(5, top, width -10, ScreenSize.height-top-45) collectionViewLayout:layout];
    _collectionView.backgroundColor=[UIColor clearColor];
    _collectionView.delegate=self;
    _collectionView.dataSource=self;
    _collectionView.showsVerticalScrollIndicator = YES;
    _collectionView.allowsMultipleSelection=YES;
    [_collectionView registerClass:[CategoryViewCell class] forCellWithReuseIdentifier:@"CategoryViewCell"];
    [self addSubview:_collectionView];
    
    
    UIButton *resetbutton = [[UIButton alloc] initWithFrame:CGRectMake(1, ScreenSize.height-40, (width-1)/2, 40)];
    resetbutton.backgroundColor = UIColorFromRGB(0xcccccc);
    [resetbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [resetbutton setTitle:@"重置" forState:UIControlStateNormal];
    [resetbutton addTarget:self action:@selector(revert:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:resetbutton];
    
    UIButton *savebutton = [[UIButton alloc] initWithFrame:CGRectMake(width/2+1, ScreenSize.height-40, (width-1)/2, 40)];
    savebutton.backgroundColor = get_theme_color;
    [savebutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [savebutton setTitle:@"完成" forState:UIControlStateNormal];
    [savebutton addTarget:self action:@selector(comfirm:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:savebutton];
}

#pragma mark---属性赋值
-(void)setCategorySource:(NSArray *)categorySource{
    
    _categorySource = categorySource;
    [_collectionView reloadData];
    
}

-(void)setCategories:(NSArray *)array{
    
    if (categoryArray==nil) {
        categoryArray = [[NSMutableArray alloc] init];
    }else{
        [categoryArray removeAllObjects];
    }
    
    [categoryArray addObjectsFromArray:array];
    
    if (array.count>0) {
        for (NSString *cid in array) {
            for (NSInteger i=0; i<_categorySource.count; i++) {
                if ([((CategoryModel *)[_categorySource objectAtIndex:i]).CID isEqualToString:cid]) {
                    
                    [_collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionNone];
                    break;
                }
            }
            
        }
    }
    
    
    
    
}

-(void)setMinValue:(NSString *)minvalue{
    [_minfield setText:minvalue];
}

-(void)setMaxValue:(NSString *)maxvalue{
    [_maxfield setText:maxvalue];
}

-(void)setOutlet:(BOOL)isoutlet{
    cboutlet.checked=isoutlet;
}
-(void)setPrivate:(BOOL)isprivate{
    cbprivate.checked=isprivate;
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
    
//    if ([categoryArray containsObject:model.CID]) {
//        [cell setSelected:YES];
//    }else{
//        [cell setSelected:NO];
//    }
    
    return cell;
    
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(50, 50);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryModel *model = [_categorySource objectAtIndex:indexPath.item];
    if (model) {
        if (categoryArray==nil) {
            categoryArray = [[NSMutableArray alloc] init];
        }
        if (![categoryArray containsObject:model.CID]) {
            [categoryArray addObject:model.CID];
        }
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    CategoryModel *model = [_categorySource objectAtIndex:indexPath.item];
    if (model) {
        if (categoryArray==nil) {
            categoryArray = [[NSMutableArray alloc] init];
        }
        if ([categoryArray containsObject:model.CID]) {
            [categoryArray removeObject:model.CID];
        }
    }
}

#pragma mark---outlet changed
-(void)outletChanged:(SSCheckBoxView *)sender{
    
}
#pragma mark---private changed
-(void)privateChanged:(SSCheckBoxView *)sender{
    
}

#pragma mark---button operate
-(void)revert:(UIButton *)button{
    if (categoryArray==nil) {
        categoryArray = [[NSMutableArray alloc] init];
    }
    [categoryArray removeAllObjects];
    [self.minfield setText:@""];
    [self.maxfield setText:@""];
    cboutlet.checked=NO;
    cbprivate.checked=NO;
    if (self.delegate) {
        [self.delegate FilterUIViewComfirm:@"" max:@"" categories:categoryArray isoutlet:NO isprivate:NO];
    }
}
-(void)comfirm:(UIButton *)button{
    if (self.delegate) {
        NSString *min = [self.minfield.text isFloat]?self.minfield.text:@"";
        NSString *max = [self.maxfield.text isFloat]?self.minfield.text:@"";
        [self.delegate FilterUIViewComfirm:min max:max categories:categoryArray isoutlet:cboutlet.checked isprivate:cbprivate.checked];
    }
}

-(void)drawRect:(CGRect)rect{
    
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx,1);

    [UIColorFromRGB(0xAAAAAA) setStroke];
    
    CGPoint aPoints[2];//坐标点
    aPoints[0] =CGPointMake(0, 0);//坐标1
    aPoints[1] =CGPointMake(0, rect.size.height);

    CGContextAddLines(ctx, aPoints, 2);//添加线
    CGContextDrawPath(ctx, kCGPathStroke); //根据坐标绘制路径
    
}

@end
