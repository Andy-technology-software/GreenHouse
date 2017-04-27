//
//  AppointmentExchange00TableViewCell.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/6/22.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AppointmentExchange00TableViewCell.h"

#import "AppointmentExchange0Model.h"
@interface AppointmentExchange00TableViewCell()
@property (nonatomic, strong) UILabel* suoxujifenLable;
@property (nonatomic, strong) UILabel* lipinguigeLable;
@property (nonatomic, strong) UILabel* duihuanNumLable;
@property (nonatomic, strong) UILabel* duihuanTypeLable;
@property (nonatomic, strong) UILabel* duihuanTypeLable1;

@end
@implementation AppointmentExchange00TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.suoxujifenLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.suoxujifenLable];
    self.suoxujifenLable.textColor = [MyController colorWithHexString:@"52525a"];
    self.suoxujifenLable.numberOfLines = 0;
    self.suoxujifenLable.font = [UIFont systemFontOfSize:14];
    
    [self.suoxujifenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
    
    self.lipinguigeLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.lipinguigeLable];
    self.lipinguigeLable.textColor = [MyController colorWithHexString:@"52525a"];
    self.lipinguigeLable.numberOfLines = 0;
    self.lipinguigeLable.font = [UIFont systemFontOfSize:14];
    
    [self.lipinguigeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.suoxujifenLable);
        make.top.mas_equalTo(self.suoxujifenLable.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(self.suoxujifenLable);
    }];
    
    self.duihuanNumLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.duihuanNumLable];
    self.duihuanNumLable.textColor = [MyController colorWithHexString:@"52525a"];
    self.duihuanNumLable.numberOfLines = 1;
    self.duihuanNumLable.font = [UIFont systemFontOfSize:14];
    
    [self.duihuanNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lipinguigeLable);
        make.right.mas_equalTo(self.lipinguigeLable);
        make.top.mas_equalTo(self.lipinguigeLable.mas_bottom).mas_offset(10);
    }];
    
    self.duihuanTypeLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.duihuanTypeLable];
    self.duihuanTypeLable.text = @"兑换方式：";
    self.duihuanTypeLable.textColor = [MyController colorWithHexString:@"52525a"];
    self.duihuanTypeLable.numberOfLines = 1;
    self.duihuanTypeLable.font = [UIFont systemFontOfSize:14];
    
    [self.duihuanTypeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.duihuanNumLable);
        make.width.mas_offset(75);
        make.top.mas_equalTo(self.duihuanNumLable.mas_bottom).mas_offset(10);
    }];
    
    self.duihuanTypeLable1 = [[UILabel alloc] init];
    [self.contentView addSubview:self.duihuanTypeLable1];
    self.duihuanTypeLable1.textColor = [MyController colorWithHexString:@"52525a"];
    self.duihuanTypeLable1.numberOfLines = 1;
    self.duihuanTypeLable1.alpha = 0.7;
    self.duihuanTypeLable1.font = [UIFont systemFontOfSize:14];
    
    [self.duihuanTypeLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.duihuanTypeLable.mas_right).mas_offset(5);
        make.top.mas_equalTo(self.duihuanTypeLable);
    }];
        self.hyb_lastViewInCell = self.duihuanTypeLable;
    self.hyb_bottomOffsetToCell = 10;
}

- (void)configCellWithModel:(AppointmentExchange0Model *)model{
    self.suoxujifenLable.text = model.jifenStr;
    [MyController fuwenbenLabel:self.suoxujifenLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(5, self.suoxujifenLable.text.length - 5) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    
    self.lipinguigeLable.text = model.guigeStr;
    [MyController fuwenbenLabel:self.lipinguigeLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(5, self.lipinguigeLable.text.length - 5) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    
    self.duihuanNumLable.text = model.duihuanNumStr;
    [MyController fuwenbenLabel:self.duihuanNumLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(4, self.duihuanNumLable.text.length - 4) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    if (model.isDingdianDuihuan) {
        self.duihuanTypeLable1.text = @"定点兑换";
    }else {
        self.duihuanTypeLable1.text = @"送货上门";
    }
}

@end
