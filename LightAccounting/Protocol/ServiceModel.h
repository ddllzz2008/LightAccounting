//
//  ServiceModel.h
//  DLZProject
//
//  Created by ddllzz on 16/11/21.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface ServiceModel : MTLModel <MTLJSONSerializing>

@property (nonatomic,retain) NSString *Code;
@property (nonatomic, retain) NSString* Message;
@property (nonatomic, retain) NSString* Data;

@end
