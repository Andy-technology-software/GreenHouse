//
//  OnTheRecycling0TableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/4/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "OnTheRecycling0TableViewCell.h"

#import "OnTheRecycling0Model.h"
@interface OnTheRecycling0TableViewCell()
@property (nonatomic, strong) UILabel* fenleiLable;

@property (nonatomic, strong) UIImageView* fenleiIV;

@property (nonatomic, strong) UIView* lineView;
@end
@implementation OnTheRecycling0TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.fenleiLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.fenleiLable];
    self.fenleiLable.textColor = [MyController colorWithHexString:@"52525a"];
    self.fenleiLable.numberOfLines = 1;
    self.fenleiLable.textAlignment = NSTextAlignmentCenter;
    self.fenleiLable.font = [UIFont systemFontOfSize:14];
    
    [self.fenleiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_offset(40);
    }];
    
    self.fenleiIV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.fenleiIV];
    
    [self.fenleiIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(13);
        make.right.mas_equalTo(-5);
        make.width.mas_offset(14);
        make.height.mas_offset(14);
    }];
    
    self.lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d4d4d4"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.fenleiLable.mas_bottom).mas_offset(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_offset(0.5);
    }];
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
    
}

- (void)configCellWithModel:(OnTheRecycling0Model *)model{
    self.fenleiLable.text = model.fenleiStr;
    
    if (model.isHaveMore) {
        self.fenleiIV.image = [UIImage imageNamed:@"领取红包-返回"];
    }else{
        self.fenleiIV.image = [UIImage imageNamed:@""];
    }
}
@end
