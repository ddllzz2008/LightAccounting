//
//  LoginModel.m
//  DLZProject
//
//  Created by ddllzz on 16/12/21.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"Code":@"Code",
             @"Message":@"Message",
             @"Data":@"Data"
    };
}

+ (NSValueTransformer *)DataJSONTransformer
{
    return [MTLJSONAdapter dictionaryTransformerWithModelClass:UserModel.class];
}

//-(void)encodeWithCoder:(NSCoder *)coder{
//    [coder encodeObject:_Code forKey:@"Code"];
//    [coder encodeObject:_Message forKey:@"Message"];
//    [coder encodeObject:_Data forKey:@"Data"];
//}
//
//-(id)initWithCoder:(NSCoder *)coder{
//    
//}

@end

@implementation UserModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"Id":@"Id",
             @"Code":@"Code",
             @"Name":@"Name",
             @"Email":@"Email",
             @"MobilePhone":@"MobilePhone",
             @"Gender":@"Gender",
             @"ChineseName":@"ChineseName",
             @"Photo":@"Photo",
             @"Address":@"Address",
             @"Birthday":@"Birthday",
             @"DepartmentId":@"DepartmentId",
             @"DepartmentName":@"DepartmentName",
             @"IsDriver":@"IsDriver",
             @"IsAuditor":@"IsAuditor",
             @"IsDispatcher":@"IsDispatcher",
             @"IsDeptAdmin":@"IsDeptAdmin",
             @"IsAdmin":@"IsAdmin",
             @"IsSuperAdmin":@"IsSuperAdmin",
             @"OrgId":@"OrgId",
             @"Valid":@"Valid",
             @"OrgName":@"OrgName",
             @"Type":@"Type",
             @"MobileVersion":@"MobileVersion",
             @"Password":@"Password",
             @"Message":@"Message"
    };
}

-(void)encodeWithCoder:(NSCoder *)coder{
    [coder encodeInteger:_Id forKey:@"Id"];
    [coder encodeObject:_Name forKey:@"Name"];
    [coder encodeObject:_Code forKey:@"Code"];
    [coder encodeObject:_Email forKey:@"Email"];
    [coder encodeObject:_MobilePhone forKey:@"MobilePhone"];
    [coder encodeObject:_Gender forKey:@"Gender"];
    [coder encodeObject:_ChineseName forKey:@"ChineseName"];
    [coder encodeObject:_Photo forKey:@"Photo"];
    [coder encodeObject:_Address forKey:@"Address"];
    [coder encodeObject:_Birthday forKey:@"Birthday"];
    [coder encodeInteger:_DepartmentId forKey:@"DepartmentId"];
    [coder encodeObject:_DepartmentName forKey:@"DepartmentName"];
    [coder encodeInteger:_IsDriver forKey:@"IsDriver"];
    [coder encodeInteger:_IsAuditor forKey:@"IsAuditor"];
    [coder encodeInteger:_IsDispatcher forKey:@"IsDispatcher"];
    [coder encodeInteger:_IsDeptAdmin forKey:@"IsDeptAdmin"];
    [coder encodeInteger:_IsAdmin forKey:@"IsAdmin"];
    [coder encodeInteger:_IsSuperAdmin forKey:@"IsSuperAdmin"];
    [coder encodeInteger:_OrgId forKey:@"OrgId"];
    [coder encodeInteger:_Valid forKey:@"Valid"];
    [coder encodeObject:_OrgName forKey:@"OrgName"];
    [coder encodeInteger:_Type forKey:@"Type"];
    [coder encodeObject:_MobileVersion forKey:@"MobileVersion"];
    [coder encodeObject:_Password forKey:@"Password"];
    [coder encodeObject:_Message forKey:@"Message"];
}

-(id)initWithCoder:(NSCoder *)coder{
    if (self = [super init]) {
        self.Id = [coder decodeIntegerForKey:@"Id"];
        self.Name = [coder decodeObjectForKey:@"Name"];
        self.Code = [coder decodeObjectForKey:@"Code"];
        self.Email = [coder decodeObjectForKey:@"Email"];
        self.MobilePhone = [coder decodeObjectForKey:@"MobilePhone"];
        self.Gender = [coder decodeObjectForKey:@"Gender"];
        self.ChineseName = [coder decodeObjectForKey:@"ChineseName"];
        self.Photo = [coder decodeObjectForKey:@"Photo"];
        self.Address = [coder decodeObjectForKey:@"Address"];
        self.Birthday = [coder decodeObjectForKey:@"Birthday"];
        self.DepartmentId = [coder decodeIntegerForKey:@"DepartmentId"];
        self.DepartmentName = [coder decodeObjectForKey:@"DepartmentName"];
        self.IsDriver = [coder decodeIntegerForKey:@"IsDriver"];
        self.IsAuditor = [coder decodeIntegerForKey:@"IsAuditor"];
        self.IsDispatcher= [coder decodeIntegerForKey:@"IsDispatcher"];
        self.IsDeptAdmin = [coder decodeIntegerForKey:@"IsDeptAdmin"];
        self.IsAdmin = [coder decodeIntegerForKey:@"IsAdmin"];
        self.IsSuperAdmin = [coder decodeIntegerForKey:@"IsSuperAdmin"];
        self.OrgId = [coder decodeIntegerForKey:@"OrgId"];
        self.Valid = [coder decodeIntegerForKey:@"Valid"];
        self.OrgName = [coder decodeObjectForKey:@"OrgName"];
        self.Type = [coder decodeIntegerForKey:@"Type"];
        self.MobileVersion = [coder decodeObjectForKey:@"MobileVersion"];
        self.Password = [coder decodeObjectForKey:@"Password"];
        self.Message = [coder decodeObjectForKey:@"Message"];
    }
    
    return self;
}

@end
