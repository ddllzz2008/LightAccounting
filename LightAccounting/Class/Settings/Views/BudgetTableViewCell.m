//
//  BudgetTableViewCell.m
//  LightAccounting
//
//  Created by ddllzz on 2017/4/25.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BudgetTableViewCell.h"

@implementation BudgetView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self==[super initWithFrame:frame]) {
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(id)init{
    if (self==[super init]) {
        self.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(void)setHeaderColor:(UIColor *)headerColor{
    _headerColor = headerColor;
    [self setNeedsDisplay];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    double middleheight = (rect.size.height/5) *3;
    double height = rect.size.height;
    double width = rect.size.width;
    double radius = 10;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.headerColor.CGColor);
    
    CGContextMoveToPoint(context, 0, middleheight);  // 开始坐标左边开始
    CGContextAddArcToPoint(context, 0, 0, radius, 0, 10);
    CGContextAddArcToPoint(context, width, 0, width, radius, 10);
    CGContextAddLineToPoint(context, width, middleheight);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
    
    
    CGContextSetFillColorWithColor(context, UIColorFromRGB(0xeeeeee).CGColor);
    CGContextMoveToPoint(context, 0, middleheight);  // 开始坐标左边开始
    CGContextAddArcToPoint(context, 0, height, radius, height, 10);
    CGContextAddArcToPoint(context, width, height, width, height - radius, 10);
    CGContextAddLineToPoint(context, width, middleheight);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFill);
}

@end


@implementation BudgetTableViewCell

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
        
        double frameheight = 120;
        
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
        double firstlineheight = 40;
        
        month = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, firstlineheight, firstlineheight)];
        month.backgroundColor=[UIColor whiteColor];
        month.layer.cornerRadius = firstlineheight/2;
        month.layer.masksToBounds=YES;
        [month setTitle:@"1月" forState:UIControlStateNormal];
        [month setTitleColor:self.headerColor forState:UIControlStateNormal];
        month.tintColor=self.headerColor;
        [budget addSubview:month];
        
        [month mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(budgetweakself) strongself = budgetweakself;
            make.size.mas_equalTo(CGSizeMake(firstlineheight, firstlineheight));
            make.top.equalTo(strongself.mas_top).with.offset((middleheight-firstlineheight)/2);
            make.left.equalTo(strongself.mas_left).with.offset(15);
        }];
        
        self.inputmoney = [[UITextField alloc] init];
        self.inputmoney.textAlignment=NSTextAlignmentRight;
        [self.inputmoney setTextColor:UIColorFromRGB(0xffffff)];
        [self.inputmoney setFont:fontsize_16];
        [self.inputmoney setPlaceholder:@"输入预算"];
        self.inputmoney.keyboardType=UIKeyboardTypeDecimalPad;
        self.inputmoney.returnKeyType=UIReturnKeyDone;
        [budget addSubview:self.inputmoney];
        [self.inputmoney mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(budgetweakself) strongself = budgetweakself;
            make.right.equalTo(strongself.mas_right).with.offset(-12);
            make.centerY.equalTo(month);
            make.width.mas_equalTo(@80);
        }];
        
        actualLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        [actualLabel setStyle:fontsize_14 color:UIColorFromRGB(0xbbbbbb)];
        actualLabel.textAlignment=NSTextAlignmentLeft;
        [actualLabel setText:@"实际消费"];
        [budget addSubview:actualLabel];
        
        [actualLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(budgetweakself) strongself = budgetweakself;
            make.left.equalTo(strongself).with.offset(15);
            make.width.equalTo(strongself.mas_width).multipliedBy(0.5);
            make.height.equalTo(@20);
            make.bottom.equalTo(strongself.mas_bottom).with.offset(-20);
        }];
        
        budgetLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        [budgetLabel setStyle:fontsize_14 color:UIColorFromRGB(0xbbbbbb)];
        budgetLabel.textAlignment=NSTextAlignmentLeft;
        [budgetLabel setText:@"结余消费"];
        [budget addSubview:budgetLabel];
        
        [budgetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(budgetweakself) strongself = budgetweakself;
            make.left.equalTo(strongself).with.offset(15);
            make.width.equalTo(strongself.mas_width).multipliedBy(0.5);
            make.height.equalTo(@20);
            make.bottom.equalTo(strongself.mas_bottom).with.offset(0);
        }];
        
        actualNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        [actualNumber setStyle:fontsize_14 color:self.headerColor];
        actualNumber.textAlignment=NSTextAlignmentRight;
        [actualNumber setText:@""];
        [budget addSubview:actualNumber];
        
        [actualNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(budgetweakself) strongself = budgetweakself;
            make.right.equalTo(strongself.mas_right).with.offset(-12);
            make.width.equalTo(strongself.mas_width).multipliedBy(0.5);
            make.height.equalTo(@20);
            make.centerY.equalTo(actualLabel);
        }];
        
        budgetNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20)];
        [budgetNumber setStyle:fontsize_14 color:UIColorFromRGB(0xff0000)];
        budgetNumber.textAlignment=NSTextAlignmentRight;
        [budgetNumber setText:@""];
        [budget addSubview:budgetNumber];
        
        [budgetNumber mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(budgetweakself) strongself = budgetweakself;
            make.right.equalTo(strongself.mas_right).with.offset(-12);
            make.width.equalTo(strongself.mas_width).multipliedBy(0.5);
            make.height.equalTo(@20);
            make.centerY.equalTo(budgetLabel);
        }];
    }
    
    return self;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    [month setTitle:title forState:UIControlStateNormal];
}

-(void)setHeaderColor:(UIColor *)headerColor{
    _headerColor = headerColor;
    [month setTitleColor:headerColor forState:UIControlStateNormal];
    month.tintColor=headerColor;
    [budget setHeaderColor:headerColor];
    [actualNumber setStyle:fontsize_14 color:headerColor];
}

-(void)setActualValue:(double)actualValue{
    _actualValue = actualValue;
    [actualNumber setText:[NSString stringWithFormat:@"%.1f",actualValue]];
}

-(void)setBudgetValue:(double)budgetValue{
    _budgetValue = budgetValue;
    if (budgetValue<0) {
        [budgetNumber setStyle:fontsize_14 color:UIColorFromRGB(0xff0000)];
    }else{
        [budgetNumber setStyle:fontsize_14 color:UIColorFromRGB(0x00ff00)];
    }
    [budgetNumber setText:[NSString stringWithFormat:@"%.1f",budgetValue]];
}

@end
