//
//  AppointmentDetailsTableViewCell.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/6/11.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AppointmentDetailsTableViewCell.h"

#import "AppointmentDetailsModel.h"
@interface AppointmentDetailsTableViewCell()
@property (nonatomic, strong) UILabel* sendTimeLable;

@property (nonatomic, strong) UILabel* statusLable;

@property (nonatomic, strong) UILabel* successTimeLable;


@property (nonatomic, strong) UIView* lineView1;
@end
@implementation AppointmentDetailsTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.backgroundColor = [UIColor whiteColor];
    
    self.lineView1 = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView1];
    self.lineView1.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(0.5);
    }];
    
    self.sendTimeLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.sendTimeLable];
    self.sendTimeLable.numberOfLines = 1;
    self.sendTimeLable.font = [UIFont systemFontOfSize:14];
    
    [self.sendTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView1.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    self.statusLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.statusLable];
    self.statusLable.numberOfLines = 1;
    self.statusLable.font = [UIFont systemFontOfSize:14];
    
    [self.statusLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.sendTimeLable.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    self.successTimeLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.successTimeLable];
    self.successTimeLable.numberOfLines = 1;
    self.successTimeLable.font = [UIFont systemFontOfSize:14];
    
    [self.successTimeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.statusLable.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    self.hyb_lastViewInCell = self.successTimeLable;
    self.hyb_bottomOffsetToCell = 0;
    
}

- (void)configCellWithModel:(AppointmentDetailsModel *)model{
    self.sendTimeLable.text = [NSString stringWithFormat:@"提交时间：%@",model.sendTime];
    [MyController fuwenbenLabel:self.sendTimeLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(5, self.sendTimeLable.text.length - 5) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    
    if (![MyController isBlankString:model.statusStr]) {
        self.statusLable.text = [NSString stringWithFormat:@"%@",model.statusStr];
        [MyController fuwenbenLabel:self.statusLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(5, self.statusLable.text.length - 5) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    }
    
    if (![MyController isBlankString:model.compTime]) {
        self.successTimeLable.text = [NSString stringWithFormat:@"%@",model.compTime];
        [MyController fuwenbenLabel:self.successTimeLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(5, self.successTimeLable.text.length - 5) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    }
    
}
@end
