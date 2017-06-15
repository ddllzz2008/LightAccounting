//
//  SandboxManager.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/15.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDate+ExtMethod.h"

typedef NS_ENUM(NSInteger, SandboxMode) {
    SandboxModeDocument=0,
    SandboxModeCache=1,
    SandboxModeTemporary=2
};

@interface SandboxManager : NSObject{
    
    SandboxMode _mode;
    
    NSString *_savePath;
    
    NSString *_directory;
    
    BOOL _ifdirectoryExist;
    
}

-(id)initWithMode:(SandboxMode)mode directory:(NSString *)directory;
/**
 写入文件---追加
 
 @param fileName 文件名
 @param text 文本内容
 @param append 是否追加
 @return 是否写入成功
 */
-(BOOL)saveStringToSandbox:(NSString *)fileName text:(NSString *)text append:(BOOL)append;

/**
 写入图片到沙箱中
 
 @param fileName <#fileName description#>
 @param data <#data description#>
 @return <#return value description#>
 */
-(BOOL)saveImageToSandbox:(NSString *)fileName data:(NSData *)data;
/**
 获取沙箱图片文件
 
 @param fileName <#fileName description#>
 @return <#return value description#>
 */
-(UIImage *)getImageFromSandbox:(NSString *)fileName;

@end
