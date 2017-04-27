//
//  AddCommonlyUsedAddress2TableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/6/3.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AddCommonlyUsedAddress2TableViewCell.h"

#import "AddCommonlyUsedAddress2Model.h"
@interface AddCommonlyUsedAddress2TableViewCell()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField* contentTF3;
@property (nonatomic, strong) UIButton* areaBtn;
@property (nonatomic, strong) UIView* lineView0;

@property (nonatomic, strong) UITextField* contentTF;
@property (nonatomic, strong) UIView* lineView;
@end
@implementation AddCommonlyUsedAddress2TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.backgroundColor = [UIColor whiteColor];
    
    self.contentTF3 = [MyController createTextFieldWithFrame:self.frame placeholder:@"请选择地区" passWord:NO leftImageView:nil rightImageView:nil Font:14];
    self.contentTF3.userInteractionEnabled = NO;
    [self.contentView addSubview:self.contentTF3];

    [self.contentTF3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_offset(40);
    }];

    self.areaBtn = [MyController createButtonWithFrame:self.frame ImageName:nil Target:self Action:@selector(areaBtnClick) Title:nil];
    self.areaBtn.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.areaBtn];
    
    [self.areaBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_offset(40);
    }];
    
    self.lineView0 = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView0];
    self.lineView0.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.contentTF3.mas_bottom);
        make.height.mas_offset(0.5);
    }];
    
    self.contentTF = [MyController createTextFieldWithFrame:self.frame placeholder:@"请输入详细地址" passWord:NO leftImageView:nil rightImageView:nil Font:14];
    self.contentTF.delegate = self;
    [self.contentView addSubview:self.contentTF];
    
    [self.contentTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView0.mas_bottom);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_offset(40);
    }];
    
    self.lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.contentTF.mas_bottom);
        make.height.mas_offset(0.5);
    }];
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
    
}
- (void)configCellWithModel:(AddCommonlyUsedAddress2Model *)model{
    self.contentTF.text = model.detailStr;
    if ([MyController isBlankString:model.provinceStr]) {
        self.contentTF3.text = @"";
    }else{
        if ([@"上海市" isEqualToString:model.provinceStr] || [@"北京市" isEqualToString:model.provinceStr] || [@"天津市" isEqualToString:model.provinceStr]  || [@"重庆市" isEqualToString:model.provinceStr]) {
            self.contentTF3.text = [NSString stringWithFormat:@"%@ %@",model.cityStr,model.areaStr];
        }else{
            self.contentTF3.text = [NSString stringWithFormat:@"%@ %@ %@",model.provinceStr,model.cityStr,model.areaStr];
        }
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    //    [self.AddCommonlyUsedAddressTableViewCellDelegate sendBackStr:textField.text];
    [self.AddCommonlyUsedAddress2TableViewCellDelegate send2BackStr:textField.text AndCellIndex:self.cellIndex];
}
- (void)areaBtnClick{
    [self.contentTF3 resignFirstResponder];
    [self.contentTF resignFirstResponder];
    GPDateView * dateView = [[GPDateView alloc] initWithFrame:CGRectMake(0, [MyController getScreenHeight]-250, [MyController getScreenWidth], 250) Data:nil];
    [dateView showPickerView];
    
    dateView.ActionDistrictViewSelectBlock = ^(NSString *desStr,NSDictionary *selectDistrictDict){
        [self.AddCommonlyUsedAddress2TableViewCellDelegate send2BackAreaStr:[selectDistrictDict objectForKey:@"DistrictSelectProvince"] andCityStr:[selectDistrictDict objectForKey:@"DistrictSelectCity"] andAreaStr:[selectDistrictDict objectForKey:@"DistrictSelectProvinceSub"]];
    };
}
@end
