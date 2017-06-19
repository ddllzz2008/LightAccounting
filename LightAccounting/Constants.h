//
//  Constants.h
//  LightAccounting
//
//  Created by ddllzz on 2017/6/19.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

+(Constants*)Instance;

@property (nonatomic,strong) NSMutableDictionary *viewrefreshCache;

@end
