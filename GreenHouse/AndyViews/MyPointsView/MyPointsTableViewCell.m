//
//  MyPointsTableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/4/26.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyPointsTableViewCell.h"

#import "MyPointsModel.h"
@interface MyPointsTableViewCell()
@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* lineView1;

@property (nonatomic, strong) UILabel* jifenLable;
@property (nonatomic, strong) UILabel* jifenLable1;
@property (nonatomic, strong) UILabel* titleLable;
@property (nonatomic, strong) UILabel* timeLable;

@property (nonatomic, strong) UIImageView* nextImageView;

@end
@implementation MyPointsTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.jifenLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.jifenLable];
    self.jifenLable.textColor = [MyController colorWithHexString:DEFAULTCOLOR];
    self.jifenLable.numberOfLines = 0;
    self.jifenLable.textAlignment = NSTextAlignmentCenter;
    self.jifenLable.font = [UIFont systemFontOfSize:16];
    
    [self.jifenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.centerY.mas_equalTo(self.contentView).mas_offset(-5);
        make.width.mas_offset(60);
        make.height.mas_offset(14);
    }];
    
    self.jifenLable1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.jifenLable1];
    self.jifenLable1.textColor = [MyController colorWithHexString:@"52525a"];
    self.jifenLable1.numberOfLines = 0;
    self.jifenLable1.text = @"积分";
    self.jifenLable1.textAlignment = NSTextAlignmentCenter;
    self.jifenLable1.font = [UIFont systemFontOfSize:10];
    
    [self.jifenLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(self.jifenLable.mas_bottom).mas_offset(2);
        make.width.mas_offset(60);
        make.height.mas_offset(12);
    }];
    
    self.lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.jifenLable.mas_right);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(self);
        make.width.mas_offset(0.5);
//        make.height.mas_offset(100);
    }];
    
    self.titleLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLable];
    self.titleLable.textColor = [MyController colorWithHexString:@"52525a"];
    self.titleLable.numberOfLines = 0;
    self.titleLable.font = [UIFont systemFontOfSize:14];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView.mas_right).mas_offset(5);
        make.top.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
    
    self.timeLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.timeLable];
    self.timeLable.textColor = [MyController colorWithHexString:@"52525a"];
    self.timeLable.numberOfLines = 1;
    self.timeLable.font = [UIFont systemFontOfSize:14];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLable);
        make.top.mas_equalTo(self.titleLable.mas_bottom).mas_offset(5);
    }];
    
    
    self.lineView1 = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView1];
    self.lineView1.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_offset(0.5);
        make.top.mas_equalTo(self.timeLable.mas_bottom).mas_offset(5);
    }];
    
//    self.nextImageView = [UIImageView alloc] init
    self.nextImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.nextImageView];
    
    [self.nextImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.centerY.mas_equalTo(self.contentView);
        make.height.mas_offset(15);
        make.width.mas_offset(15);
    }];

    self.hyb_lastViewInCell = self.lineView1;
    self.hyb_bottomOffsetToCell = 0;
    
}
- (void)configCellWithModel:(MyPointsModel *)model{
    self.jifenLable.text = model.jifenStr;
    
    self.titleLable.text = model.titleStr;
    
    self.timeLable.text = model.timeStr;
    
    if (model.isFromBack) {
        self.nextImageView.image = [UIImage imageNamed:@"领取红包-返回"];
    }else{
        self.nextImageView.image = [UIImage imageNamed:@""];
    }
}

@end
