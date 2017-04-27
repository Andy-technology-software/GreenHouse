//
//  OnTheRecycling1TableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/4/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "OnTheRecycling1TableViewCell.h"

#import "OnTheRecycling1Model.h"
@interface OnTheRecycling1TableViewCell()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField* zhongliangTF;

@property (nonatomic, strong) UILabel* danweiLable;

@property (nonatomic, strong) UIView* lineView;
@end
@implementation OnTheRecycling1TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.danweiLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.danweiLable];
    self.danweiLable.textColor = [MyController colorWithHexString:@"52525a"];
    self.danweiLable.numberOfLines = 1;
    self.danweiLable.text = @"KG";
    self.danweiLable.font = [UIFont systemFontOfSize:14];
    
    [self.danweiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.width.mas_offset(30);
        make.height.mas_offset(40);
    }];
    
    self.zhongliangTF = [[UITextField alloc] init];
    [self.contentView addSubview:self.zhongliangTF];
    self.zhongliangTF.delegate = self;
    self.zhongliangTF.keyboardType = UIKeyboardTypeNumberPad;
    self.zhongliangTF.textAlignment = NSTextAlignmentRight;
    self.zhongliangTF.font = [UIFont systemFontOfSize:14];
    
    [self.zhongliangTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.danweiLable);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(self.danweiLable.mas_left).mas_offset(-10);
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
- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.OnTheRecycling1TableViewCellDelegate sendBackZhongliang:textField.text];
}
- (void)configCellWithModel:(OnTheRecycling1Model *)model{
    self.zhongliangTF.text = model.zhongliangStr;
    if (model.isJuanzeng) {
        self.danweiLable.text = @"积分";
    }
}
@end
