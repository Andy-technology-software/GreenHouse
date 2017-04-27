//
//  MapListTableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/4/26.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MapListTableViewCell.h"

#import "MapListModel.h"
@interface MapListTableViewCell()
@property (nonatomic, strong) UIView* topView;

@property (nonatomic, strong) UIImageView* addressImageView;

@property (nonatomic, strong) UILabel* bianhaoLable;
@property (nonatomic, strong) UILabel* dizhiLable;
@property (nonatomic, strong) UILabel* zhuangtaiLable;
@property (nonatomic, strong) UILabel* juliLable;

@property (nonatomic, strong) UIView* lineView1;
@property (nonatomic, strong) UIView* lineView2;

@end
@implementation MapListTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.backgroundColor = [UIColor whiteColor];
    
    self.topView = [[UIView alloc] init];
    [self.contentView addSubview:self.topView];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_offset(10);
    }];
    
    self.lineView1 = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView1];
    self.lineView1.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.height.mas_offset(0.5);
    }];
    
    self.bianhaoLable = [[UILabel alloc] init];
    self.bianhaoLable.text = @"编号：";
    [self.contentView addSubview:self.bianhaoLable];
    self.bianhaoLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.bianhaoLable.numberOfLines = 0;
    self.bianhaoLable.font = [UIFont systemFontOfSize:16];
    
    [self.bianhaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.lineView1).mas_offset(5);
        make.right.mas_equalTo(-5);
    }];
    
    self.dizhiLable = [[UILabel alloc] init];
    self.dizhiLable.text = @"开发区江南南路创业大厦";
    [self.contentView addSubview:self.dizhiLable];
    self.dizhiLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.dizhiLable.numberOfLines = 0;
    self.dizhiLable.font = [UIFont systemFontOfSize:14];
    
    [self.dizhiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bianhaoLable);
        make.right.mas_equalTo(self.bianhaoLable);
        make.top.mas_equalTo(self.bianhaoLable.mas_bottom).mas_offset(10);
    }];
    
    self.addressImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.addressImageView];
    self.addressImageView.image = [UIImage imageNamed:@"新品-4"];
    
    [self.addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(self.dizhiLable.mas_bottom).mas_offset(10);
        make.height.mas_offset(14);
        make.width.mas_offset(14);
    }];
    
    self.juliLable = [[UILabel alloc] init];
    self.juliLable.text = @"0.00Km";
    [self.contentView addSubview:self.juliLable];
    self.juliLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.juliLable.numberOfLines = 0;
    self.juliLable.textAlignment = NSTextAlignmentRight;
    self.juliLable.font = [UIFont systemFontOfSize:14];
    
    [self.juliLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressImageView);
        make.right.mas_equalTo(self.addressImageView.mas_left).mas_offset(-3);
    }];
    
    self.zhuangtaiLable = [[UILabel alloc] init];
    self.zhuangtaiLable.text = @"状态：正常可投递";
    [self.contentView addSubview:self.zhuangtaiLable];
    self.zhuangtaiLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.zhuangtaiLable.numberOfLines = 0;
    self.zhuangtaiLable.font = [UIFont systemFontOfSize:14];
    
    [self.zhuangtaiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dizhiLable.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.dizhiLable);
        make.right.mas_equalTo(self.juliLable.mas_left).mas_offset(-3);
    }];
    
    self.lineView2 = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView2];
    self.lineView2.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.zhuangtaiLable.mas_bottom).mas_offset(10);
        make.height.mas_offset(0.5);
    }];
    
    self.hyb_lastViewInCell = self.lineView2;
    self.hyb_bottomOffsetToCell = 0;
}
- (void)configCellWithModel:(MapListModel *)model{
    
    self.bianhaoLable.text = model.bianhaoStr;
    
    self.dizhiLable.text = model.dizhiStr;
    
    self.zhuangtaiLable.text = model.zhunagtaiStr;
    
    self.juliLable.text = model.juliStr;
}
@end
