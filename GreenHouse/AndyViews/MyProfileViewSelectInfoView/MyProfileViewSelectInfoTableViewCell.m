//
//  MyProfileViewSelectInfoTableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/4/26.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyProfileViewSelectInfoTableViewCell.h"

#import "MyProfileViewSelectInfoModel.h"
@interface MyProfileViewSelectInfoTableViewCell()
@property (nonatomic, strong) UIView* lineView;

@property (nonatomic, strong) UILabel* titLable;

@end
@implementation MyProfileViewSelectInfoTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.titLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.titLable];
    self.titLable.textColor = [MyController colorWithHexString:@"52525a"];
    self.titLable.numberOfLines = 1;
    self.titLable.textAlignment = NSTextAlignmentCenter;
    self.titLable.font = [UIFont systemFontOfSize:14];
    
    [self.titLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(39.5);
    }];
    
    self.lineView = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_offset(0.5);
        make.top.mas_equalTo(self.titLable.mas_bottom);
    }];
    self.hyb_lastViewInCell = self.lineView;
    self.hyb_bottomOffsetToCell = 0;
    
}
- (void)configCellWithModel:(MyProfileViewSelectInfoModel *)model{
    self.titLable.text = model.titleStr;
    if (model.isSelected) {
        self.titLable.textColor = [MyController colorWithHexString:DEFAULTCOLOR];
        self.titLable.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    }else{
        self.titLable.textColor = [UIColor blackColor];
        self.titLable.backgroundColor = [UIColor whiteColor];
    }
}

@end
