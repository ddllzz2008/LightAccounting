//
//  MyZoneViewModel.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/15.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewModel.h"
#import "SandboxManager.h"
#import "FamilyPersonDAL.h"
#import "FamilyPerson.h"

@interface MyZoneViewModel : BaseViewModel

/**
 保存用户头像
 
 @param image <#image description#>
 @return <#return value description#>
 */
-(BOOL)saveUserPhotos:(UIImage*)image;
/**
 显示头像
 
 @return <#return value description#>
 */
-(UIImage *)displayUserPhoto;

@end
