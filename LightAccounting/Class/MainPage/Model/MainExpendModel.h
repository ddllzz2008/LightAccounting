//
//  MainExpendModel.h
//  LightAccounting
//
//  Created by ddllzz on 17/3/22.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MainGroupModel : NSObject

@property (nonatomic,strong,readwrite) NSString *groupDate;

@property (nonatomic,assign,readwrite) float groupExpend;

@property (nonatomic,strong,readwrite) NSArray *groupSource;

@end


@interface MainExpendModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy,readwrite) NSString *EID;

@property (nonatomic,readwrite) double EVALUE;

@property (nonatomic,copy,readwrite) NSString *CID;

@property (nonatomic,copy,readwrite) NSString *FID;

@property (nonatomic,copy,readwrite) NSString *PID;

@property (nonatomic,strong,readwrite) NSString *CREATETIME;

@property (nonatomic,strong,readwrite) NSString *EYEAR;

@property (nonatomic,strong,readwrite) NSString *EMONTH;

@property (nonatomic,strong,readwrite) NSString *EDAY;

@property (nonatomic,copy,readwrite) NSString *IMARK;

@property (nonatomic,copy,readwrite) NSString *BDX;

@property (nonatomic,copy,readwrite) NSString *BDY;

@property (nonatomic,copy,readwrite) NSString *BDADDRESS;

@property (nonatomic,copy,readwrite) NSString *CNAME;

//@property (nonatomic,copy,readwrite) NSString *PHOTO1;

@property (nonatomic,copy,readwrite) NSString *CCOLOR;

//@property (nonatomic,copy,readwrite) NSString *PNAME;

//@property (nonatomic,assign) int PAYTYPE;

//@property (nonatomic,copy,readwrite) NSString *PAYTYPEICON;

//@property (nonatomic,strong) NSMutableArray *EXPENDSOURCE;

@end
