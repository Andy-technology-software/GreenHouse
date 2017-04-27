//
//  OnTheRecycling2TableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/4/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "OnTheRecycling2TableViewCell.h"

#import "OnTheRecycling2Model.h"
@interface OnTheRecycling2TableViewCell()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField* zhongliangTF;

@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) UILabel* waringLable;

@property (nonatomic, strong) UIButton* xizeBtn;

@end
@implementation OnTheRecycling2TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.zhongliangTF = [[UITextField alloc] init];
    [self.contentView addSubview:self.zhongliangTF];
    self.zhongliangTF.delegate = self;
    self.zhongliangTF.keyboardType = UIKeyboardTypeNumberPad;
    self.zhongliangTF.font = [UIFont systemFontOfSize:14];
    
    [self.zhongliangTF mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    self.waringLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.waringLable];
    self.waringLable.textColor = [MyController colorWithHexString:@"52525a"];
    self.waringLable.numberOfLines = 0;
    self.waringLable.textAlignment = NSTextAlignmentCenter;
    self.waringLable.text = @"提示：我们将通过这个号码进行联系，请您确认务必正确";
    self.waringLable.font = [UIFont systemFontOfSize:12];
    
    [self.waringLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView.mas_bottom).mas_offset(5);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
    }];
    
    self.xizeBtn = [MyController createButtonWithFrame:self.frame ImageName:nil Target:self Action:@selector(xizeBtnClick) Title:nil];
    self.xizeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.xizeBtn setTitle:@"请查看回收细则" forState:UIControlStateNormal];
    [self.xizeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.xizeBtn];
    
    [self.xizeBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(self.waringLable.mas_bottom).mas_offset(20);
        make.height.mas_offset(30);
    }];
    self.hyb_lastViewInCell = self.xizeBtn;
    self.hyb_bottomOffsetToCell = 10;
    
}

- (void)xizeBtnClick{
    [self.OnTheRecycling2TableViewCellDelegate xizeClick];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.OnTheRecycling2TableViewCellDelegate sendBackTel:textField.text];
}
- (void)configCellWithModel:(OnTheRecycling2Model *)model{
    self.zhongliangTF.text = model.dianhuaStr;
    
}
@end
