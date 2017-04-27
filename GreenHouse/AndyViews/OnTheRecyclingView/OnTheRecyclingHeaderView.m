//
//  OnTheRecyclingHeaderView.m
//  AndyCoder
//
//  Created by lingnet on 16/4/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "OnTheRecyclingHeaderView.h"

#import "OnTheRecyclingHeaderModel.h"

@interface OnTheRecyclingHeaderView()
@property (nonatomic, strong) UIView* lineView0;
@property (nonatomic, strong) UIView* lineView;
@property (nonatomic, strong) UIView* bgView;

@property (nonatomic, strong) UILabel* headTitleLable;
@end
@implementation OnTheRecyclingHeaderView

+ (instancetype)headViewWithTableView:(UITableView *)tableView{
    static NSString *headIdentifier = @"header";
    
    OnTheRecyclingHeaderView *headView = [tableView dequeueReusableCellWithIdentifier:headIdentifier];
    if (headView == nil) {
        headView = [[OnTheRecyclingHeaderView alloc] initWithReuseIdentifier:headIdentifier];
    }
    
    return headView;
}

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self makeUI];
    }
    return self;
}

- (void)makeUI{
    
    self.bgView = [[UIView alloc] init];
    self.bgView.backgroundColor = [MyController colorWithHexString:@"f8f8f8"];
    [self addSubview:self.bgView];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(40);
    }];
    
    self.headTitleLable = [[UILabel alloc] init];
    [self.bgView addSubview:self.headTitleLable];
    self.headTitleLable.textColor = [MyController colorWithHexString:@"49535c"];
    self.headTitleLable.numberOfLines = 1;
    self.headTitleLable.font = [UIFont systemFontOfSize:16];
    
    [self.headTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-10);
        make.height.mas_offset(40);
    }];
    
    self.lineView0 = [[UIView alloc] init];
    [self.bgView addSubview:self.lineView0];
    self.lineView0.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_offset(0.5);
    }];
    
    self.lineView = [[UIView alloc] init];
    [self.bgView addSubview:self.lineView];
    self.lineView.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(39.5);
        make.height.mas_offset(0.5);
    }];
    
}
- (void)makeHeader:(OnTheRecyclingHeaderModel*)model{
    self.headTitleLable.text = model.titleStr;
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
