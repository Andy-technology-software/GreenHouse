//
//  PersonalCenterTableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "PersonalCenterTableViewCell.h"

#import "PersonalCenterModel.h"
@interface PersonalCenterTableViewCell()
@property(nonatomic, retain)UIImageView* headImageView;

@property(nonatomic, retain)UILabel* zhanghaoLable;

@property (nonatomic, strong) UIView* lineView1;

@property (nonatomic, strong) UIButton* infoBtn;

@end
@implementation PersonalCenterTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.headImageView = [[UIImageView alloc] init];
    //将图层的边框设置为圆脚
    self.headImageView.layer.cornerRadius = 50;
    self.headImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.headImageView];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.centerX.mas_equalTo(self);
        make.width.mas_offset(100);
        make.height.mas_offset(100);
    }];
    
    self.zhanghaoLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.zhanghaoLable];
    self.zhanghaoLable.text = @"投递成功";
    self.zhanghaoLable.numberOfLines = 1;
    self.zhanghaoLable.textAlignment = NSTextAlignmentCenter;
    self.zhanghaoLable.font = [UIFont systemFontOfSize:16];
    
    [self.zhanghaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_offset(19);
    }];
    
    self.infoBtn = [MyController createButtonWithFrame:self.frame ImageName:@"" Target:self Action:@selector(infoBtnClick) Title:nil];
    [self.contentView addSubview:self.infoBtn];
    
    [self.infoBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView);
        make.right.mas_equalTo(self.headImageView);
        make.top.mas_equalTo(self.headImageView);
        make.bottom.mas_equalTo(self.zhanghaoLable);
    }];


    self.lineView1 = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView1];
    self.lineView1.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.zhanghaoLable.mas_bottom).mas_offset(10);
        make.height.mas_offset(0.5);
    }];
        self.hyb_lastViewInCell = self.lineView1;
    self.hyb_bottomOffsetToCell = 0;
}
- (void)configCellWithModel:(PersonalCenterModel *)model{
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.headImageStr] placeholderImage:[UIImage imageNamed:@"shezhitupian"] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    self.zhanghaoLable.text = model.zhanghaoStr;
}
- (void)infoBtnClick{
    [self.PersonalCenterTableViewCellDelegate personInfo];
}
@end
