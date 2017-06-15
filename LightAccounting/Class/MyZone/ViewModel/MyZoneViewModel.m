//
//  MyZoneViewModel.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/15.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "MyZoneViewModel.h"

@implementation MyZoneViewModel

/**
 保存用户头像

 @param image <#image description#>
 @return <#return value description#>
 */
-(BOOL)saveUserPhotos:(UIImage*)image{
    
    NSArray *array = [[FamilyPersonDAL Instance] getFamilyPersons];
    if (array!=nil) {
        FamilyPerson *person = [array objectAtIndex:0];
        
        SandboxManager *manager = [[SandboxManager alloc] initWithMode:SandboxModeDocument directory:@"photos"];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        
        NSString *photoname = [NSString stringWithFormat:@"%@.jpg",person.fid];
        
        BOOL hresult =[manager saveImageToSandbox:photoname data:data];
        
        if (hresult) {
            [[FamilyPersonDAL Instance] setFamilyPhoto:person.fid filename:photoname];
        }
        
        return hresult;
        
    }else{
        return NO;
    }
    
}

/**
 显示头像

 @return <#return value description#>
 */
-(UIImage *)displayUserPhoto{
    
    NSArray *array = [[FamilyPersonDAL Instance] getFamilyPersons];
    if (array!=nil) {
        FamilyPerson *person = [array objectAtIndex:0];
        
        SandboxManager *manager = [[SandboxManager alloc] initWithMode:SandboxModeDocument directory:@"photos"];
        NSString *photoname = [NSString stringWithFormat:@"%@.jpg",person.fid];
        
        UIImage *image = [manager getImageFromSandbox:photoname];
        
        return image;
        
    }else{
        return nil;
    }
    
}

@end
