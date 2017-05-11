//
//  PlanTableViewCell.m
//  LightAccounting
//
//  Created by ddllzz on 2017/5/8.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "PlanTableViewCell.h"

@implementation PlanTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    if (self) {
        
        __weak __typeof(self) weakself = self;
        
        double frameheight = 100;
        
        budget = [[BudgetView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, frameheight-10)];
        budget.layer.cornerRadius = 10;
        budget.headerColor = [UIColor redColor];
        [self.contentView addSubview:budget];
        
        [budget mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakself) strongself = weakself;
            make.width.equalTo(strongself);
            make.top.equalTo(strongself);
            make.left.equalTo(strongself);
            make.bottom.equalTo(strongself.mas_bottom).with.offset(-10);
        }];
        
        
        __weak __typeof(budget) budgetweakself = budget;
        
        double middleheight = ((frameheight - 10)/5) *3;
        double firstlineheight = 30;
        
        categoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, firstlineheight, firstlineheight)];
        [budget addSubview:categoryView];
        
        [categoryView mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(budgetweakself) strongself = budgetweakself;
            make.size.mas_equalTo(CGSizeMake(firstlineheight, firstlineheight));
            make.top.equalTo(strongself.mas_top).with.offset((middleheight-firstlineheight)/2);
            make.left.equalTo(strongself.mas_left).with.offset(15);
        }];
        
        categoryLabel = [[UILabel alloc] init];
        categoryLabel.textAlignment=NSTextAlignmentLeft;
        [categoryLabel setStyle:fontsize_16 color:UIColorFromRGB(0xffffff)];
        [budget addSubview:categoryLabel];
        [categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(categoryView.mas_right).with.offset(10);
            make.centerY.equalTo(categoryView);
            make.size.mas_equalTo(CGSizeMake(80, firstlineheight));
        }];
        
        planAccount = [[UILabel alloc] init];
        planAccount.textAlignment=NSTextAlignmentRight;
        [planAccount setStyle:fontsize_16 color:UIColorFromRGB(0xffffff)];
        [budget addSubview:planAccount];
        [planAccount mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(budgetweakself) strongself = budgetweakself;
            make.right.equalTo(strongself.mas_right).with.offset(-12);
            make.centerY.equalTo(categoryView);
            make.width.mas_equalTo(@90);
        }];
        
        planRemark = [[UILabel alloc] init];
        planRemark.lineBreakMode = UILineBreakModeWordWrap;
        planRemark.numberOfLines = 0;//上面两行设置多行显示
        planRemark.textAlignment=NSTextAlignmentLeft;
        [planRemark setStyle:fontsize_16 color:UIColorFromRGB(0xbbbbbb)];
        [budget addSubview:planRemark];
        [planRemark mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(budgetweakself) strongself = budgetweakself;
            make.left.equalTo(strongself).with.offset(15);
            make.right.equalTo(strongself).with.offset(-50);
            make.top.equalTo(strongself.mas_bottom).with.offset(-45);
            make.bottom.equalTo(strongself.mas_bottom).with.offset(-5);
        }];
        
        alertView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_notification"]];
        [budget addSubview:alertView];
        [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(budgetweakself) strongself = budgetweakself;
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.right.equalTo(strongself.mas_right).with.offset(-12);
            make.bottom.equalTo(strongself.mas_bottom).with.offset(-10);
        }];
    }
    
    return self;
}

-(void)setHeaderColor:(UIColor *)headerColor{
    _headerColor = headerColor;
    [budget setHeaderColor:headerColor];
}

-(void)setCategoryImage:(UIImage *)categoryImage{
    _categoryImage = categoryImage;
    [categoryView setImage:categoryImage];
}

-(void)setCategoryTtile:(NSString *)categoryTtile{
    _categoryTtile = categoryTtile;
    [categoryLabel setText:categoryTtile];
}

-(void)setAccountString:(NSString *)accountString{
    _accountString = accountString;
    [planAccount setText:accountString];
}

-(void)setRemarkString:(NSString *)remarkString{
    _remarkString = remarkString;
    [planRemark setText:remarkString];
}

-(void)setIfAlert:(BOOL)ifAlert{
    _ifAlert = ifAlert;
    alertView.hidden =!ifAlert;
}

@end
