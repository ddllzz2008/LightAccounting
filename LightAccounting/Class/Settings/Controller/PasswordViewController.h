//
//  PasswordViewController.h
//  LightAccounting
//
//  Created by ddllzz on 17/4/19.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewController.h"
#import "TapPassView.h"
#import "UILabel+Style.h"
#import "NSString+ExtMethod.h"

@interface PasswordViewController : BaseViewController<TapPassViewDelegate>{
    
    TapPassView *tappassview;
    UILabel *alertLabel;
    
    BOOL ifresetPassword;
    NSString *firstPassword;
    NSString *secondPassword;
    NSString *oldPassword;
}

@end
