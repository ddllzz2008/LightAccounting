//
//  FamilyPerson.m
//  HomeAPP
//
//  Created by ddllzz on 16/4/22.
//  Copyright © 2016年 李方超. All rights reserved.
//

#import "FamilyPerson.h"

@implementation FamilyPerson

+(NSDictionary *)JSONKeyPathsByPropertyKey{
    return @{@"fid":@"FID",
             @"fname":@"FNAME",
             @"fsort":@"FSORT",
             @"createtime":@"CREATETIME",
             @"isedit":@"ISEDIT",};
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.fid forKey:@"fid"];
    [aCoder encodeObject:self.fname forKey:@"fname"];
    [aCoder encodeInteger:self.fsort forKey:@"fsort"];
    [aCoder encodeObject:self.createtime forKey:@"createtime"];
    [aCoder encodeObject:self.isedit forKey:@"isedit"];
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        _fid = [aDecoder decodeObjectForKey:@"fid"];
        _fname = [aDecoder decodeObjectForKey:@"fname"];
        _fsort = [aDecoder decodeIntegerForKey:@"fsort"];
        _createtime = [aDecoder decodeObjectForKey:@"createtime"];
        _isedit = [aDecoder decodeObjectForKey:@"isedit"];
    }
    return self;
}

@end
