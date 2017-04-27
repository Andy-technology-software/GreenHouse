//
//  MyAddressTableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/4/26.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyAddressTableViewCell.h"

#import "MyAddressModel.h"
@interface MyAddressTableViewCell()
@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) UILabel* titLable;
@property (nonatomic, strong) UILabel* telLable;
@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* defaultLable;


@end
@implementation MyAddressTableViewCell

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
    self.titLable.numberOfLines = 0;
    self.titLable.font = [UIFont systemFontOfSize:14];
    
    [self.titLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(5);
    }];
    
    self.telLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.telLable];
    self.telLable.textColor = [MyController colorWithHexString:@"52525a"];
    self.telLable.numberOfLines = 1;
    self.telLable.font = [UIFont systemFontOfSize:14];
    
    [self.telLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titLable);
        make.top.mas_equalTo(self.titLable.mas_bottom).mas_offset(10);
    }];
    
    self.defaultLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.defaultLable];
    self.defaultLable.textColor = [MyController colorWithHexString:DEFAULTCOLOR];
    self.defaultLable.numberOfLines = 1;
    self.defaultLable.textAlignment = NSTextAlignmentRight;
    self.defaultLable.font = [UIFont systemFontOfSize:14];
    
    [self.defaultLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(self.telLable);
    }];
    
    self.nameLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLable];
    self.nameLable.textColor = [MyController colorWithHexString:@"52525a"];
    self.nameLable.numberOfLines = 1;
    self.nameLable.font = [UIFont systemFontOfSize:14];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.telLable.mas_right).mas_offset(20);
        make.right.mas_equalTo(self.defaultLable.mas_left);
        make.top.mas_equalTo(self.telLable);
    }];
    
    
    self.lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_offset(0.5);
        make.top.mas_equalTo(self.telLable.mas_bottom).mas_offset(5);
    }];
        self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
    
}
- (void)configCellWithModel:(MyAddressModel *)model{
    self.titLable.text = model.titleStr;
    
    self.telLable.text = model.telStr;
    
    self.nameLable.text = model.nameStr;
    
    if (model.isdefault) {
        self.defaultLable.text = @"默认";
    }else{
        self.defaultLable.text = @"";
    }
}

@end
