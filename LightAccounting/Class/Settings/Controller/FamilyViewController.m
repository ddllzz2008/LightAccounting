//
//  FamilyViewController.m
//  LightAccounting
//
//  Created by ddllzz on 2017/5/16.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "FamilyViewController.h"

@interface FamilyViewController ()

@end

@implementation FamilyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"家庭账本"];
    [self hiddenTabbar];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_edit"] style:UIBarButtonItemStyleDone target:self action:@selector(deleteAction:)];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    deleteMode = NO;
}

-(void)initControls{
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    //同一行相邻两个cell的最小间距
    layout.minimumInteritemSpacing = 20;
    //最小两行之间的间距
    layout.minimumLineSpacing = 15;
    
    collectionview=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    collectionview.backgroundColor=[UIColor clearColor];
    collectionview.delegate=self;
    collectionview.dataSource=self;
    [collectionview registerClass:[CategoryViewCell class] forCellWithReuseIdentifier:@"CategoryViewCell"];
    
    [self.view addSubview:collectionview];
    
    __weak __typeof(self.view) weakSelf = self.view;
    [collectionview mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.top.equalTo(strongSelf).with.offset(20);
        make.left.equalTo(strongSelf).with.offset(20);
        make.bottom.equalTo(strongSelf).with.offset(-60);
        make.right.equalTo(strongSelf).with.offset(-20);
    }];
    
    RadarSearchButton *radarbutton = [[RadarSearchButton alloc] initWithFrame:CGRectMake(0, 0, 140, 100)];
    radarbutton.delegate=self;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapNewFamily:)];
    [radarbutton addGestureRecognizer:tap];
    UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(holdSyncFamily:)];
    longpress.cancelsTouchesInView = NO;
    [radarbutton addGestureRecognizer:longpress];
    
    [self.view addSubview:radarbutton];
    [radarbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        make.size.mas_equalTo(CGSizeMake(140, 100));
        make.bottom.equalTo(strongSelf.mas_bottom);
        make.centerX.equalTo(strongSelf);
    }];
}

#pragma mark--uicollectionview视图
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 3;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"CategoryViewCell";
    CategoryViewCell *cell = (CategoryViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:indentifier forIndexPath:indexPath];
    [cell setAnchorImage:[UIImage imageNamed:@"icon_capture"]];
    [cell setLabelText:@"我的账本"];
    if (deleteMode) {
        cell.showDelete=YES;
    }else{
        cell.showDelete=NO;
    }
    return cell;
    
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 90);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark---交互事件
-(void)deleteAction:(id)sender{
    
    deleteMode = YES;
    
    [collectionview reloadData];
    
    UIButton *right = [UIButton buttonWithType:UIButtonTypeCustom];
    right.frame = CGRectMake(0, 0, 40, 40);
    [right addTarget:self action:@selector(comfirmBackEvent) forControlEvents:UIControlEventTouchUpInside];
    [right setTitle:@"确定" forState:UIControlStateNormal];
    [right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithCustomView:right];
    self.navigationItem.rightBarButtonItem = rightBut;
    
}

-(void)comfirmBackEvent{
    
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_edit"] style:UIBarButtonItemStyleDone target:self action:@selector(deleteAction:)];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    deleteMode = NO;
    
    [collectionview reloadData];
    
}

-(void)tapNewFamily:(UITapGestureRecognizer *)sender{
    
    if (accountView==nil) {
        
        chooseWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [chooseWindow setBackgroundColor:[UIColor clearColor]];
        chooseWindow.alpha=1.0f;
        chooseWindow.windowLevel = UIWindowLevelAlert;
        chooseWindow.hidden=NO;
        
        UIViewController *rootviewcontroller = [[UIViewController alloc] init];
        chooseWindow.rootViewController = rootviewcontroller;
        
        
        
        rootview = [[UIView alloc] initWithFrame:chooseWindow.frame];
        rootview.backgroundColor=[UIColor grayColor];
        rootview.alpha=0.4f;
        UITapGestureRecognizer *hiddenTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenAction:)];
        [rootview addGestureRecognizer:hiddenTap];
//        [chooseWindow addSubview:rootview];
        [rootviewcontroller.view addSubview:rootview];
        
        accountView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width-40, 200)];
        accountView.layer.cornerRadius=5.0f;
        accountView.layer.masksToBounds=YES;
        accountView.backgroundColor = get_theme_color;
//        [chooseWindow addSubview:accountView];
        [rootviewcontroller.view addSubview:accountView];
        
        __weak __typeof(rootviewcontroller.view) weakSelf = rootviewcontroller.view;
        
        [accountView mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            make.left.equalTo(strongSelf).with.offset(20);
            make.right.equalTo(strongSelf.mas_right).with.offset(-20);
            make.top.equalTo(strongSelf).with.offset(80);
            make.height.equalTo(@200);
        }];
        
        __weak __typeof(accountView) weakaccountView = accountView;
        photoview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
        photoview.layer.cornerRadius=30;
        photoview.layer.masksToBounds=YES;
        photoview.image=[UIImage imageNamed:@"icon_capture"];
        UITapGestureRecognizer *choosephotoTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePhoto:)];
        photoview.userInteractionEnabled = YES;
        [photoview addGestureRecognizer:choosephotoTap];
        [accountView addSubview:photoview];
        [photoview mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakaccountView) strongweakaccountView = weakaccountView;
            make.size.mas_equalTo(CGSizeMake(60, 60));
            make.top.equalTo(strongweakaccountView).with.offset(15);
            make.centerX.equalTo(strongweakaccountView);
        }];
        
        UITextField *photoName = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        photoName.backgroundColor=[UIColor whiteColor];
        photoName.placeholder=@"输入账本名称";
        photoName.textColor=UIColorFromRGB(0x888888);
        photoName.textAlignment=NSTextAlignmentCenter;
        [accountView addSubview:photoName];
        
        [photoName mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakaccountView) strongweakaccountView = weakaccountView;
            make.left.equalTo(strongweakaccountView).with.offset(20);
            make.right.equalTo(strongweakaccountView).with.offset(-20);
            make.height.equalTo(@40);
            make.top.equalTo(photoview.mas_bottom).with.offset(15);
        }];
        
        UIButton *photosave = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
        [photosave setTitle:@"保存" forState:UIControlStateNormal];
        photosave.backgroundColor=UIColorFromRGB(0xcccccc);
        [accountView addSubview:photosave];
        
        [photosave mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakaccountView) strongweakaccountView = weakaccountView;
            make.left.equalTo(strongweakaccountView).with.offset(20);
            make.right.equalTo(strongweakaccountView).with.offset(-20);
            make.height.equalTo(@40);
            make.top.equalTo(photoName.mas_bottom).with.offset(15);
        }];
    }
    
}

-(void)hiddenAction:(UITapGestureRecognizer*)sender{
    if (accountView!=nil) {
        [accountView removeFromSuperview];
        accountView = nil;
    }
    
    if(chooseWindow!=nil){
        
        chooseWindow.hidden=YES;
        chooseWindow=nil;
    }
}


-(void)holdSyncFamily:(UILongPressGestureRecognizer *)sender{
    if (rader==nil) {
        rader = [[RadarUIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        [rader setAlertMessage:@"正在查找附近设备"];
        [self.view addSubview:rader];
        
        __weak __typeof(self.view) weakSelf = self.view;
        [rader mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            make.left.equalTo(strongSelf);
            make.top.equalTo(strongSelf);
            make.bottom.equalTo(strongSelf.mas_bottom).with.offset(-100);
            make.width.equalTo(strongSelf);
        }];
    }
}


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
                
                [chooseWindow.rootViewController presentViewController:picker animated:YES completion:nil];
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
        [chooseWindow.rootViewController presentViewController:controller animated:YES completion:nil];
        
    }
}

-(BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset
{
    NSInteger max =1;
    if (picker.selectedAssets.count >= max) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:[NSString stringWithFormat:@"最多选择%zd张图片", max] preferredStyle:UIAlertControllerStyleAlert];
//        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil]];
//        [picker presentViewController:alert animated:YES completion:nil];
        // 这里不能使用self来modal别的控制器，因为此时self.view不在window上
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
            
            photoview.image = result;
//            NSData *imageData =UIImageJPEGRepresentation([self imageWithImageSimple:result scaledToSize:CGSizeMake(200,200)], 0.5);
//            [selfossUpload:imageData];
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
        photoview.image = theImage;
        [picker  dismissViewControllerAnimated:YES completion:nil];
    }
    
}

/**
 按钮弹起
 */
-(void)RadarSearchButtonTouchEnd{
    if (rader!=nil&&[rader superview]!=nil) {
        [rader removeFromSuperview];
        rader = nil;
    }
}

@end
