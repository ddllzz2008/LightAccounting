//
//  NewExpenditureViewController.h
//  LightAccounting
//
//  Created by ddllzz on 17/3/26.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BaseViewController.h"
#import "NewStep1View.h"
#import "ExpendViewModel.h"

@interface NewExpenditureViewController : BaseViewController{
    
    @private NewStep1View *step1view;
    
}

@property (nonatomic,readonly) ExpendViewModel *viewmodel;

@end
