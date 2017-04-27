//
//  RecyclingCarTableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/7/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "RecyclingCarTableViewCell.h"

#import "RecyclingCarModel.h"
@interface RecyclingCarTableViewCell()
@property (nonatomic, strong) UIButton* selectBtn;

@property (nonatomic, strong) UIButton* selectBtn1;

@property (nonatomic, strong) UIImageView* headImageView;

@property (nonatomic, strong) UILabel* titleLable;

@property (nonatomic, strong) UILabel* numLable;

@property (nonatomic, strong) UILabel* priceLable;

@property (nonatomic, strong) UIView* lineView;

@end
@implementation RecyclingCarTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.selectBtn = [MyController createButtonWithFrame:self.frame ImageName:@"" Target:self Action:@selector(selectBtnClick) Title:nil];
    [self.contentView addSubview:self.selectBtn];
    
    [self.selectBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self);
        make.height.mas_offset(20);
        make.width.mas_offset(20);
    }];
    
    self.selectBtn1 = [MyController createButtonWithFrame:self.frame ImageName:@"" Target:self Action:@selector(selectBtnClick) Title:nil];
    [self.contentView addSubview:self.selectBtn1];
    
    [self.selectBtn1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.centerY.mas_equalTo(self);
        make.height.mas_offset(40);
        make.width.mas_offset(40);
    }];
    
    self.headImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headImageView];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(self.selectBtn.mas_right).mas_offset(5);
        make.height.mas_offset(80);
        make.width.mas_offset(80);
    }];
    
    self.titleLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.titleLable];
    self.titleLable.numberOfLines = 0;
    self.titleLable.font = [UIFont systemFontOfSize:14];
    
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView);
        make.left.mas_equalTo(self.headImageView.mas_right).mas_offset(5);
        make.right.mas_equalTo(-5);
    }];
    
    self.numLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.numLable];
    self.numLable.numberOfLines = 0;
    self.numLable.font = [UIFont systemFontOfSize:14];
    
    [self.numLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLable.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.titleLable);
        make.right.mas_equalTo(self.titleLable);
    }];
    
    self.priceLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.priceLable];
    self.priceLable.numberOfLines = 0;
    self.priceLable.font = [UIFont systemFontOfSize:14];
    
    [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.numLable.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.numLable);
        make.right.mas_equalTo(self.numLable);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [self.contentView addSubview:self.lineView];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.priceLable.mas_bottom).mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_offset(0.5);
    }];
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
}
- (void)configCellWithModel:(RecyclingCarModel *)model{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.headImageStr] placeholderImage:[UIImage imageNamed:@""]];
    
    self.titleLable.text = model.titleStr;
    
    self.numLable.text = model.numStr;
    
    self.priceLable.text = model.priceStr;
    [MyController fuwenbenLabel:self.priceLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(4, self.priceLable.text.length - 4) AndColor:[UIColor redColor]];
    
    if (!model.isFromMakesure) {
        if (model.isSelected) {
            [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"爱点击"] forState:UIControlStateNormal];
        }else{
            [self.selectBtn setBackgroundImage:[UIImage imageNamed:@"不爱点击"] forState:UIControlStateNormal];
        }
    }else{
        [self.selectBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [self.selectBtn mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(self);
            make.height.mas_offset(0);
            make.width.mas_offset(0);
        }];
    }
    
}

- (void)selectBtnClick{
    [self.RecyclingCarTableViewCellDelegate sendBackSelectCarNum:self.cellIndex];
}
@end
