//
//  GiftDetailTableViewCell.m
//  AndyCoder
//
//  Created by lingnet on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "GiftDetailTableViewCell.h"

#import "GiftDetailS0Model.h"

#import "SDCycleScrollView.h"

#define TEMWIDTH ([MyController getScreenWidth])/3
@interface GiftDetailTableViewCell()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@property(nonatomic, retain)UIView* bottomView;

@end
@implementation GiftDetailTableViewCell

- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    //网络加载 --- 创建带标题的图片轮播器
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], [MyController getScreenWidth] * 9/16) imageURLStringsGroup:nil]; // 模拟网络延时情景
    [self.contentView addSubview:self.cycleScrollView];
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.showPageControl = YES;
    self.cycleScrollView.placeholderImage = [UIImage imageNamed:@""];
    self.cycleScrollView.autoScrollTimeInterval = 4.0;
    [self.cycleScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset([MyController getScreenWidth] * 9/16);
        make.right.mas_equalTo(0);
    }];
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.cycleScrollView.mas_bottom);
        make.height.mas_offset(40);
    }];
    
    self.hyb_lastViewInCell = self.bottomView;
    self.hyb_bottomOffsetToCell = 0;
}
- (void)configCellWithModel:(GiftDetailS0Model *)model {
    NSArray *array = model.picArr;
    self.cycleScrollView.imageURLStringsGroup = array;
    if (1 == model.picArr.count) {
        self.cycleScrollView.autoScroll = NO;
    }
    
    self.bottomView = [[UIView alloc] init];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.cycleScrollView.mas_bottom);
        make.height.mas_offset(40);
    }];
    
    NSArray* temArr = [[NSArray alloc] initWithObjects:@"详情1",@"详情2",@"详情3", nil];
    NSArray* temArr1 = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"已兑换:%@",model.bottomArr[0]],[NSString stringWithFormat:@"浏览:%@",model.bottomArr[1]],[NSString stringWithFormat:@"关注度:%@",model.bottomArr[2]], nil];
    for (int i = 0; i < temArr.count; i++) {
        
        UILabel* temLable = [MyController createLabelWithFrame:CGRectMake(TEMWIDTH * i, 0, TEMWIDTH, 40) Font:12 Text:temArr1[i]];
        temLable.textAlignment = NSTextAlignmentCenter;
        [self.bottomView addSubview:temLable];
        
        UIButton* temBtn = [MyController createButtonWithFrame:CGRectMake(TEMWIDTH * i, 0, TEMWIDTH, 40) ImageName:nil Target:self Action:@selector(temBtnClick:) Title:nil];
        temBtn.tag = 100 + i;
        [self.bottomView addSubview:temBtn];
    }
}
- (void)temBtnClick:(UIButton*)btn{
    [self.GiftDetailS0Delegate selectWhichBtn:btn.tag];
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    [self.GiftDetailS0Delegate indexSeleAD:index];
}

@end
