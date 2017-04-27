//
//  MyRecoveryDetailS2TableViewCell.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/8/7.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyRecoveryDetailS2TableViewCell.h"

#import "MyRecoveryDetailS1Model.h"
@interface MyRecoveryDetailS2TableViewCell()
@property (nonatomic, strong) UILabel* zhuangtaiLable;

@property (nonatomic, strong) UILabel* lianxirenLable;
@end
@implementation MyRecoveryDetailS2TableViewCell

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

    self.hyb_lastViewInCell = self.lianxirenLable;
    self.hyb_bottomOffsetToCell = 10;
    
}

- (void)configCellWithModel:(MyRecoveryDetailS1Model *)model{
    self.zhuangtaiLable.text = [NSString stringWithFormat:@"预约时间：%@",model.yuyueStr];
    [MyController fuwenbenLabel:self.zhuangtaiLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(5, self.zhuangtaiLable.text.length - 5) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    
    self.lianxirenLable.text = [NSString stringWithFormat:@"回收时间：%@",model.huishouStr];
    [MyController fuwenbenLabel:self.lianxirenLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(5, self.lianxirenLable.text.length - 5) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
}



@end
