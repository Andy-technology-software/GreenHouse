//
//  AddCommonlyUsedAddress1TableViewCell.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/5/29.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AddCommonlyUsedAddress1TableViewCell.h"

#import "AddCommonlyUsedAddress1Model.h"
@interface AddCommonlyUsedAddress1TableViewCell()
@property (nonatomic, strong) UILabel* defaultLable;

@property (nonatomic, strong) UIImageView* fenleiIV;

@end
@implementation AddCommonlyUsedAddress1TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.defaultLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.defaultLable];
    self.defaultLable.text = @"设为默认地址";
    self.defaultLable.textColor = [MyController colorWithHexString:@"52525a"];
    self.defaultLable.numberOfLines = 0;
    self.defaultLable.font = [UIFont systemFontOfSize:14];
    
    [self.defaultLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.height.mas_offset(40);
    }];
    
    self.fenleiIV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.fenleiIV];
    
    [self.fenleiIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.left.mas_equalTo(self.defaultLable.mas_right).mas_offset(5);
        make.width.mas_offset(20);
        make.height.mas_offset(20);
    }];

    self.hyb_lastViewInCell = self.defaultLable;
    self.hyb_bottomOffsetToCell = 0;
    
}

- (void)configCellWithModel:(AddCommonlyUsedAddress1Model *)model{
    if (model.isDefault) {
        self.fenleiIV.image = [UIImage imageNamed:@"创建群组2"];
    }else{
        self.fenleiIV.image = [UIImage imageNamed:@"创建群组02"];;
    }
}
@end
