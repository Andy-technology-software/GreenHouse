//
//  GiftDetail1TableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "GiftDetail1TableViewCell.h"

#import "GiftDetailS1Model.h"
@interface GiftDetail1TableViewCell()
@property (nonatomic, strong) UIView* lineView1;
@property (nonatomic, strong) UIView* lineView2;
@property (nonatomic, strong) UIView* lineView3;

@property (nonatomic, strong) UILabel* nameLable;
@property (nonatomic, strong) UILabel* suoxujifenLable;
@property (nonatomic, strong) UILabel* shichangPriceLable;
@property (nonatomic, strong) UILabel* lipinGuigeLable;
@property (nonatomic, strong) UILabel* lipinDanweiLable;
@property (nonatomic, strong) UILabel* shengyuNumLable;
@property (nonatomic, strong) UILabel* duihuanjiezhiLable;
@property (nonatomic, strong) UILabel* xiangximiaoshuLable;
@property (nonatomic, strong) UILabel* desLable;

@end
@implementation GiftDetail1TableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.lineView1 = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView1];
    self.lineView1.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(0.5);
    }];
    
    self.nameLable = [[UILabel alloc] init];
    self.nameLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLable];
    self.nameLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.nameLable.numberOfLines = 0;
    self.nameLable.font = [UIFont systemFontOfSize:14];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView1.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];

    
    self.lineView2 = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView2];
    self.lineView2.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.lineView1);
        make.right.mas_equalTo(self.lineView1);
        make.top.mas_equalTo(self.nameLable.mas_bottom).mas_offset(10);
        make.height.mas_offset(0.5);
    }];
    
    self.suoxujifenLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.suoxujifenLable];
    self.suoxujifenLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.suoxujifenLable.numberOfLines = 0;
    self.suoxujifenLable.font = [UIFont systemFontOfSize:14];
    
    [self.suoxujifenLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lineView2.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
    }];
    
    self.shichangPriceLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.shichangPriceLable];
//    self.shichangPriceLable.backgroundColor = [UIColor redColor];
    self.shichangPriceLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.shichangPriceLable.numberOfLines = 1;
    self.shichangPriceLable.font = [UIFont systemFontOfSize:14];
    
    [self.shichangPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.suoxujifenLable.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.suoxujifenLable);
        make.right.mas_equalTo(self.suoxujifenLable);
    }];
    
    self.lineView3 = [[UIView alloc] init];
    [self.contentView addSubview:self.lineView3];
    self.lineView3.backgroundColor = [UIColor blackColor];
    
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shichangPriceLable).mas_offset(65);
        make.right.mas_equalTo(self.shichangPriceLable).mas_offset(-55);
        make.top.mas_equalTo(self.shichangPriceLable).mas_offset(7);
        make.height.mas_offset(0.5);
    }];
    
    self.lipinGuigeLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.lipinGuigeLable];
    self.lipinGuigeLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.lipinGuigeLable.numberOfLines = 0;
    self.lipinGuigeLable.font = [UIFont systemFontOfSize:14];
    
    [self.lipinGuigeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shichangPriceLable.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.shichangPriceLable);
        make.right.mas_equalTo(self.shichangPriceLable);
    }];
    
    self.lipinDanweiLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.lipinDanweiLable];
    self.lipinDanweiLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.lipinDanweiLable.numberOfLines = 0;
    self.lipinDanweiLable.font = [UIFont systemFontOfSize:14];
    
    [self.lipinDanweiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lipinGuigeLable.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.lipinGuigeLable);
        make.right.mas_equalTo(self.lipinGuigeLable);
    }];
    
    self.shengyuNumLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.shengyuNumLable];
    self.shengyuNumLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.shengyuNumLable.numberOfLines = 0;
    self.shengyuNumLable.font = [UIFont systemFontOfSize:14];
    
    [self.shengyuNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.lipinDanweiLable.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.lipinDanweiLable);
        make.right.mas_equalTo(self.lipinDanweiLable);
    }];
    
    self.duihuanjiezhiLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.duihuanjiezhiLable];
    self.duihuanjiezhiLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.duihuanjiezhiLable.numberOfLines = 0;
    self.duihuanjiezhiLable.font = [UIFont systemFontOfSize:14];
    
    [self.duihuanjiezhiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.shengyuNumLable.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.shengyuNumLable);
        make.right.mas_equalTo(self.shengyuNumLable);
    }];
    
    self.xiangximiaoshuLable = [[UILabel alloc] init];
    [self.contentView addSubview:self.xiangximiaoshuLable];
    self.xiangximiaoshuLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.xiangximiaoshuLable.numberOfLines = 0;
    self.xiangximiaoshuLable.font = [UIFont systemFontOfSize:14];
    
    [self.xiangximiaoshuLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.duihuanjiezhiLable.mas_bottom).mas_offset(5);
        make.left.mas_equalTo(self.duihuanjiezhiLable);
        make.right.mas_equalTo(self.duihuanjiezhiLable);
    }];
    
    self.hyb_lastViewInCell = self.xiangximiaoshuLable;
    self.hyb_bottomOffsetToCell = 10;
    
}
- (void)configCellWithModel:(GiftDetailS1Model *)model{
    self.nameLable.text = model.nameStr;
    
    self.suoxujifenLable.text = model.suoxujifenStr;
    [MyController fuwenbenLabel:self.suoxujifenLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(4, self.suoxujifenLable.text.length - 4) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    
    self.shichangPriceLable.text = model.shichangPriceStr;
//    [MyController fuwenbenLabel:self.shichangPriceLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(4, self.shichangPriceLable.text.length - 4) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    
//    CGSize theStringSize = [model.shichangPriceStr sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:self.shichangPriceLable.frame.size lineBreakMode:self.shichangPriceLable.lineBreakMode];
    CGSize theStringSize = [self getAttributeSizeWithText:model.shichangPriceStr fontSize:14];
    [self.lineView3 mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shichangPriceLable).mas_offset(65);
        make.top.mas_equalTo(self.shichangPriceLable).mas_offset(7);
        make.height.mas_offset(0.5);
        make.width.mas_offset(theStringSize.width - 63);
    }];

    
    self.lipinGuigeLable.text = model.lipinGuigeStr;
//    [MyController fuwenbenLabel:self.lipinGuigeLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(4, self.lipinGuigeLable.text.length - 4) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    
    self.lipinDanweiLable.text = model.lipinDanweiStr;
//    [MyController fuwenbenLabel:self.lipinDanweiLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(4, self.lipinDanweiLable.text.length - 4) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    
    self.shengyuNumLable.text = model.shengyuNumStr;
//    [MyController fuwenbenLabel:self.shengyuNumLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(4, self.shengyuNumLable.text.length - 4) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    
    self.duihuanjiezhiLable.text = model.duihuanjiezhiStr;
//    [MyController fuwenbenLabel:self.duihuanjiezhiLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(5, self.duihuanjiezhiLable.text.length - 5) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    
    self.xiangximiaoshuLable.text = model.xiangxiDesStr;
//    [MyController fuwenbenLabel:self.xiangximiaoshuLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(4, self.xiangximiaoshuLable.text.length - 4) AndColor:[MyController colorWithHexString:DEFAULTCOLOR]];
}
-(CGSize) getAttributeSizeWithText:(NSString *)text fontSize:(int)fontSize
{
    CGSize size=[text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    size=[text sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]}];
    return size;
}

@end
