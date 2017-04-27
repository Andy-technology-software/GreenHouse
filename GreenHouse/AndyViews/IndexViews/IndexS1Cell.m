//
//  IndexS1Cell.m
//  AndyCoder
//
//  Created by lingnet on 16/4/22.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "IndexS1Cell.h"

#import "IndexS1Model.h"

#define BUTTONWIDTH [MyController getScreenWidth] / 3
@interface IndexS1Cell()
@property (nonatomic, strong) UIView* bgView;
@property (nonatomic, strong) UIView* no1View;
@property (nonatomic, strong) UILabel* huishouxiangLable;
@property (nonatomic, strong) UILabel* huishouxiangNumLable;
@property (nonatomic, strong) UILabel* yiwuLable;
@property (nonatomic, strong) UILabel* yiwuNumLable;
@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* lineView1;
@property (nonatomic, strong) UIView* no2View;
@property (nonatomic, strong) UIView* lineView2;
@property (nonatomic, strong) UIView* lineView3;
@property (nonatomic, strong) UIView* lineView4;
@property (nonatomic, strong) UIView* lineView5;
@property (nonatomic, strong) UIView* lineView6;
@property (nonatomic, strong) UIView* no3View;
@property (nonatomic, strong) UIImageView* wodetoudiImageView;
@property (nonatomic, strong) UILabel* wodetoudiLable;
@property (nonatomic, strong) UIImageView* wodeDuihuanImageView;
@property (nonatomic, strong) UILabel* wodeDuihuanLable;
@property (nonatomic, strong) UIView* lineView7;
@property (nonatomic, strong) UIView* lineView8;
@property (nonatomic, strong) UIView* lineView9;
@property (nonatomic, strong) UIButton* wodetoudiBtn;
@property (nonatomic, strong) UIButton* wodeduihuanBtn;

@end
@implementation IndexS1Cell
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    
    return self;
}
- (void)makeUI{
    self.contentView.backgroundColor = [MyController colorWithHexString:@"f8f8f8"];
    
    self.no1View = [[UIView alloc] init];
    self.no1View.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.no1View];
    [self.no1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(3);
        make.height.mas_offset(44);
    }];
    
    self.huishouxiangLable = [[UILabel alloc] init];
    [self.no1View addSubview:self.huishouxiangLable];
    self.huishouxiangLable.text = @"回收箱总计";
    self.huishouxiangLable.numberOfLines = 1;
    self.huishouxiangLable.textAlignment = NSTextAlignmentCenter;
    self.huishouxiangLable.font = [UIFont systemFontOfSize:14];
    
    [self.huishouxiangLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(3);
        make.left.mas_equalTo(0);
        make.height.mas_offset(16);
        make.width.mas_offset([MyController getScreenWidth] / 2);
    }];
    
    self.huishouxiangNumLable = [[UILabel alloc] init];
    [self.no1View addSubview:self.huishouxiangNumLable];
    self.huishouxiangNumLable.text = @"0";
    self.huishouxiangNumLable.textColor = [MyController colorWithHexString:DEFAULTCOLOR];
    self.huishouxiangNumLable.numberOfLines = 1;
    self.huishouxiangNumLable.textAlignment = NSTextAlignmentCenter;
    self.huishouxiangNumLable.font = [UIFont systemFontOfSize:14];
    
    [self.huishouxiangNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.huishouxiangLable.mas_bottom);
        make.left.mas_equalTo(self.huishouxiangLable);
        make.width.mas_equalTo(self.huishouxiangLable);
        make.height.mas_offset(28);
    }];
    
    self.yiwuLable = [[UILabel alloc] init];
    [self.no1View addSubview:self.yiwuLable];
    self.yiwuLable.text = @"个人积分总计";
    self.yiwuLable.numberOfLines = 1;
    self.yiwuLable.textAlignment = NSTextAlignmentCenter;
    self.yiwuLable.font = [UIFont systemFontOfSize:14];
    
    [self.yiwuLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(3);
        make.height.mas_offset(16);
        make.left.mas_equalTo(self.huishouxiangLable.mas_right);
        make.width.mas_equalTo(self.huishouxiangLable);
    }];
    
    self.yiwuNumLable = [[UILabel alloc] init];
    [self.no1View addSubview:self.yiwuNumLable];
    self.yiwuNumLable.text = @"0";
    self.yiwuNumLable.textColor = [MyController colorWithHexString:DEFAULTCOLOR];
    self.yiwuNumLable.numberOfLines = 1;
    self.yiwuNumLable.textAlignment = NSTextAlignmentCenter;
    self.yiwuNumLable.font = [UIFont systemFontOfSize:14];
    
    [self.yiwuNumLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yiwuLable.mas_bottom);
        make.left.mas_equalTo(self.yiwuLable);
        make.width.mas_equalTo(self.yiwuLable);
        make.height.mas_offset(28);
    }];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [self.no1View addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.no1View);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(self.no1View);
        make.width.mas_offset(0.5);
    }];
    
    self.lineView1 = [[UIView alloc] init];
    self.lineView1.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [self.no1View addSubview:self.lineView1];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.no1View.mas_bottom).mas_offset(-0.5);
        make.height.mas_offset(0.5);
    }];
    
    self.no2View = [[UIView alloc] init];
    self.no2View.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.no2View];
    [self.no2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.no1View.mas_bottom).mas_offset(5);
        make.height.mas_offset([MyController getScreenWidth]/3 * 2);
    }];
    
    self.lineView2 = [[UIView alloc] init];
    self.lineView2.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [self.no2View addSubview:self.lineView2];
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.no2View.mas_bottom).mas_offset(-0.5);
        make.height.mas_offset(0.5);
    }];
    
    self.lineView3 = [[UIView alloc] init];
    self.lineView3.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [self.no2View addSubview:self.lineView3];
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(0.5);
    }];
    
    self.lineView4 = [[UIView alloc] init];
    self.lineView4.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [self.no2View addSubview:self.lineView4];
    [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(self.no2View);
        make.height.mas_offset(0.5);
    }];
    
    self.lineView5 = [[UIView alloc] init];
    self.lineView5.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [self.no2View addSubview:self.lineView5];
    [self.lineView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo([MyController getScreenWidth] / 3);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(self.no2View);
        make.width.mas_offset(0.5);
    }];
    
    self.lineView6 = [[UIView alloc] init];
    self.lineView6.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [self.no2View addSubview:self.lineView6];
    [self.lineView6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo([MyController getScreenWidth] / 3 * 2);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(self.no2View);
        make.width.mas_offset(0.5);
    }];
    
    self.no3View = [[UIView alloc] init];
    self.no3View.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.no3View];
    [self.no3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.no2View.mas_bottom).mas_offset(5);
        make.height.mas_offset(50);
    }];

    self.wodetoudiImageView = [[UIImageView alloc] init];
//    self.wodetoudiImageView.backgroundColor = [UIColor redColor];
    self.wodetoudiImageView.image = [UIImage imageNamed:@"我的投递"];
    [self.no3View addSubview:self.wodetoudiImageView];
    
    [self.wodetoudiImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(20);
        make.width.mas_offset(40);
        make.height.mas_offset(40);
    }];
    
    self.wodetoudiLable = [[UILabel alloc] init];
    [self.no3View addSubview:self.wodetoudiLable];
    self.wodetoudiLable.text = @"我的投递";
    self.wodetoudiLable.numberOfLines = 1;
    self.wodetoudiLable.textAlignment = NSTextAlignmentCenter;
    self.wodetoudiLable.font = [UIFont systemFontOfSize:14];
    
    [self.wodetoudiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(self.wodetoudiImageView.mas_right);
        make.right.mas_equalTo(-[MyController getScreenWidth] / 2);
        make.height.mas_offset(50);
    }];
    
    self.wodetoudiBtn = [MyController createButtonWithFrame:self.frame ImageName:nil Target:self Action:@selector(wodetoudiBtnClick) Title:nil];
    [self.no3View addSubview:self.wodetoudiBtn];
    
    [self.wodetoudiBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.width.mas_offset([MyController getScreenWidth] / 2);
        make.height.mas_equalTo(self.no3View);
    }];
    
    
    self.wodeDuihuanImageView = [[UIImageView alloc] init];
//    self.wodeDuihuanImageView.backgroundColor = [UIColor redColor];
    self.wodeDuihuanImageView.image = [UIImage imageNamed:@"我的兑换"];
    [self.no3View addSubview:self.wodeDuihuanImageView];
    
    [self.wodeDuihuanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.wodetoudiImageView);
        make.left.mas_equalTo(self.wodetoudiLable.mas_right).mas_offset(20);
        make.width.mas_equalTo(self.wodetoudiImageView);
        make.height.mas_equalTo(self.wodetoudiImageView);
    }];
    
    self.wodeDuihuanLable = [[UILabel alloc] init];
    [self.no3View addSubview:self.wodeDuihuanLable];
    self.wodeDuihuanLable.text = @"我的兑换";
    self.wodeDuihuanLable.numberOfLines = 1;
    self.wodeDuihuanLable.textAlignment = NSTextAlignmentCenter;
    self.wodeDuihuanLable.font = [UIFont systemFontOfSize:14];
    
    [self.wodeDuihuanLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.wodetoudiLable);
        make.left.mas_equalTo(self.wodeDuihuanImageView.mas_right);
        make.right.mas_equalTo(0);
        make.height.mas_offset(50);
    }];
    
    self.wodeduihuanBtn = [MyController createButtonWithFrame:self.frame ImageName:nil Target:self Action:@selector(wodeduihuanBtnClick) Title:nil];
    [self.no3View addSubview:self.wodeduihuanBtn];
    
    [self.wodeduihuanBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.no3View).mas_offset([MyController getScreenWidth] / 2);
        make.top.mas_equalTo(0);
        make.width.mas_offset([MyController getScreenWidth] / 2);
        make.height.mas_equalTo(self.no3View);
    }];
    
    self.lineView7 = [[UIView alloc] init];
    self.lineView7.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [self.no3View addSubview:self.lineView7];
    [self.lineView7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(0.5);
    }];
    
    self.lineView8 = [[UIView alloc] init];
    self.lineView8.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [self.no3View addSubview:self.lineView8];
    [self.lineView8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.no3View.mas_bottom);
        make.height.mas_offset(0.5);
    }];
    
    self.lineView9 = [[UIView alloc] init];
    self.lineView9.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [self.no3View addSubview:self.lineView9];
    [self.lineView9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.no3View);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(self.no3View);
        make.width.mas_offset(0.5);
    }];
    self.hyb_lastViewInCell = self.no3View;
    self.hyb_bottomOffsetToCell = 0;
}

- (void)configCellWithModel:(IndexS1Model *)model{
    self.huishouxiangNumLable.text = model.huishouxiangCountStr;
    
    self.yiwuNumLable.text = model.yiwuCountStr;
    
    NSArray* titleArr = [[NSArray alloc] initWithObjects:@"扫码投递",@"上门回收",@"回收地图",@"礼品兑换",@"IC卡管理",@"个人中心", nil];
    NSArray* imageTitleArr = [[NSArray alloc] initWithObjects:@"index1",@"index2",@"index3",@"index4",@"index5",@"index6", nil];
    for (int i = 0; i < 6; i++) {
        UIImageView* temIV = [MyController createImageViewWithFrame:CGRectMake(20 + BUTTONWIDTH * (i % 3), 10 + BUTTONWIDTH * (i / 3), BUTTONWIDTH - 40, BUTTONWIDTH - 40) ImageName:imageTitleArr[i]];
        [self.no2View addSubview:temIV];
        
        UILabel* temLable = [MyController createLabelWithFrame:CGRectMake(temIV.frame.origin.x, temIV.frame.origin.y + temIV.frame.size.height + 3, temIV.frame.size.width, 12) Font:12 Text:titleArr[i]];
        temLable.textAlignment = NSTextAlignmentCenter;
        [self.no2View addSubview:temLable];
        
        UIButton* temBtn = [MyController createButtonWithFrame:CGRectMake(temIV.frame.origin.x, temIV.frame.origin.y, temIV.frame.size.width, temIV.frame.size.height + temLable.frame.size.height + 3) ImageName:nil Target:self Action:@selector(temBtnClick:) Title:nil];
        temBtn.tag = 100 + i;
        [self.no2View addSubview:temBtn];
    }
}
- (void)temBtnClick:(UIButton*)btn{
    [self.IndexS1CellDelegate clickS1Btn:btn.tag];
}

- (void)wodetoudiBtnClick{
    [self.IndexS1CellDelegate wodetoudi];
}

- (void)wodeduihuanBtnClick{
    [self.IndexS1CellDelegate wodeduihuan];
}
@end
