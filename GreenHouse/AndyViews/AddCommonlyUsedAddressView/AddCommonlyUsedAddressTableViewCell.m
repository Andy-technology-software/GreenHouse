//
//  AddCommonlyUsedAddressTableViewCell.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/5/29.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AddCommonlyUsedAddressTableViewCell.h"

#import "AddCommonlyUsedAddressModel.h"
@interface AddCommonlyUsedAddressTableViewCell()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField* contentTF;
@property (nonatomic, strong) UIView* lineView1;

@end
@implementation AddCommonlyUsedAddressTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.backgroundColor = [UIColor whiteColor];
    
    self.contentTF = [MyController createTextFieldWithFrame:self.frame placeholder:nil passWord:NO leftImageView:nil rightImageView:nil Font:14];
    self.contentTF.delegate = self;
    [self.contentView addSubview:self.contentTF];
    
    [self.contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_offset(40);
    }];
    
    self.lineView1 = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView1];
    self.lineView1.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.contentTF.mas_bottom);
        make.height.mas_offset(0.5);
    }];
    
    self.hyb_lastViewInCell = self.lineView1;
    self.hyb_bottomOffsetToCell = 0;
    
}
- (void)configCellWithModel:(AddCommonlyUsedAddressModel *)model{
    self.contentTF.text = model.contentStr;
    self.contentTF.placeholder = model.placeStr;
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
//    [self.AddCommonlyUsedAddressTableViewCellDelegate sendBackStr:textField.text];
    [self.AddCommonlyUsedAddressTableViewCellDelegate sendBackStr:textField.text AndCellIndex:self.cellIndex];
}

@end
