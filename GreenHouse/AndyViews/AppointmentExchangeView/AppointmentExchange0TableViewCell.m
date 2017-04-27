//
//  AppointmentExchange0TableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/4/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AppointmentExchange0TableViewCell.h"

#import "AppointmentExchange0Model.h"
@interface AppointmentExchange0TableViewCell()
@property (nonatomic, strong) UILabel* suoxujifenLable;
@property (nonatomic, strong) UILabel* lipinguigeLable;
@property (nonatomic, strong) UILabel* duihuanNumLable;
@property (nonatomic, strong) UILabel* duihuanTypeLable;
@property (nonatomic, strong) UILabel* dingdianLable;
@property (nonatomic, strong) UILabel* songhuoLable;

//@property (nonatomic, strong) UIButton* dingdianBtn;
//@property (nonatomic, strong) UIButton* dingdianBtn1;
@property (nonatomic, strong) UIButton* songhuoBtn;
@property (nonatomic, strong) UIButton* songhuoBtn1;

@end
@implementation AppointmentExchange0TableViewCell

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
    self.duihuanTypeLable.text = @"兑换方式";
    self.duihuanTypeLable.textColor = [MyController colorWithHexString:@"52525a"];
    self.duihuanTypeLable.numberOfLines = 1;
    self.duihuanTypeLable.font = [UIFont systemFontOfSize:14];
    
    [self.duihuanTypeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.duihuanNumLable);
        make.top.mas_equalTo(self.duihuanNumLable.mas_bottom).mas_offset(10);
    }];
    
//    self.dingdianLable = [[UILabel alloc] init];
//    [self.contentView addSubview:self.dingdianLable];
//    self.dingdianLable.text = @"定点兑换";
//    self.dingdianLable.textColor = [MyController colorWithHexString:@"52525a"];
//    self.dingdianLable.numberOfLines = 1;
//    self.dingdianLable.font = [UIFont systemFontOfSize:14];
//    
//    [self.dingdianLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.duihuanTypeLable.mas_right).mas_offset(20);
//        make.top.mas_equalTo(self.duihuanTypeLable);
//    }];
//    
//    self.dingdianBtn = [MyController createButtonWithFrame:self.frame ImageName:nil Target:self Action:@selector(dingdianBtnClick) Title:nil];
//    [self.dingdianBtn setBackgroundImage:[UIImage imageNamed:@"爱点击"] forState:UIControlStateNormal];
//    [self.contentView addSubview:self.dingdianBtn];
//    
//    [self.dingdianBtn mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.dingdianLable.mas_right).mas_offset(10);
//        make.top.mas_equalTo(self.dingdianLable);
//        make.height.mas_offset(15);
//        make.width.mas_offset(15);
//    }];
//    
//    self.dingdianBtn1 = [MyController createButtonWithFrame:self.frame ImageName:nil Target:self Action:@selector(dingdianBtnClick) Title:nil];
//    [self.contentView addSubview:self.dingdianBtn1];
//    
//    [self.dingdianBtn1 mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.dingdianLable);
//        make.top.mas_equalTo(self.dingdianBtn);
//        make.right.mas_equalTo(self.dingdianBtn.mas_right);
//        make.height.mas_equalTo(self.dingdianBtn);
//    }];
    
    self.songhuoLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.songhuoLable];
    self.songhuoLable.text = @"送货上门";
    self.songhuoLable.textColor = [MyController colorWithHexString:@"52525a"];
    self.songhuoLable.numberOfLines = 1;
    self.songhuoLable.font = [UIFont systemFontOfSize:14];
    
    [self.songhuoLable mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.mas_equalTo(self.duihuanTypeLable.mas_right).mas_offset(20);
    make.top.mas_equalTo(self.duihuanTypeLable);
    }];
    
    self.songhuoBtn = [MyController createButtonWithFrame:self.frame ImageName:nil Target:self Action:@selector(songhuoBtnClick) Title:nil];
    [self.songhuoBtn setBackgroundImage:[UIImage imageNamed:@"不爱点击"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.songhuoBtn];
    
    [self.songhuoBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.songhuoLable.mas_right).mas_offset(10);
        make.top.mas_equalTo(self.songhuoLable);
        make.height.mas_offset(15);
        make.width.mas_offset(15);
    }];
    
    self.songhuoBtn1 = [MyController createButtonWithFrame:self.frame ImageName:nil Target:self Action:@selector(songhuoBtnClick) Title:nil];
    [self.contentView addSubview:self.songhuoBtn1];
    
    [self.songhuoBtn1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.songhuoLable);
        make.top.mas_equalTo(self.songhuoBtn);
        make.right.mas_equalTo(self.songhuoBtn.mas_right);
        make.height.mas_equalTo(self.songhuoBtn);
    }];

    self.hyb_lastViewInCell = self.duihuanTypeLable;
    self.hyb_bottomOffsetToCell = 10;
}
- (void)dingdianBtnClick{
    [self.AppointmentExchange0TableViewCellDelegate dingdian];
}
- (void)songhuoBtnClick{
    [self.AppointmentExchange0TableViewCellDelegate songhuo];
}
- (void)configCellWithModel:(AppointmentExchange0Model *)model{
    self.suoxujifenLable.text = model.jifenStr;
    [MyController fuwenbenLabel:self.suoxujifenLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(5, self.suoxujifenLable.text.length - 5) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    
    self.lipinguigeLable.text = model.guigeStr;
    [MyController fuwenbenLabel:self.lipinguigeLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(5, self.lipinguigeLable.text.length - 5) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    
    self.duihuanNumLable.text = model.duihuanNumStr;
    [MyController fuwenbenLabel:self.duihuanNumLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(4, self.duihuanNumLable.text.length - 4) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
//    if (model.isDingdianDuihuan) {
//        [self.dingdianBtn setBackgroundImage:[UIImage imageNamed:@"爱点击"] forState:UIControlStateNormal];
//        
//        [self.songhuoBtn setBackgroundImage:[UIImage imageNamed:@"不爱点击"] forState:UIControlStateNormal];
//    }else {
//        [self.dingdianBtn setBackgroundImage:[UIImage imageNamed:@"不爱点击"] forState:UIControlStateNormal];
//        
//        [self.songhuoBtn setBackgroundImage:[UIImage imageNamed:@"爱点击"] forState:UIControlStateNormal];
//    }
    [self.songhuoBtn setBackgroundImage:[UIImage imageNamed:@"爱点击"] forState:UIControlStateNormal];
}

@end
