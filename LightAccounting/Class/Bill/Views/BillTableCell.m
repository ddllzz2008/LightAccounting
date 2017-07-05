//
//  BillTableCell.m
//  LightAccounting
//
//  Created by ddllzz on 17/4/17.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "BillTableCell.h"

@implementation BillTableCell

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
    self.contentView.backgroundColor = [UIColor clearColor];
    if (self) {
        typeLabel = [[UILabel alloc] init];
        [typeLabel setTextColor:UIColorFromRGB(0xffffff)];
        [typeLabel setTextAlignment:NSTextAlignmentLeft];
        [typeLabel setFont:fontsize_14];
        [typeLabel setText:@""];
        [self.contentView addSubview:typeLabel];
        
        @weakify(self);
        [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(self.contentView).with.offset(10);
            make.top.equalTo(self.contentView).with.offset(15);
            make.size.mas_equalTo(CGSizeMake(80, 15));
        }];
        
        spendmoneyLabel = [[UILabel alloc] init];
        [spendmoneyLabel setTextColor:UIColorFromRGB(0xffffff)];
        [spendmoneyLabel setTextAlignment:NSTextAlignmentLeft];
        [spendmoneyLabel setFont:fontsize_14];
        [spendmoneyLabel setText:@""];
        [self.contentView addSubview:spendmoneyLabel];
        
        [spendmoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(typeLabel.mas_right).with.offset(10);
            make.centerY.equalTo(typeLabel);
            make.size.mas_equalTo(CGSizeMake(280, 15));
        }];
        
        spendpercentLabel = [[UILabel alloc] init];
        [spendpercentLabel setTextColor:UIColorFromRGB(0xffffff)];
        [spendpercentLabel setTextAlignment:NSTextAlignmentRight];
        [spendpercentLabel setFont:fontsize_14];
        [spendpercentLabel setText:@""];
        [self.contentView addSubview:spendpercentLabel];
        
        [spendpercentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.right.equalTo(self.contentView.mas_right).with.offset(-10);
            make.centerY.equalTo(typeLabel);
            make.size.mas_equalTo(CGSizeMake(100, 15));
        }];
        
        progressView = [[UIProgressView alloc] init];
        progressView.progressViewStyle = UIProgressViewStyleDefault;
        progressView.trackTintColor = UIColorFromRGB(0xcccccc);
        progressView.progressTintColor = UIColorFromRGB(0xffffff);
        progressView.layer.cornerRadius = 5;
        progressView.layer.masksToBounds = YES;
        [self.contentView addSubview:progressView];
        
        [progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            @strongify(self);
            make.left.equalTo(self.mas_left).with.offset(10);
            make.right.equalTo(self.mas_right).with.offset(-10);
            make.top.equalTo(typeLabel.mas_bottom).with.offset(10);
            make.height.mas_equalTo(@8);
        }];
    }
    
    return self;
}

-(void)setTypeName:(NSString *)typeName{
    [typeLabel setText:typeName];
}

-(void)setSpendMoney:(float)spendMoney{
    [spendmoneyLabel setText:[NSString stringWithFormat:@"￥%.1f",spendMoney]];
}

-(void)setSpendPercent:(float)spendPercent{
    [spendpercentLabel setText:[NSString stringWithFormat:@"%.1f%%",spendPercent * 100]];
    
    progressView.progress = spendPercent;
}

@end
