//
//  BusExpenditure.h
//  HomeAPP
//
//  Created by ddllzz on 16/5/17.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "MTLModel.h"
#import "MTLJSONAdapter.h"

@interface BusExpenditure : MTLModel<MTLJSONSerializing>

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

@property (nonatomic,copy,readwrite) NSString *PHOTO1;

@property (nonatomic,assign) int TYPE;

@property (nonatomic,copy,readwrite) NSString *CNAME;

@property (nonatomic,copy,readwrite) NSString *CCOLOR;
    

@end
