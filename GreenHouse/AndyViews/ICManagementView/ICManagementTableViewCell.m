//
//  ICManagementTableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/4/28.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "ICManagementTableViewCell.h"

#import "ICManagementModel.h"
@interface ICManagementTableViewCell()
@property (nonatomic, strong) UILabel* icLable;

@property (nonatomic, strong) UIView* lineView;
@end
@implementation ICManagementTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.icLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.icLable];
    self.icLable.textColor = [MyController colorWithHexString:@"52525a"];
    self.icLable.numberOfLines = 0;
    self.icLable.font = [UIFont systemFontOfSize:14];
    
    [self.icLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(0);
    }];
    
    self.lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d4d4d4"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.icLable.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_offset(0.5);
    }];
    
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
    
}

- (void)configCellWithModel:(ICManagementModel *)model{

    self.icLable.text = [model.icCardNum uppercaseString];
}
@end
