//
//  HttpServiceCompleted.h
//  DLZProject
//
//  Created by ddllzz on 16/11/21.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceModel.h"

@protocol HttpServiceCompleted <NSObject>

@optional
-(void)dealWithCallback:(id) response identify:(NSString *)identify;
-(void)dealWithProgress:(BOOL)iscompleted progress:(float)progress identify:(NSString *)identify index:(int)index;
-(void)dealWithProgressCompleted:(id)dict identify:(NSString*)identify index:(int)index;

@required
-(void)dealWithResponse:(id)dict identify:(NSString*)identify;

@end
