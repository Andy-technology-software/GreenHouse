//
//  DeliverySuccessTableViewCell.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/4/24.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "DeliverySuccessTableViewCell.h"

#import "DeliverySuccessModel.h"
@interface DeliverySuccessTableViewCell()
@property (nonatomic, strong) UIImageView* successIV;
@property (nonatomic, strong) UILabel* successLable;

@property (nonatomic, strong) UIView* bgView1;
@property (nonatomic, strong) UIView* bgView2;

@end
@implementation DeliverySuccessTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.backgroundColor = [MyController colorWithHexString:@"f6f6f6"];
    
    self.successIV = [[UIImageView alloc] init];
    self.successIV.image = [UIImage imageNamed:@""];
    [self.contentView addSubview:self.successIV];
    
    [self.successIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(self);
        make.width.mas_offset(80);
        make.height.mas_offset(80);
    }];
    
    self.successLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.successLable];
    self.successLable.text = @"投递成功";
    self.successLable.numberOfLines = 1;
    self.successLable.textAlignment = NSTextAlignmentCenter;
    self.successLable.font = [UIFont systemFontOfSize:18];
    
    [self.successLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.successIV.mas_bottom).mas_offset(20);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_offset(18);
    }];
    
    self.bgView1 = [[UIView alloc] init];
    self.bgView1.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView1];
    [self.bgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.successLable.mas_bottom).mas_offset(40);
        make.height.mas_offset(80);
    }];
    
    self.bgView2 = [[UIView alloc] init];
    self.bgView2.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView2];
    [self.bgView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.bgView1.mas_bottom).mas_offset(40);
        make.height.mas_offset(40);
    }];
    
    self.hyb_lastViewInCell = self.bgView2;
    self.hyb_bottomOffsetToCell = 20;
    
}
- (void)configCellWithModel:(DeliverySuccessModel *)model{
    for (int i = 0; i < 2; i++) {
        UILabel* temLable = [MyController createLabelWithFrame:CGRectMake(0, 40 * i, [MyController getScreenWidth], 40) Font:14 Text:model.weightStrAdnintegralStrArr[i]];
        [self.bgView1 addSubview:temLable];
        
        if (i > 0) {
            UIView* lineView = [MyController viewWithFrame:CGRectMake(0, 40, [MyController getScreenWidth], 0.5)];
            lineView.backgroundColor = [MyController colorWithHexString:@"d4d4d4"];
            [self.bgView1 addSubview:lineView];
        }
    }
    
    UILabel* temLable = [MyController createLabelWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40) Font:14 Text:model.totalIntegralStr];
    [self.bgView2 addSubview:temLable];
}
@end
