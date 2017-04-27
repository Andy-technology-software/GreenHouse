
//
//  AppointmentToRecycleTableViewCell.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/6/5.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AppointmentToRecycleTableViewCell.h"

#import "AppointmentToRecycleModel.h"
@interface AppointmentToRecycleTableViewCell()
@property (nonatomic, strong) UILabel* successLable;
@property (nonatomic, strong) UILabel* fenleiLable;
@property (nonatomic, strong) UILabel* fenleiLable1;
@property (nonatomic, strong) UILabel* zhongliangLable;
@property (nonatomic, strong) UILabel* zhongliangLable1;
@property (nonatomic, strong) UILabel* dianhuaLable;
@property (nonatomic, strong) UILabel* dianhuaLable1;

@property (nonatomic, strong) UIView* lineView;
@end
@implementation AppointmentToRecycleTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.backgroundColor = [MyController colorWithHexString:@"f6f6f6"];
    
    self.successLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.successLable];
    self.successLable.textColor = [MyController colorWithHexString:DEFAULTCOLOR];
    self.successLable.numberOfLines = 1;
    self.successLable.text = @"预约成功";
    self.successLable.backgroundColor = [UIColor whiteColor];
    self.successLable.textAlignment = NSTextAlignmentCenter;
    self.successLable.font = [UIFont systemFontOfSize:14];
    
    [self.successLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_offset(30);
    }];
    
    self.fenleiLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.fenleiLable];
    self.fenleiLable.numberOfLines = 1;
    self.fenleiLable.text = @"分类";
    self.fenleiLable.font = [UIFont systemFontOfSize:12];
    
    [self.fenleiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.successLable.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(0);
        make.height.mas_offset(20);
    }];
    
    self.fenleiLable1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.fenleiLable1];
    self.fenleiLable1.numberOfLines = 1;
    self.fenleiLable1.layer . borderColor =[[ UIColor lightGrayColor ] CGColor ];  // 边框的颜色
    self.fenleiLable1.layer . borderWidth = 0.5 ; // 边框的宽度
    self.fenleiLable1.textColor = [MyController colorWithHexString:DEFAULTCOLOR];
    self.fenleiLable1.font = [UIFont systemFontOfSize:14];
    
    [self.fenleiLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.fenleiLable.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_offset(30);
    }];
    
    self.zhongliangLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.zhongliangLable];
    self.zhongliangLable.numberOfLines = 1;
    self.zhongliangLable.text = @"预估重量";
    self.zhongliangLable.font = [UIFont systemFontOfSize:12];
    
    [self.zhongliangLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.fenleiLable1.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(0);
        make.height.mas_offset(20);
    }];
    
    self.zhongliangLable1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.zhongliangLable1];
    self.zhongliangLable1.textColor = [MyController colorWithHexString:DEFAULTCOLOR];
    self.zhongliangLable1.numberOfLines = 1;
    self.zhongliangLable1.layer . borderColor =[[ UIColor lightGrayColor ] CGColor ];  // 边框的颜色
    self.zhongliangLable1.layer . borderWidth = 0.5 ; // 边框的宽度
    self.zhongliangLable1.font = [UIFont systemFontOfSize:14];
    
    [self.zhongliangLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.zhongliangLable.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_offset(30);
    }];
    
    
    self.dianhuaLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.dianhuaLable];
    self.dianhuaLable.numberOfLines = 2;
    self.backgroundColor = [UIColor whiteColor];
    self.dianhuaLable.text = @"工作人员将在24小时内与您联系\n请保持下面联系电话的畅通";
    self.dianhuaLable.font = [UIFont systemFontOfSize:12];
    
    [self.dianhuaLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.zhongliangLable1.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(0);
        make.height.mas_offset(40);
    }];
    
    self.dianhuaLable1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.dianhuaLable1];
    self.dianhuaLable1.textColor = [MyController colorWithHexString:DEFAULTCOLOR];
    self.dianhuaLable1.numberOfLines = 1;
    self.dianhuaLable1.layer . borderColor =[[ UIColor lightGrayColor ] CGColor ];  // 边框的颜色
    self.dianhuaLable1.layer . borderWidth = 0.5 ; // 边框的宽度
    self.dianhuaLable1.font = [UIFont systemFontOfSize:14];
    
    [self.dianhuaLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dianhuaLable.mas_bottom);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_offset(30);
    }];
    
    self.hyb_lastViewInCell = self.dianhuaLable1;
    self.hyb_bottomOffsetToCell = 0;
    
}

- (void)configCellWithModel:(AppointmentToRecycleModel *)model{
    self.fenleiLable1.text = [NSString stringWithFormat:@"   %@",model.fenleiStr];
    
    self.zhongliangLable1.text = [NSString stringWithFormat:@"   %@",model.zhongliangStr];
    
    self.dianhuaLable1.text = [NSString stringWithFormat:@"   %@",model.dianhuaStr];
}
@end
