//
//  CategoryTableCell.m
//  LightAccounting
//
//  Created by ddllzz on 2017/4/26.
//  Copyright © 2017年 ddllzz. All rights reserved.
//

#import "CategoryTableCell.h"

@implementation CategoryTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (selected) {
        [typenameLabel setStyle:fontsize_16 color:get_theme_color];
    }else{
        [typenameLabel setStyle:fontsize_16 color:UIColorFromRGB(0xbbbbbb)];
    }
    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self) {
        
        __weak __typeof(self.contentView) weakself = self.contentView;
        
        imagetype = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [self.contentView addSubview:imagetype];
        
        [imagetype mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakself) strongself = weakself;
            make.left.equalTo(strongself.mas_left).with.offset(10);
            make.size.mas_equalTo(CGSizeMake(30, 30));
            make.centerY.equalTo(strongself);
        }];
        
        typenameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        typenameLabel.textAlignment=NSTextAlignmentLeft;
        [typenameLabel setStyle:fontsize_16 color:UIColorFromRGB(0xbbbbbb)];
        [self.contentView addSubview:typenameLabel];
        
        [typenameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            __strong __typeof(weakself) strongself = weakself;
            make.left.equalTo(imagetype.mas_right).with.offset(10);
            make.right.equalTo(strongself.mas_right).with.offset(-10);
            make.centerY.equalTo(imagetype);
            make.height.mas_equalTo(@30);
        }];
    }
    
    return self;
}

-(void)setTypeImage:(UIImage *)typeImage{
    _typeImage = typeImage;
    [imagetype setImage:typeImage];
    
}

-(void)setTypeName:(NSString *)typeName{
    _typeName = typeName;
    [typenameLabel setText:typeName];
}

@end
