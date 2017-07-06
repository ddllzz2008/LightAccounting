//
//  MyZoneViewController.m
//  LightAccounting
//
//  Created by ddllzz on 17/3/8.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "MyZoneViewController.h"

@interface MyZoneViewController (){
    
    UILabel *agelabel;
    UIImageView *photoImgView;
    UILabel *namelabel;
    UILabel *lasttimelabel;
}

@end

@implementation MyZoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"个人中心"];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self showTabbar];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

-(void)initControls{
    
//    @weakify(self);
    __weak typeof(self) weakSelf = self;
    
    agelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 20)];
    agelabel.textAlignment=NSTextAlignmentRight;
    [agelabel setFont:fontsize_13];
    [agelabel setTextColor:UIColorFromRGB(0xCCCCCC)];
    [self.view addSubview:agelabel];
    
    [agelabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.top.equalTo(strongSelf.view.mas_top).with.offset(5);
        make.right.equalTo(strongSelf.view.mas_right).with.offset(-5);
    }];
    
    photoImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 70, 70)];
    photoImgView.layer.masksToBounds=YES;
    photoImgView.layer.cornerRadius=35;
    [photoImgView setImage:[UIImage imageNamed:@"icon_capture"]];
    UITapGestureRecognizer *choosephotoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePhoto:)];
    photoImgView.userInteractionEnabled = YES;
    [photoImgView addGestureRecognizer:choosephotoTap];
    [self.view addSubview:photoImgView];
    
    [photoImgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.top.equalTo(strongSelf.view.mas_top).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(70, 70));
        make.centerX.equalTo(strongSelf.view);
    }];
    
    namelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 20)];
    namelabel.textAlignment=NSTextAlignmentCenter;
    [namelabel setFont:fontsize_16];
    [namelabel setTextColor:get_theme_color];
    [self.view addSubview:namelabel];
    
    [namelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(photoImgView);
        make.top.equalTo(photoImgView.mas_bottom).with.offset(15);
    }];
    
    lasttimelabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 20)];
    lasttimelabel.textAlignment=NSTextAlignmentRight;
    [lasttimelabel setFont:fontsize_13];
    [lasttimelabel setTextColor:UIColorFromRGB(0xCCCCCC)];
    [self.view addSubview:lasttimelabel];
    
    [lasttimelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(namelabel.mas_bottom).with.offset(5);
        make.centerX.equalTo(namelabel);
    }];
    
    //判断iphone5以下设备和iphone6以上设备的不同尺寸布局
    double lineheight = 100;
    double imageheight = 50;
    if(ScreenSize.height>640){//iphone6以上产品
        lineheight = 100;
        imageheight = 50;
    }else{
        lineheight = 80;
        imageheight = 35;
    }
    
    TopLineView *viewline1 = [[TopLineView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, lineheight)];
    [self.view addSubview:viewline1];
    
    [viewline1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, lineheight));
        make.left.equalTo(strongSelf.view);
        make.top.equalTo(lasttimelabel.mas_bottom).with.offset(30);
    }];
    
    float imgwidth = imageheight;
    float singelwidth = ScreenSize.width/3;
    float margin = (singelwidth - imgwidth)/2;
    
    UIImageView *icon1_1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgwidth, imgwidth)];
    [icon1_1 setImage:[UIImage imageNamed:@"icon_income"]];
    icon1_1.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tapicon1_1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigateTapCategoryIncomeController)];
    [icon1_1 addGestureRecognizer:tapicon1_1];
    [viewline1 addSubview:icon1_1];
    
    [icon1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imgwidth, imgwidth));
        make.left.equalTo(viewline1.mas_left).with.offset(margin);
        make.top.equalTo(viewline1.mas_top).with.offset(10);
    }];
    
    UILabel *label1_1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, singelwidth, 20)];
    label1_1.textAlignment=NSTextAlignmentCenter;
    [label1_1 setFont:fontsize_13];
    [label1_1 setTextColor:UIColorFromRGB(0x333333)];
    [label1_1 setText:@"收入分类"];
    [self.view addSubview:label1_1];
    
    [label1_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(singelwidth, 20));
        make.centerX.equalTo(icon1_1);
        make.top.equalTo(icon1_1.mas_bottom).with.offset(10);
    }];
    
    UIImageView *icon1_2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgwidth, imgwidth)];
    [icon1_2 setImage:[UIImage imageNamed:@"icon_expend"]];
    icon1_2.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tapicon1_2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigateTapCategoryExpendController)];
    [icon1_2 addGestureRecognizer:tapicon1_2];
    [viewline1 addSubview:icon1_2];
    
    [icon1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imgwidth, imgwidth));
        make.centerX.equalTo(viewline1);
        make.top.equalTo(viewline1.mas_top).with.offset(10);
    }];
    
    UILabel *label1_2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, singelwidth, 20)];
    label1_2.textAlignment=NSTextAlignmentCenter;
    [label1_2 setFont:fontsize_13];
    [label1_2 setTextColor:UIColorFromRGB(0x333333)];
    [label1_2 setText:@"支出分类"];
    [viewline1 addSubview:label1_2];
    
    [label1_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(singelwidth, 20));
        make.centerX.equalTo(icon1_2);
        make.top.equalTo(icon1_2.mas_bottom).with.offset(10);
    }];
    
    UIImageView *icon1_3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgwidth, imgwidth)];
    [icon1_3 setImage:[UIImage imageNamed:@"icon_budget"]];
    icon1_3.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapicon1_3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigateTapBudgetController)];
    [icon1_3 addGestureRecognizer:tapicon1_3];
    [viewline1 addSubview:icon1_3];
    
    [icon1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imgwidth, imgwidth));
        make.right.equalTo(viewline1.mas_right).with.offset(0-margin);
        make.top.equalTo(viewline1.mas_top).with.offset(10);
    }];
    
    UILabel *label1_3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, singelwidth, 20)];
    label1_3.textAlignment=NSTextAlignmentCenter;
    [label1_3 setFont:fontsize_13];
    [label1_3 setTextColor:UIColorFromRGB(0x333333)];
    [label1_3 setText:@"预算"];
    [viewline1 addSubview:label1_3];
    
    [label1_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(singelwidth, 20));
        make.centerX.equalTo(icon1_3);
        make.top.equalTo(icon1_3.mas_bottom).with.offset(10);
    }];
    
    //第二行
    TopLineView *viewline2 = [[TopLineView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, lineheight)];
    [self.view addSubview:viewline2];
    
    [viewline2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, lineheight));
        make.left.equalTo(strongSelf.view);
        make.top.equalTo(viewline1.mas_bottom).with.offset(0);
    }];
    
    UIImageView *icon2_1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgwidth, imgwidth)];
    [icon2_1 setImage:[UIImage imageNamed:@"icon_family"]];
    icon2_1.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapicon2_1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigateTapFamilyController)];
    [icon2_1 addGestureRecognizer:tapicon2_1];
    [viewline2 addSubview:icon2_1];
    
    [icon2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imgwidth, imgwidth));
        make.left.equalTo(viewline2.mas_left).with.offset(margin);
        make.top.equalTo(viewline2.mas_top).with.offset(10);
    }];
    
    UILabel *label2_1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, singelwidth, 20)];
    label2_1.textAlignment=NSTextAlignmentCenter;
    [label2_1 setFont:fontsize_13];
    [label2_1 setTextColor:UIColorFromRGB(0x333333)];
    [label2_1 setText:@"家庭账本"];
    [viewline2 addSubview:label2_1];
    
    [label2_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(singelwidth, 20));
        make.centerX.equalTo(icon2_1);
        make.top.equalTo(icon2_1.mas_bottom).with.offset(10);
    }];
    
    UIImageView *icon2_2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgwidth, imgwidth)];
    [icon2_2 setImage:[UIImage imageNamed:@"icon_calender"]];
    icon2_2.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tapicon2_2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigateTapPlanController)];
    [icon2_2 addGestureRecognizer:tapicon2_2];
    [viewline2 addSubview:icon2_2];
    
    [icon2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imgwidth, imgwidth));
        make.centerX.equalTo(viewline2);
        make.top.equalTo(viewline2.mas_top).with.offset(10);
    }];
    
    UILabel *label2_2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, singelwidth, 20)];
    label2_2.textAlignment=NSTextAlignmentCenter;
    [label2_2 setFont:fontsize_13];
    [label2_2 setTextColor:UIColorFromRGB(0x333333)];
    [label2_2 setText:@"计划任务"];
    [viewline2 addSubview:label2_2];
    
    [label2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(singelwidth, 20));
        make.centerX.equalTo(icon2_2);
        make.top.equalTo(icon2_2.mas_bottom).with.offset(10);
    }];
    
    UIImageView *icon2_3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgwidth, imgwidth)];
    [icon2_3 setImage:[UIImage imageNamed:@"icon_theme"]];
    icon2_3.userInteractionEnabled=YES;
    UITapGestureRecognizer *tapicon2_3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigateTapThemeController)];
    [icon2_3 addGestureRecognizer:tapicon2_3];
    [viewline2 addSubview:icon2_3];
    
    [icon2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imgwidth, imgwidth));
        make.right.equalTo(viewline2.mas_right).with.offset(0-margin);
        make.top.equalTo(viewline2.mas_top).with.offset(10);
    }];
    
    UILabel *label2_3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, singelwidth, 20)];
    label2_3.textAlignment=NSTextAlignmentCenter;
    [label2_3 setFont:fontsize_13];
    [label2_3 setTextColor:UIColorFromRGB(0x333333)];
    [label2_3 setText:@"主题颜色"];
    [viewline2 addSubview:label2_3];
    
    [label2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(singelwidth, 20));
        make.centerX.equalTo(icon2_3);
        make.top.equalTo(icon2_3.mas_bottom).with.offset(10);
    }];
    
    //第三行
    TopLineView *viewline3 = [[TopLineView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, lineheight)];
    [self.view addSubview:viewline3];
    
    [viewline3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        @strongify(self);
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.size.mas_equalTo(CGSizeMake(ScreenSize.width, lineheight));
        make.left.equalTo(strongSelf.view);
        make.top.equalTo(viewline2.mas_bottom).with.offset(0);
    }];
    
    UIImageView *icon3_1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgwidth, imgwidth)];
    [icon3_1 setImage:[UIImage imageNamed:@"icon_password"]];
    
    icon3_1.userInteractionEnabled=YES;
    
    UITapGestureRecognizer *tapicon3_1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navigateTapPassController)];
    [icon3_1 addGestureRecognizer:tapicon3_1];
    
    [viewline3 addSubview:icon3_1];
    
    [icon3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imgwidth, imgwidth));
        make.left.equalTo(viewline3.mas_left).with.offset(margin);
        make.top.equalTo(viewline3.mas_top).with.offset(10);
    }];
    
    UILabel *label3_1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, singelwidth, 20)];
    label3_1.textAlignment=NSTextAlignmentCenter;
    [label3_1 setFont:fontsize_13];
    [label3_1 setTextColor:UIColorFromRGB(0x333333)];
    [label3_1 setText:@"手势密码"];
    [viewline3 addSubview:label3_1];
    
    [label3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(singelwidth, 20));
        make.centerX.equalTo(icon3_1);
        make.top.equalTo(icon3_1.mas_bottom).with.offset(10);
    }];
    
    UIImageView *icon3_2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgwidth, imgwidth)];
    [icon3_2 setImage:[UIImage imageNamed:@"icon_cloud"]];
    [viewline3 addSubview:icon3_2];
    
    [icon3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imgwidth, imgwidth));
        make.centerX.equalTo(viewline3);
        make.top.equalTo(viewline3.mas_top).with.offset(10);
    }];
    
    UILabel *label3_2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, singelwidth, 20)];
    label3_2.textAlignment=NSTextAlignmentCenter;
    [label3_2 setFont:fontsize_13];
    [label3_2 setTextColor:UIColorFromRGB(0x333333)];
    [label3_2 setText:@"数据备份"];
    [viewline3 addSubview:label3_2];
    
    [label3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(singelwidth, 20));
        make.centerX.equalTo(icon3_2);
        make.top.equalTo(icon3_2.mas_bottom).with.offset(10);
    }];
    
    UIImageView *icon3_3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imgwidth, imgwidth)];
    [icon3_3 setImage:[UIImage imageNamed:@"icon_clean"]];
    [viewline3 addSubview:icon3_3];
    
    [icon3_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(imgwidth, imgwidth));
        make.right.equalTo(viewline3.mas_right).with.offset(0-margin);
        make.top.equalTo(viewline3.mas_top).with.offset(10);
    }];
    
    UILabel *label3_3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, singelwidth, 20)];
    label3_3.textAlignment=NSTextAlignmentCenter;
    [label3_3 setFont:fontsize_13];
    [label3_3 setTextColor:UIColorFromRGB(0x333333)];
    [label3_3 setText:@"清除缓存"];
    [viewline3 addSubview:label3_3];
    
    [label3_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(singelwidth, 20));
        make.centerX.equalTo(icon3_3);
        make.top.equalTo(icon3_3.mas_bottom).with.offset(10);
    }];
}

#pragma mark---viewmodel操作
-(void)initWithViewModel{
    
    self.viewmodel = [[MyZoneViewModel alloc] init];
    
}

-(void)loadAppearData{
    
    if ([[[Constants Instance].viewrefreshCache valueForKey:@"settingpage"] isEqual:@YES]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            UIImage *image = [self.viewmodel displayUserPhoto];
            
            NSDate *date = [self.viewmodel.currentConfig.STARTDATE convertDateFromString:@"yyyy-MM-dd HH:mm:ss"];
            int days = [[NSDate dateWithZone] dateDiff:date];
            
            NSDate *lastdate = nil;
            if ([self.viewmodel.currentConfig.LASTDATE isEqualToString:@""] || self.viewmodel.currentConfig.LASTDATE==nil) {
                lastdate = date;
            }else{
                lastdate = [self.viewmodel.currentConfig.LASTDATE convertDateFromString:@"yyyy-MM-dd HH:mm:ss"];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (image!=nil) {
                    photoImgView.image = image;
                }
                
                [agelabel setText:[NSString stringWithFormat:@"我的账龄:%d天",days]];
                [namelabel setText:self.viewmodel.currentPerson.fname];
                [lasttimelabel setText:[NSString stringWithFormat:@"最后记账时间:%@",[lastdate formatWithCode:@"yyyy年MM月dd日"]]];
                
                [[Constants Instance].viewrefreshCache setValue:@NO forKey:@"settingpage"];
            });
            
        });
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark---选择照片
/**
 选择照片
 
 @param sender 手势对象
 */
-(void)choosePhoto:(UITapGestureRecognizer*)sender{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"图片来源"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"从手机相册中选取"
                                  otherButtonTitles:@"拍照",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (buttonIndex==0) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
            if (status !=PHAuthorizationStatusAuthorized)return;
            dispatch_async(dispatch_get_main_queue(), ^{
                CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
                picker.delegate =self;
                // 显示选择的索引
                picker.showsSelectionIndex =NO;
                // 设置相册的类型：相机胶卷 +自定义相册
                picker.assetCollectionSubtypes =@[
                                                  @(PHAssetCollectionSubtypeSmartAlbumUserLibrary),
                                                  @(PHAssetCollectionSubtypeAlbumRegular)];
                // 不需要显示空的相册
                picker.showsEmptyAlbums =NO;
                
                [self.navigationController presentViewController:picker animated:YES completion:nil];
            });
        }];
    }else if (buttonIndex==1){
        
        UIImagePickerController *controller = [[UIImagePickerController alloc] init];
        /*设置媒体来源，即调用出来的UIImagePickerController所显示出来的界面，有一下三种来源
         typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
         UIImagePickerControllerSourceTypePhotoLibrary,
         UIImagePickerControllerSourceTypeCamera,
         UIImagePickerControllerSourceTypeSavedPhotosAlbum
         };分别表示：图片列表，摄像头，相机相册*/
        [controller setSourceType:UIImagePickerControllerSourceTypeCamera];
        // 设置所支持的媒体功能，即只能拍照，或则只能录像，或者两者都可以
        NSString *requiredMediaType = (NSString *)kUTTypeImage;
        //        NSString *requiredMediaType1 = ( NSString *)kUTTypeMovie;
        NSArray *arrMediaTypes=[NSArray arrayWithObjects:requiredMediaType,nil];
        [controller setMediaTypes:arrMediaTypes];
        // 设置录制视频的质量
        //        [controller setVideoQuality:UIImagePickerControllerQualityTypeHigh];
        //设置最长摄像时间
        //        [controller setVideoMaximumDuration:10.f];
        // 设置是否可以管理已经存在的图片或者视频
        [controller setAllowsEditing:YES];
        // 设置代理
        [controller setDelegate:self];
        [self.navigationController presentViewController:controller animated:YES completion:nil];
        
    }
}

-(BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset
{
    NSInteger max =1;
    if (picker.selectedAssets.count >= max) {
        return NO;
    }
    return YES;
}

/**
 选择相册返回
 
 @param picker 选择器
 @param assets 选择的资源
 */
-(void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    //关闭选择界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    if (assets.count>0) {
        //        CGFloat scale = [UIScreen mainScreen].scale;
        CGFloat scale = 20;
        PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
        options.resizeMode =PHImageRequestOptionsResizeModeExact;
        options.deliveryMode =PHImageRequestOptionsDeliveryModeHighQualityFormat;
        PHAsset *asset = assets[0];
        CGSize size =CGSizeMake(asset.pixelWidth / scale, asset.pixelHeight / scale);
        // // 获取图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage *_Nullable result,NSDictionary *_Nullable info) {
            
            photoImgView.image = result;
            //            NSData *imageData =UIImageJPEGRepresentation([self imageWithImageSimple:result scaledToSize:CGSizeMake(200,200)], 0.5);
            //            [selfossUpload:imageData];
            
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
               
                [self.viewmodel saveUserPhotos:result];
                
            });
            
        }];
    }
}

/**
 拍照返回
 
 @param picker 拍照选择器
 @param info 返回的照片
 */
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    // 判断获取类型：图片
    if ([mediaType isEqualToString:( NSString *)kUTTypeImage]){
        UIImage *theImage = nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]){
            //获取用户编辑之后的图像
            theImage = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的原数据
            theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        photoImgView.image = theImage;
        [picker  dismissViewControllerAnimated:YES completion:nil];
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [self.viewmodel saveUserPhotos:theImage];
            
        });
    }
    
}

#pragma mark---跳转

/**
 跳转到预算管理
 */
-(void)navigateTapBudgetController{
    [self.navigationController pushViewController:[[BudgetViewController alloc] init] animated:YES];
}

/**
 跳转到手势密码
 */
-(void)navigateTapPassController{
    [self.navigationController pushViewController:[[PasswordViewController alloc] init] animated:YES];
}
/**
 跳转到收入分类
 */
-(void)navigateTapCategoryIncomeController{
    [self.navigationController pushViewController:[[CategoryViewController alloc] initWithType:YES] animated:YES];
}
/**
 跳转到支出分类
 */
-(void)navigateTapCategoryExpendController{
    [self.navigationController pushViewController:[[CategoryViewController alloc] initWithType:NO] animated:YES];
}
/**
 跳转到家庭成员
 */
-(void)navigateTapFamilyController{
    [self.navigationController pushViewController:[[FamilyViewController alloc] init] animated:YES];
}
/**
 跳转到主题管理
 */
-(void)navigateTapPlanController{
    [self.navigationController pushViewController:[[PlanViewController alloc] init] animated:YES];
}

/**
 跳转到主题管理
 */
-(void)navigateTapThemeController{
    [self.navigationController pushViewController:[[ThemeViewController alloc] init] animated:YES];
}

@end
