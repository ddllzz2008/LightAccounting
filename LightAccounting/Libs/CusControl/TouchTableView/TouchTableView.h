//
//  TouchTableView.h
//  LightAccounting
//
//  Created by ddllzz on 2017/4/25.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  重写UITableView的touch相关的方法，然后通过委托的方式提供给外部对象使用。首先定义Delegate：
 */
@protocol TouchTableViewDelegate <NSObject>

@optional
/**
 *  重写touch方法时必须把父类实现方法写上，否则UITableViewCell将无法正常工作。所有的改写工作如下所示，新的TableView类具有touch事件响应了。
 */
- (void)tableView:(UITableView *)tableView
     touchesBegan:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
 touchesCancelled:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
     touchesEnded:(NSSet *)touches
        withEvent:(UIEvent *)event;

- (void)tableView:(UITableView *)tableView
     touchesMoved:(NSSet *)touches
        withEvent:(UIEvent *)event;
@end

@interface TouchTableView : UITableView

@property (nonatomic,weak) id<TouchTableViewDelegate> touchDelegate;

@end
