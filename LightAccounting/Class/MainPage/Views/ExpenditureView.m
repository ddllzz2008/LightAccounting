//
//  ExpenditureView.m
//  LightAccounting
//
//  Created by ddllzz on 17/3/21.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "ExpenditureView.h"

#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@implementation ExpenditureView

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

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    
    if(backgroundview==nil){
        backgroundview = [[UIView alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, frame.size.height-10)];
//        backgroundview.alpha=1f;
        backgroundview.layer.cornerRadius = 10;
        backgroundview.clipsToBounds=YES;

        [self addSubview:backgroundview];
        
        //初始化CAGradientlayer对象，使它的大小为UIView的大小
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.frame = backgroundview.bounds;
        
        //将CAGradientlayer对象添加在我们要设置背景色的视图的layer层
        [backgroundview.layer addSublayer:gradientLayer];
        
        //设置渐变区域的起始和终止位置（范围为0-1）
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        
        //设置颜色数组
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:166/255.0 green:209/255.0 blue:87/255.0 alpha:1].CGColor,
                                 (__bridge id)[UIColor colorWithRed:132/255.0 green:214/255.0 blue:77/255.0 alpha:1].CGColor];
        //设置颜色分割点（范围：0-1）
        gradientLayer.locations = @[@(0.6f),@(1)];
    }else{
        [backgroundview setFrame:CGRectMake(0, 10, frame.size.width, frame.size.height-10)];
        CAGradientLayer *gradientLayer = (CAGradientLayer*)[[backgroundview.layer sublayers] objectAtIndex:0];
        gradientLayer.frame = backgroundview.bounds;
        
        //设置渐变区域的起始和终止位置（范围为0-1）
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(0, 1);
        
        //设置颜色数组
        gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:166/255.0 green:209/255.0 blue:87/255.0 alpha:1].CGColor,
                                 (__bridge id)[UIColor colorWithRed:132/255.0 green:214/255.0 blue:77/255.0 alpha:1].CGColor];
        //设置颜色分割点（范围：0-1）
        gradientLayer.locations = @[@(0.6f),@(1)];
    }
    
//    if(mapView!=nil){
//        [mapView setFrame:CGRectMake(10, 75, self.frame.size.width-20, self.frame.size.height - 75 - 40)];
//    }
//    if(imageviewArray!=nil&&imageviewArray.count>0){
//        for (UIImageView *imgview in imageviewArray) {
//            [imgview setFrame:CGRectMake(10, 75, self.frame.size.width-20, self.frame.size.height - 75 - 40)];
//        }
//    }
    if(ulmark!=nil){
        [ulmark setFrame:CGRectMake(10, self.frame.size.height -40, self.frame.size.width-20, 30)];
    }
//    if (backgroundview!=nil) {
//        [backgroundview setFrame:CGRectMake(0, 10, frame.size.width, frame.size.height-10)];
//    }
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGContextRef ctx=UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ctx, rect.size.width/2, 0);
    CGContextAddLineToPoint(ctx, rect.size.width/2-8, 10);
    CGContextAddLineToPoint(ctx, rect.size.width/2+8, 10);
    CGContextClosePath(ctx);
    
    [[UIColor colorWithRed:166/255.0 green:209/255.0 blue:87/255.0 alpha:1] setFill];
    CGContextDrawPath(ctx, kCGPathFill);
}

-(void)setmodel:(MainGroupModel *)model{
    
//    currentmodel = model;
    
    if (model!=nil) {
        
        UILabel *ulcategory = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-10, 10, self.bounds.size.width/2, 30)];
        [ulcategory setTextColor:UIColorFromRGB(0xffffff)];
        [ulcategory setTextAlignment:NSTextAlignmentRight];
        [ulcategory setFont:fontsize_16];
//        [ulcategory setText:model.CNAME];
        [ulcategory setText:@"合计"];
        
        [self addSubview:ulcategory];
        
        UILabel *uldate = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, (self.bounds.size.width/2)-10, 30)];
        [uldate setTextColor:UIColorFromRGB(0xffffff)];
        [uldate setTextAlignment:NSTextAlignmentLeft];
        [uldate setFont:fontsize_16];
        [uldate setText:model.groupDate];
        
        [self addSubview:uldate];
        
        UILabel *ulnumric = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width/2-10, 40, self.bounds.size.width/2, 32)];
        [ulnumric setTextColor:UIColorFromRGB(0xffffff)];
        [ulnumric setTextAlignment:NSTextAlignmentRight];
        [ulnumric setFont:fontsize_24];
        [ulnumric setText:[NSString stringWithFormat:@"%.1f",model.groupExpend]];
        
        [self addSubview:ulnumric];
        
        MainExpendModel *submodel;
        
        for (int i=0; i<model.groupSource.count; i++) {
            
            submodel = (MainExpendModel *)[model.groupSource objectAtIndex:i];
            
            UIImageView *image1 = [[UIImageView alloc] initWithFrame:CGRectMake(10, 90, 40, 40)];
            [image1 setImage:[UIImage imageNamed:[NSString stringWithFormat:@"category_%@",submodel.CCOLOR]]];
            [self addSubview:image1];
            
            UILabel *labelcategory1 = [[UILabel alloc] initWithFrame:CGRectMake(60, 90, self.bounds.size.width-60, 40)];
            [labelcategory1 setTextColor:UIColorFromRGB(0xffffff)];
            [labelcategory1 setTextAlignment:NSTextAlignmentLeft];
            [labelcategory1 setFont:fontsize_16];
            [labelcategory1 setText:[NSString stringWithFormat:@"%@: %.1f",submodel.CNAME,submodel.EVALUE]];
            [self addSubview:labelcategory1];
            
            @weakify(self);
            [image1 mas_makeConstraints:^(MASConstraintMaker *make) {
                @strongify(self);
                make.bottom.equalTo(self.mas_bottom).with.offset(-20 -40*i - 10*i);
                make.left.equalTo(self.mas_left).with.offset(10);
            }];
            
            [labelcategory1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(image1);
                make.left.equalTo(image1.mas_right).with.offset(10);
            }];
        }
        
        
        
        
        //添加地图
//        if([CommonFunc isBlankString:model.PHOTO1]){
//            UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 75, self.bounds.size.width-20, self.bounds.size.height - 75 - 50)];
//            [imgview setImage:[UIImage imageNamed:@"icon_photo"]];
//            [imgview setContentMode:UIViewContentModeCenter];
//            [self addSubview:imgview];
//            [imgview stringTag:model.EID];
//            imageviewArray = [NSArray arrayWithObjects:imgview, nil];
//            
//            UITapGestureRecognizer *choosePhotoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePhotoAction:)];
//            imgview.userInteractionEnabled=YES;
//            [imgview addGestureRecognizer:choosePhotoTap];
//            
//        }else{
//            
//            NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
//            NSString *photopath = [libraryPath stringByAppendingString:[NSString stringWithFormat:@"/%@",model.PHOTO1]];
//            
//            UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 75, self.bounds.size.width-20, self.bounds.size.height - 75 - 50)];
//            [imgview setImage:[UIImage imageWithContentsOfFile:photopath]];
//            [imgview setContentMode:UIViewContentModeScaleToFill];
//            imgview.layer.cornerRadius = 10;
//            imgview.clipsToBounds=YES;
//            [self addSubview:imgview];
//            imageviewArray = [NSArray arrayWithObjects:imgview, nil];
//        }
        
//        ulmark = [[UILabel alloc] initWithFrame:CGRectMake(10, self.bounds.size.height -50, self.bounds.size.width-20, 30)];
//        [ulmark setTextColor:UIColorFromRGB(0xffffff)];
//        [ulmark setTextAlignment:NSTextAlignmentLeft];
//        [ulmark setFont:fontsize_16];
//        [ulmark setText:model.IMARK];
//        
//        [self addSubview:ulmark];
        //    @weakify(self);
        //    [mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        @strongify(self);
        //        make.width.equalTo(self).with.offset(-20);
        //        make.bottom.equalTo(self.mas_bottom).with.offset(40);
        //        make.top.equalTo(imgtype.mas_bottom).with.offset(5);
        //    }];
        
    }else{
        //暂无数据
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:self.bounds];
        [imgview setImage:[UIImage imageNamed:@"icon_nodata"]];
        [imgview setContentMode:UIViewContentModeCenter];
        [self addSubview:imgview];
    }
}

/**
 选择照片

 @param recognizer 点击手势
 */
-(void)choosePhotoAction:(UITapGestureRecognizer *)recognizer{
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // init picker
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
            // set delegate
            picker.delegate = self;
//            picker.assetsFetchOptions
            // Optionally present picker as a form sheet on iPad
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                picker.modalPresentationStyle = UIModalPresentationFormSheet;
            
            // present picker
            [self.viewController presentViewController:picker animated:YES completion:nil];
        });
    }];
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset{
    return picker.selectedAssets.count<1?true:false;
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
        CGFloat scale = [UIScreen mainScreen].scale;
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.resizeMode = PHImageRequestOptionsResizeModeNone;
        options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        /** 遍历选择的所有图片*/
        for (NSInteger i = 0; i < assets.count; i++) {
            PHAsset *asset = assets[i];
            CGSize size = CGSizeMake(asset.pixelWidth / scale, asset.pixelHeight / scale);
            
            @weakify(self);
            /** 获取图片*/
            [[PHImageManager defaultManager] requestImageForAsset:asset
                                                       targetSize:size
                                                      contentMode:PHImageContentModeDefault
                                                          options:options
                                                    resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                                                        
                                                        @strongify(self);
                                                        
                                                        if(result!=nil){
                                                            
                                                            NSData *imageData = UIImagePNGRepresentation(result);
                                                            NSString *libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
                                                            NSString *photopath = [libraryPath stringByAppendingString:[NSString stringWithFormat:@"/%@_%@.png",currentmodel.EID,@"photo1"]];
                                                            
                                                            BOOL state = [[NSFileManager defaultManager] createFileAtPath:photopath contents:imageData attributes:nil];
                                                            if (state) {
//                                                                currentmodel.PHOTO1 = [NSString stringWithFormat:@"%@_%@.png",currentmodel.EID,@"photo1"];
                                                                UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 75, self.bounds.size.width-20, self.bounds.size.height - 75 - 40)];
                                                                [imgview setImage:result];
                                                                [imgview setContentMode:UIViewContentModeScaleToFill];
                                                                [self addSubview:imgview];
                                                                imageviewArray = [NSArray arrayWithObjects:imgview, nil];
                                                                
//                                                                if (self.updatePhotoBlock) {
//                                                                    self.updatePhotoBlock(currentmodel.EID,currentmodel.PHOTO1);
//                                                                }
                                                                
                                                            }
                                                        }
                                                        
                                                    }];
        }
        
    }];
}

@end
