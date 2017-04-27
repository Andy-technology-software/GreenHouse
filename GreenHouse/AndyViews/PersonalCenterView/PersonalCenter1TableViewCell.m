//
//  PersonalCenter1TableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "PersonalCenter1TableViewCell.h"

#import "PersonalCenter1Model.h"
@interface PersonalCenter1TableViewCell()
@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) UIImageView* infoImageView;

@property (nonatomic, strong) UILabel* titLable;


@end
@implementation PersonalCenter1TableViewCell

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
}

@end
