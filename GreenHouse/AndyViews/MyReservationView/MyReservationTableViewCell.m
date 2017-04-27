//
//  MyReservationTableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/4/26.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyReservationTableViewCell.h"

#import "MyReservationModel.h"
@interface MyReservationTableViewCell()
@property (nonatomic, strong) UIView* topView;

@property (nonatomic, strong) UIImageView* headIV;

@property (nonatomic, strong) UILabel* titleNameLable;
@property (nonatomic, strong) UILabel* addressLable;
@property (nonatomic, strong) UILabel* timeLable;
@property (nonatomic, strong) UILabel* jifenLable;
@property (nonatomic, strong) UILabel* yuyueTypeLable;

//@property (nonatomic, strong) UIView* lineView1;
@property (nonatomic, strong) UIView* lineView2;

@end
@implementation MyReservationTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.backgroundColor = [UIColor whiteColor];
    
    self.topView = [[UIView alloc] init];
    [self.contentView addSubview:self.topView];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_offset(5);
    }];
    
    self.headIV = [[UIImageView alloc] init];
    [self.contentView addSubview:self.headIV];
    //将图层的边框设置为圆脚
    self.headIV.layer.cornerRadius = 0;
    self.headIV.layer.masksToBounds = YES;
    [self.headIV setContentMode:UIViewContentModeScaleAspectFill];
    self.headIV.clipsToBounds = YES;
    [self.headIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.width.mas_offset(90);
        make.height.mas_offset(90);
    }];
    
    self.titleNameLable = [[UILabel alloc] init];
    self.titleNameLable.text = @"礼品名称";
    [self.contentView addSubview:self.titleNameLable];
    self.titleNameLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.titleNameLable.numberOfLines = 2;
    self.titleNameLable.font = [UIFont systemFontOfSize:16];
    
    [self.titleNameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headIV.mas_right).offset(10);
        make.top.mas_equalTo(self.headIV).mas_offset(5);
        make.right.mas_equalTo(-5);
    }];
    
    self.timeLable = [[UILabel alloc] init];
    self.timeLable.text = @"兑换截至：";
    [self.contentView addSubview:self.timeLable];
    self.timeLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.timeLable.numberOfLines = 1;
    self.timeLable.font = [UIFont systemFontOfSize:14];
    
    [self.timeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleNameLable.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(-5);
    }];
    
    self.addressLable = [[UILabel alloc] init];
    self.addressLable.text = @"浦东区：";
    [self.contentView addSubview:self.addressLable];
    self.addressLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.addressLable.numberOfLines = 1;
    self.addressLable.font = [UIFont systemFontOfSize:14];
    
    [self.addressLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLable);
        make.left.mas_equalTo(self.titleNameLable);
        make.right.mas_equalTo(self.timeLable.mas_left).mas_offset(-3);
    }];
    
    self.yuyueTypeLable = [[UILabel alloc] init];
    self.yuyueTypeLable.text = @"自己兑换";
    [self.contentView addSubview:self.yuyueTypeLable];
    self.yuyueTypeLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.yuyueTypeLable.numberOfLines = 1;
    self.yuyueTypeLable.font = [UIFont systemFontOfSize:14];
    
    [self.yuyueTypeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.timeLable.mas_bottom).mas_offset(10);
        make.right.mas_equalTo(-5);
    }];
    
    self.jifenLable = [[UILabel alloc] init];
    self.jifenLable.text = @"积分  ";
    [self.contentView addSubview:self.jifenLable];
    self.jifenLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.jifenLable.numberOfLines = 1;
    self.jifenLable.font = [UIFont systemFontOfSize:14];
    
    [self.jifenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yuyueTypeLable);
        make.left.mas_equalTo(self.addressLable);
        make.right.mas_equalTo(self.yuyueTypeLable.mas_left).mas_offset(-3);
    }];
    
//    self.lineView1 = [[UIView alloc] init];
//    [self.contentView addSubview:self.lineView1];
//    self.lineView1.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
//    
//    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.headIV.mas_right);
//        make.right.mas_equalTo(0);
//        make.top.mas_equalTo(self.headIV);
//        make.height.mas_offset(0.5);
//    }];
    
    self.lineView2 = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView2];
    self.lineView2.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headIV.mas_right);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.headIV.mas_bottom).mas_offset(-0.5);
        make.height.mas_offset(0.5);
    }];
    self.hyb_lastViewInCell = self.headIV;
    self.hyb_bottomOffsetToCell = 0;
}
- (void)configCellWithModel:(MyReservationModel *)model{
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:model.headImageStr] placeholderImage:[UIImage imageNamed:DEFAULTIMAGE]];
    
    self.titleNameLable.text = model.titleNameStr;
    
    self.addressLable.text = model.addressStr;
    
    self.timeLable.text = model.timeStr;
    
    self.jifenLable.text = model.jifenStr;
    
    self.yuyueTypeLable.text = model.yuyueTypeStr;
}
@end
