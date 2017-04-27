//
//  OnTheRecyclingAddressTableViewCell.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/7/18.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "OnTheRecyclingAddressTableViewCell.h"

#import "OnTheRecyclingAddModel.h"
@interface OnTheRecyclingAddressTableViewCell()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel* zhongliangTF;

@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) UIView* bgView;

@property (nonatomic, strong) UIButton* xizeBtn;

@end
@implementation OnTheRecyclingAddressTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.zhongliangTF = [[UILabel alloc] init];
    [self.contentView addSubview:self.zhongliangTF];
    self.zhongliangTF.numberOfLines = 1;
    self.zhongliangTF.font = [UIFont systemFontOfSize:14];
    
    [self.zhongliangTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_offset(40);
    }];
    
    self.xizeBtn = [MyController createButtonWithFrame:self.zhongliangTF.frame ImageName:nil Target:self Action:@selector(xizeBtnClick) Title:nil];
    [self.contentView addSubview:self.xizeBtn];
    
    [self.xizeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_offset(40);
    }];
    
    self.lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d4d4d4"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.zhongliangTF.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_offset(0.5);
    }];
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
    
}

- (void)xizeBtnClick{
    [self.OnTheRecyclingAddressTableViewCellDelegate sendBackSeleAddress];
}

- (void)configCellWithModel:(OnTheRecyclingAddModel *)model{
    self.zhongliangTF.text = model.addressStr;
    
}
@end
