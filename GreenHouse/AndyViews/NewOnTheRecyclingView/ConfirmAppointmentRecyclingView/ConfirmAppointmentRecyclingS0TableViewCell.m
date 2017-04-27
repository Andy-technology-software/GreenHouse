//
//  ConfirmAppointmentRecyclingS0TableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/7/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "ConfirmAppointmentRecyclingS0TableViewCell.h"

#import "ConfirmAppointmentRecyclingS0Model.h"
@interface ConfirmAppointmentRecyclingS0TableViewCell()
@property (nonatomic, strong) UIButton* selectBtn;

@property (nonatomic, strong) UIImageView* addressImageView;

@property (nonatomic, strong) UILabel* contentAndTelLable;

@property (nonatomic, strong) UILabel* addressLable;

@property (nonatomic, strong) UIView* lineView;

@end
@implementation ConfirmAppointmentRecyclingS0TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.addressImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.addressImageView];
    
    [self.addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
    }];
    
    self.selectBtn = [MyController createButtonWithFrame:self.frame ImageName:@"edit" Target:self Action:@selector(selectBtnClick) Title:nil];
    [self.contentView addSubview:self.selectBtn];
    
    [self.selectBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.centerY.mas_equalTo(self);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
    }];
    
    self.contentAndTelLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.contentAndTelLable];
    self.contentAndTelLable.numberOfLines = 0;
    self.contentAndTelLable.font = [UIFont systemFontOfSize:14];
    
    [self.contentAndTelLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(self.addressImageView.mas_right).mas_offset(5);
        make.right.mas_equalTo(self.selectBtn.mas_left).mas_offset(-5);
    }];
    
    self.addressLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.addressLable];
    self.addressLable.numberOfLines = 0;
    self.addressLable.font = [UIFont systemFontOfSize:14];
    
    [self.addressLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentAndTelLable.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.contentAndTelLable);
        make.right.mas_equalTo(self.contentAndTelLable);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"f6f6f6"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressLable.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_offset(10);
    }];
        self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
}

-(void)configCellWithModel:(ConfirmAppointmentRecyclingS0Model *)model{
    if (model.isHaveAddress) {
        self.contentAndTelLable.text = [NSString stringWithFormat:@"联系人：%@   %@",model.contectStr,model.telStr];
        
        self.addressLable.text = model.addressStr;
        
        self.addressImageView.image = [UIImage imageNamed:@"location"];
        
    }else{
        self.contentAndTelLable.text = @"请选择地址";
        
        self.addressImageView.image = [UIImage imageNamed:@""];
    }
}
- (void)selectBtnClick{
    
}

@end
