//
//  IndexS0Cell.m
//  AndyCoder
//
//  Created by lingnet on 16/4/11.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "IndexS0Cell.h"

#import "IndexS0Model.h"

#import "SDCycleScrollView.h"
@interface IndexS0Cell()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end
@implementation IndexS0Cell
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style
                      reuseIdentifier:(nullable NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}
- (void)makeUI{
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], [MyController getScreenWidth] * 9/16) imageURLStringsGroup:nil]; 
    [self.contentView addSubview:self.cycleScrollView];
    self.cycleScrollView.delegate = self;
    self.cycleScrollView.showPageControl = YES;
    self.cycleScrollView.placeholderImage = [UIImage imageNamed:@""];
    self.cycleScrollView.autoScrollTimeInterval = 4.0;
    [self.cycleScrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset([MyController getScreenWidth] * 9/16);//9/16
        make.right.mas_equalTo(0);
    }];
    
    self.hyb_lastViewInCell = self.cycleScrollView;
    self.hyb_bottomOffsetToCell = 0;
}
- (void)configCellWithModel:(IndexS0Model *)model {
    NSArray *array = model.picArr;
    self.cycleScrollView.imageURLStringsGroup = array;
    if (1 == model.picArr.count) {
        self.cycleScrollView.autoScroll = NO;
    }
}

#pragma mark - 轮滚点击代理
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"---点击了第%ld张图片", (long)index);
    [self.IndexS0CellDelegate indexSeleAD:index];
}

@end
