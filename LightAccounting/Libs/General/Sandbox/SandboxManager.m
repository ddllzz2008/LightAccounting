//
//  SandboxManager.m
//  LightAccounting
//
//  Created by ddllzz on 2017/6/15.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "SandboxManager.h"

@implementation SandboxManager

-(id)initWithMode:(SandboxMode)mode directory:(NSString *)directory{
    if (self = [super init]) {
        _mode = mode;
        _directory = directory;
        NSArray *patharray;
        switch (_mode) {
            case SandboxModeDocument:
                patharray = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
                if (patharray!=nil) {
                    _savePath =[patharray objectAtIndex:0];
                }
                break;
            case SandboxModeCache:
                patharray = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
                if (patharray!=nil) {
                    _savePath =[patharray objectAtIndex:0];
                }
                break;
            case SandboxModeTemporary:
                _savePath = NSTemporaryDirectory();
            default:
                break;
        }
        
        if (directory!=nil&&![directory isEqualToString:@""]) {
            NSString *directorypath = [_savePath stringByAppendingPathComponent:directory];
            BOOL isDirectory;
            BOOL isexist = [[NSFileManager defaultManager] fileExistsAtPath:directorypath isDirectory:&isDirectory];
            if (!(isexist && isDirectory)) {
                BOOL hresult = [[NSFileManager defaultManager] createDirectoryAtPath:directorypath withIntermediateDirectories:YES attributes:@{NSFileAppendOnly:@NO,NSFileCreationDate:[NSDate dateWithZone]} error:nil];
                if (!hresult) {
                    DDLogError(@"创建文件目录失败%@",directorypath);
                }
                
                _ifdirectoryExist = hresult;
            }else{
                _ifdirectoryExist = YES;
            }
            
            _directory = directorypath;
            
        }else{
            _ifdirectoryExist = YES;
        }
        
    }
    return self;
}

/**
 写入文件---追加

 @param fileName 文件名
 @param text 文本内容
 @param append 是否追加
 @return 是否写入成功
 */
-(BOOL)saveStringToSandbox:(NSString *)fileName text:(NSString *)text append:(BOOL)append{
    
    if (_ifdirectoryExist) {
        @try {
            NSFileHandle  *outFile;
            NSData *buffer;
            
            NSString *filePath = [_directory stringByAppendingPathComponent:fileName];
            
            BOOL fileexist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
            if (!fileexist || append) {
                
                [text writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
                
            }else{
                outFile = [NSFileHandle fileHandleForWritingAtPath:filePath];
                if(outFile == nil)
                {
                    DDLogError(@"Open of file for writing failed");
                    return NO;
                }
                [outFile seekToEndOfFile];
                
                buffer = [text dataUsingEncoding:NSUTF8StringEncoding];
                
                [outFile writeData:buffer];
                
                //关闭读写文件  
                [outFile closeFile];
            }
            return YES;
        } @catch (NSException *exception) {
            DDLogError(@"%@",exception);
            return NO;
        } @finally {
            
        }
        
    }else{
        return NO;
    }
    
}

/**
 写入图片到沙箱中

 @param fileName <#fileName description#>
 @param data <#data description#>
 @return <#return value description#>
 */
-(BOOL)saveImageToSandbox:(NSString *)fileName data:(NSData *)data{
    NSString *filePath = [_directory stringByAppendingPathComponent:fileName];
    return [data writeToFile:filePath atomically:YES];
}

/**
 获取沙箱图片文件

 @param fileName <#fileName description#>
 @return <#return value description#>
 */
-(UIImage *)getImageFromSandbox:(NSString *)fileName{
    @try {
        
        NSString *filePath = [_directory stringByAppendingPathComponent:fileName];
        BOOL fileexist = [[NSFileManager defaultManager] fileExistsAtPath:filePath];
        if (fileexist) {
            
            UIImage *img = [UIImage imageWithContentsOfFile:filePath];
            
            return img;
            
        }else{
            return nil;
        }
        
    } @catch (NSException *exception) {
        return nil;
    } @finally {
        
    }
    
}

@end
