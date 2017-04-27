//
//  DeliverySuccessViewController.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/4/24.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "DeliverySuccessViewController.h"

#import "DeliverySuccessModel.h"

#import "DeliverySuccessTableViewCell.h"

#import "GiftExchangeViewController.h"
@interface DeliverySuccessViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr;

@end

@implementation DeliverySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"投递成功";
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    
//    [self.datasourceArr addObject:self.s0Model];
    [self makeData];
    
    [self createTableView];
    
    [self makeBottomUI];
}
- (void)viewWillAppear:(BOOL)animated{
    
}

#pragma mark - 底部按钮UI
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    [self.view addSubview:bottomView];
    
    UIButton* makeSureBtn = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:@"去兑换礼品"];
    [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:makeSureBtn];
}
#pragma mark - 底部按钮响应
- (void)makeSureBtnClick{
    NSLog(@"礼品兑换");
    GiftExchangeViewController* vc = [[GiftExchangeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 临时数据
- (void)makeData{
    DeliverySuccessModel* s0Model = [[DeliverySuccessModel alloc] init];
    s0Model.weightStrAdnintegralStrArr = [[NSMutableArray alloc] init];
    [s0Model.weightStrAdnintegralStrArr addObject:@"  衣服总重量：122344322 Kg"];
    [s0Model.weightStrAdnintegralStrArr addObject:@"  所获积分：122344322 积分"];
    s0Model.totalIntegralStr = @"  总积分：1000000";
    [self.datasourceArr addObject:s0Model];
}
#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 40) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [UIColor whiteColor];
    [_tableView setBackgroundView:tableBg];
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    //_tableView.backgroundColor = [UIColor colorWithRed:190 green:30 blue:96 alpha:1];
    [self.view addSubview:_tableView];
}
#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasourceArr.count;
}
#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"DeliverySuccessTableViewCell";
    DeliverySuccessTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[DeliverySuccessTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    DeliverySuccessModel* model = self.datasourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DeliverySuccessModel *model = nil;
    if (indexPath.row < self.datasourceArr.count) {
        model = [self.datasourceArr objectAtIndex:indexPath.row];
    }
    return [DeliverySuccessTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        DeliverySuccessTableViewCell *cell = (DeliverySuccessTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
