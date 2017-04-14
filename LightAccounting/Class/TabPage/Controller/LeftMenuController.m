//
//  LeftMenuController.m
//  DLZProject
//
//  Created by ddllzz on 16/12/1.
//  Copyright © 2016年 ddllzz. All rights reserved.
//

#import "LeftMenuController.h"
#import "LeftSubMenuController.h"
#import "ArchiverCache.h"
#import "LoginModel.h"

#import "UIViewController+MMDrawerController.h"

@implementation LeftMenuController

-(id)init{

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
    self = (LeftMenuController *)[storyboard instantiateViewControllerWithIdentifier:@"leftmenucontroller"];
        
    return self;
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self hiddenNavigator];
}

-(void)initViewStyle{
    
    self.btnloginout.backgroundColor = UIColorFromRGB(color_blue_01);
    
}

-(void)initControls{
    
    UserModel *currentUser = [self currentUser];
    if (currentUser!=nil) {
        [self.username setText:currentUser.Name];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"leftsubmenumap"]) {
        submenuController = (LeftSubMenuController *)segue.destinationViewController;
    }
}

/*!
 *  @brief 退出登录
 *
 *  @param sender button
 *
 *  @since 1.0
 */
- (IBAction)loginout:(id)sender {
    [ArchiverCache deleteCache:CACHE_LOGINMODEL];
    [ArchiverCache deleteCache:CACHE_STATICDATA];
    
    [self.mm_drawerController.navigationController popViewControllerAnimated:NO];
}
@end
