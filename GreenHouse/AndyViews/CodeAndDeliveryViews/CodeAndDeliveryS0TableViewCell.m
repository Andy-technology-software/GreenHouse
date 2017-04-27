//
//  CodeAndDeliveryS0TableViewCell.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/4/24.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "CodeAndDeliveryS0TableViewCell.h"

#import "CodeAndDeliveryS0Model.h"
@interface CodeAndDeliveryS0TableViewCell()
@property (nonatomic, strong) UILabel* statusLable;

@property (nonatomic, strong) UIImageView* statusImageView;

@property (nonatomic, strong) UIView* bgView;

@end
@implementation CodeAndDeliveryS0TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.backgroundColor = [MyController colorWithHexString:@"f6f6f6"];
    
    self.statusImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.statusImageView];
    
    [self.statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(self);
        make.width.mas_offset(120);
        make.height.mas_offset(120 * 423 / 413);
    }];
    
    self.statusLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.statusLable];
    self.statusLable.text = @"状态：";
    self.statusLable.numberOfLines = 1;
    self.statusLable.textAlignment = NSTextAlignmentCenter;
    self.statusLable.font = [UIFont systemFontOfSize:14];
    
    [self.statusLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.statusImageView.mas_bottom);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_offset(40);
    }];
    
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.statusLable.mas_bottom).mas_offset(40);
        make.height.mas_offset(120);
    }];
    
    self.hyb_lastViewInCell = self.bgView;
    self.hyb_bottomOffsetToCell = 20;

}
- (void)configCellWithModel:(CodeAndDeliveryS0Model *)model{
    [self.statusImageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"图层-9"]];
    
    self.statusLable.text = model.toudiStatusStr;
    
    for (int i = 0; i < 3; i++) {
        UILabel* temLable =[MyController createLabelWithFrame:CGRectMake(0, 40 * i, [MyController getScreenWidth], 40) Font:14 Text:model.titleArr[i]];
        temLable.textAlignment = NSTextAlignmentLeft;
        [self.bgView addSubview:temLable];
        
        if (i > 0) {
            UIView* lineView = [MyController viewWithFrame:CGRectMake(0, 40 * i, [MyController getScreenWidth], 0.5)];
            lineView.backgroundColor = [MyController colorWithHexString:@"d4d4d4"];
            [self.bgView addSubview:lineView];
        }
    }
    
}
@end
