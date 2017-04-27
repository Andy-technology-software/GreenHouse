//
//  MyRecoveryDetailS0TableViewCell.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/8/7.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyRecoveryDetailS0TableViewCell.h"

#import "MyRecoveryDetailS0Model.h"
@interface MyRecoveryDetailS0TableViewCell()
@property (nonatomic, strong) UILabel* zhuangtaiLable;

@property (nonatomic, strong) UILabel* lianxirenLable;

@property (nonatomic, strong) UILabel* dizhiLable;

@property (nonatomic, strong) UILabel* dianhuaLable;
@end
@implementation MyRecoveryDetailS0TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.zhuangtaiLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.zhuangtaiLable];
    self.zhuangtaiLable.numberOfLines = 0;
    self.zhuangtaiLable.font = [UIFont systemFontOfSize:14];
    
    [self.zhuangtaiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
    
    self.lianxirenLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.lianxirenLable];
    self.lianxirenLable.numberOfLines = 0;
    self.lianxirenLable.font = [UIFont systemFontOfSize:14];
    
    [self.lianxirenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.zhuangtaiLable.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.zhuangtaiLable);
        make.right.mas_equalTo(self.zhuangtaiLable);
    }];
    
    
    self.dizhiLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.dizhiLable];
    self.dizhiLable.numberOfLines = 0;
    self.dizhiLable.font = [UIFont systemFontOfSize:14];
    
    [self.dizhiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lianxirenLable.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.lianxirenLable);
        make.right.mas_equalTo(self.lianxirenLable);
    }];
    
    
    self.dianhuaLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.dianhuaLable];
    self.dianhuaLable.numberOfLines = 0;
    self.dianhuaLable.font = [UIFont systemFontOfSize:14];
    
    [self.dianhuaLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dizhiLable.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(self.dizhiLable);
        make.right.mas_equalTo(self.dizhiLable);
    }];
    
    self.hyb_lastViewInCell = self.dianhuaLable;
    self.hyb_bottomOffsetToCell = 10;

}

- (void)configCellWithModel:(MyRecoveryDetailS0Model *)model{
    self.zhuangtaiLable.text = [NSString stringWithFormat:@"状       态：%@",model.zhuangtaiStr];
    [MyController fuwenbenLabel:self.zhuangtaiLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(10, self.zhuangtaiLable.text.length - 10) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    
    self.lianxirenLable.text = [NSString stringWithFormat:@"联  系  人：%@",model.lianxirenStr];
    
    self.dizhiLable.text = [NSString stringWithFormat:@"回收地址：%@",model.dizhiStr];
    
    self.dianhuaLable.text = [NSString stringWithFormat:@"联系电话：%@",model.dianhuaStr];
}



@end
