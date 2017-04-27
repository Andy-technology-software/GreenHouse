//
//  JiuwuDetailViewTableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/7/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "JiuwuDetailViewTableViewCell.h"

#import "JiuwuDetailModel.h"
@interface JiuwuDetailViewTableViewCell()<UITextFieldDelegate>
@property (nonatomic, strong) UILabel* statusLable;

@property (nonatomic, strong) UIImageView* statusImageView;

@property (nonatomic, strong) UIView* bgView;

@property (nonatomic, strong) UILabel* shuliangLable;

@property (nonatomic, strong) UILabel* shuliangDanweiLable;

@property (nonatomic, strong) UITextField* shuliangTF;

@property (nonatomic, strong) UILabel* jifenLable;

@property (nonatomic, strong) UILabel* jifenDanweiLable;

@property (nonatomic, strong) UILabel* jifenYuguLable;

@property (nonatomic, strong) UIView* lineView;

@end
@implementation JiuwuDetailViewTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.backgroundColor = [MyController colorWithHexString:@"f6f6f6"];
    
    self.statusImageView = [[UIImageView alloc] init];
    self.statusImageView.backgroundColor = [UIColor whiteColor];
    self.statusImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.statusImageView];
    
    [self.statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self);
        make.width.mas_offset([MyController getScreenWidth]);
        make.height.mas_offset([MyController getScreenWidth] * 9 / 16);
    }];
    
    self.statusLable = [[UILabel alloc] init];
    self.statusLable.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.statusLable];
    self.statusLable.text = @"";
    self.statusLable.numberOfLines = 1;
    self.statusLable.textAlignment = NSTextAlignmentCenter;
    self.statusLable.font = [UIFont systemFontOfSize:14];
    
    [self.statusLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.statusImageView.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_greaterThanOrEqualTo(30);
    }];
    
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.statusLable.mas_bottom).mas_offset(10);
        make.width.mas_offset([MyController getScreenWidth]);
        make.height.mas_offset(60);
    }];
    
    self.shuliangLable = [[UILabel alloc] init];
    [self.bgView addSubview:self.shuliangLable];
    self.shuliangLable.text = @"请输入预估数量";
    self.shuliangLable.numberOfLines = 1;
    self.shuliangLable.font = [UIFont systemFontOfSize:14];
    
    [self.shuliangLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.height.mas_offset(30);
    }];
    
    self.shuliangDanweiLable = [[UILabel alloc] init];
    [self.bgView addSubview:self.shuliangDanweiLable];
    self.shuliangDanweiLable.text = @"";
    self.shuliangDanweiLable.numberOfLines = 1;
    self.shuliangDanweiLable.font = [UIFont systemFontOfSize:14];
    
    [self.shuliangDanweiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shuliangLable);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(self.shuliangLable);
    }];
    
    self.shuliangTF = [MyController createTextFieldWithFrame:self.frame placeholder:@"请输入数量" passWord:NO leftImageView:nil rightImageView:nil Font:14];
    self.shuliangTF.textAlignment = NSTextAlignmentRight;
    self.shuliangTF.delegate = self;
    self.shuliangTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.bgView addSubview:self.shuliangTF];
    [self.shuliangTF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shuliangLable);
        make.right.mas_equalTo(self.shuliangDanweiLable.mas_left).mas_offset(-3);
        make.left.mas_equalTo(self.shuliangLable.mas_right);
        make.height.mas_equalTo(self.shuliangLable);
    }];
    
    
    self.jifenLable = [[UILabel alloc] init];
    [self.bgView addSubview:self.jifenLable];
    self.jifenLable.text = @"预估价";
    self.jifenLable.numberOfLines = 1;
    self.jifenLable.font = [UIFont systemFontOfSize:14];
    
    [self.jifenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shuliangLable.mas_bottom);
        make.left.mas_equalTo(self.shuliangLable);
        make.height.mas_equalTo(self.shuliangLable);
    }];
    
    self.jifenDanweiLable = [[UILabel alloc] init];
    [self.bgView addSubview:self.jifenDanweiLable];
    self.jifenDanweiLable.text = @"积分";
//    self.jifenDanweiLable.textColor = [UIColor redColor];
    self.jifenDanweiLable.numberOfLines = 1;
    self.jifenDanweiLable.font = [UIFont systemFontOfSize:14];
    
    [self.jifenDanweiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shuliangDanweiLable.mas_bottom);
        make.right.mas_equalTo(self.shuliangDanweiLable);
        make.height.mas_equalTo(self.shuliangDanweiLable);
    }];
    
    self.jifenYuguLable = [[UILabel alloc] init];
    [self.bgView addSubview:self.jifenYuguLable];
    self.jifenYuguLable.numberOfLines = 1;
    self.jifenYuguLable.textColor = [UIColor redColor];
    self.jifenYuguLable.textAlignment = NSTextAlignmentRight;
    self.jifenYuguLable.font = [UIFont systemFontOfSize:14];
    
    [self.jifenYuguLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shuliangLable.mas_bottom);
        make.left.mas_equalTo(self.jifenLable.mas_right);
        make.right.mas_equalTo(self.jifenDanweiLable.mas_left).mas_offset(-3);
        make.height.mas_equalTo(self.jifenLable);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [self.bgView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.bgView);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_offset(0.5);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 0;
    
}
- (void)configCellWithModel:(JiuwuDetailModel *)model{
    [self.statusImageView sd_setImageWithURL:[NSURL URLWithString:model.topImageStr] placeholderImage:[UIImage imageNamed:@"图层-9"]];
    
    self.statusLable.text = model.titleStr;
    
    self.shuliangTF.text = model.jianStr;
    
    NSLog(@"----%@",model.jifenStr);
    self.jifenYuguLable.text = model.jifenStr;
    
    self.shuliangDanweiLable.text = model.guigeStr;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.JiuwuDetailViewTableViewCellDelegate sendBackShuliangStr:textField.text];

}

@end

