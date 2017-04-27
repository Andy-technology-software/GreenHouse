//
//  MyProfileView1TableViewCell.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyProfileView1TableViewCell.h"

#import "PersonalCenter1Model.h"
@interface MyProfileView1TableViewCell()
@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) UIImageView* infoImageView;

@property (nonatomic, strong) UILabel* titLable;
@property (nonatomic, strong) UILabel* titLable1;

@end
@implementation MyProfileView1TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.titLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.titLable];
    self.titLable.textColor = [MyController colorWithHexString:@"52525a"];
    self.titLable.numberOfLines = 1;
    self.titLable.font = [UIFont systemFontOfSize:14];
    
    [self.titLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(39.5);
    }];
    
    self.titLable1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.titLable1];
    self.titLable1.textColor = [MyController colorWithHexString:@"52525a"];
    self.titLable1.numberOfLines = 1;
    self.titLable1.textAlignment = NSTextAlignmentRight;
    self.titLable1.font = [UIFont systemFontOfSize:14];
    
    [self.titLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titLable.mas_left);
        make.right.mas_equalTo(-45);
        make.top.mas_equalTo(self.titLable);
        make.height.mas_equalTo(self.titLable);
    }];
    
    self.infoImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.infoImageView];
    self.infoImageView.image = [UIImage imageNamed:@"领取红包-返回"];
    
    [self.infoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(10);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
    }];
    
    self.lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_offset(0.5);
        make.top.mas_equalTo(self.titLable.mas_bottom);
    }];
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
    
}
- (void)configCellWithModel:(PersonalCenter1Model *)model{
    self.titLable.text = model.titleStr;
    
    self.titLable1.text = model.titleStr1;
    
    if ([@"手机号" isEqualToString:model.titleStr]) {
        self.infoImageView.image = [UIImage imageNamed:@""];
    }
}

@end
