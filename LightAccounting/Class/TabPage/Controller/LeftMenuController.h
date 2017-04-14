//
//  LeftMenuController.h
//  DLZProject
//
//  Created by ddllzz on 16/12/1.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "BaseViewController.h"

@class LeftSubMenuController;

@interface LeftMenuController : BaseViewController{
    LeftSubMenuController *submenuController;
}

@property (weak, nonatomic) IBOutlet UILabel *username;

@property (weak, nonatomic) IBOutlet UIImageView *userphoto;

@property (weak, nonatomic) IBOutlet UIButton *btnloginout;


@property (weak, nonatomic) IBOutlet UILabel *lastdate;

- (IBAction)loginout:(id)sender;


@end
