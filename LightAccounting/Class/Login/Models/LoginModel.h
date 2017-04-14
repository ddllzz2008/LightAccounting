//
//  LoginModel.h
//  DLZProject
//
//  Created by ddllzz on 16/12/21.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface UserModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,assign) NSInteger Id;
@property (nonatomic, retain) NSString* Code;
@property (nonatomic, retain) NSString* Name;
@property (nonatomic, retain) NSString* Email;
@property (nonatomic, retain) NSString* MobilePhone;
@property (nonatomic, retain) NSString* Gender;
@property (nonatomic, retain) NSString* ChineseName;
@property (nonatomic, retain) NSString* Photo;
@property (nonatomic, retain) NSString* Address;
@property (nonatomic, retain) NSString* Birthday;
@property (nonatomic, assign) NSInteger DepartmentId;
@property (nonatomic, retain) NSString* DepartmentName;
@property (nonatomic, assign) NSInteger IsDriver;
@property (nonatomic, assign) NSInteger IsAuditor;
@property (nonatomic, assign) NSInteger IsDispatcher;
@property (nonatomic, assign) NSInteger IsDeptAdmin;
@property (nonatomic, assign) NSInteger IsAdmin;
@property (nonatomic, assign) NSInteger IsSuperAdmin;
@property (nonatomic, assign) NSInteger OrgId;
@property (nonatomic, assign) NSInteger Valid;
@property (nonatomic, retain) NSString* OrgName;
@property (nonatomic, assign) NSInteger Type;
@property (nonatomic, retain) NSString* MobileVersion;
@property (nonatomic, retain) NSString* Password;
@property (nonatomic, retain) NSString* Message;

@end


@interface LoginModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,retain) NSString *Code;
@property (nonatomic, retain) NSString* Message;
@property (nonatomic, retain) UserModel* Data;

@end
