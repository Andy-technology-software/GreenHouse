//
//  AppointmentToRecycleViewController.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/6/5.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AppointmentToRecycleViewController.h"

#import "AppointmentToRecycleModel.h"

#import "AppointmentToRecycleTableViewCell.h"
@interface AppointmentToRecycleViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* dataSourceArr;

@end

@implementation AppointmentToRecycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"预约回收";
    
    self.view.backgroundColor = [MyController colorWithHexString:@"f6f6f6"];
    
    self.dataSourceArr = [[NSMutableArray alloc] init];
    AppointmentToRecycleModel* model = [[AppointmentToRecycleModel alloc] init];
    model.fenleiStr = self.fenleiStr;
    model.zhongliangStr = self.zhongliangStr;
    model.dianhuaStr = self.dianhuaStr;
    [self.dataSourceArr addObject:model];
    
    [self createTableView];
    
    [self makeBottomUI];
}
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    [self.view addSubview:bottomView];
    
    UIButton* makeSureBtn = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth] - 80, 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:@"知道了"];
    [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:makeSureBtn];
    
    UIButton* kefuBtn = [MyController createButtonWithFrame:CGRectMake(CGRectGetMaxX(makeSureBtn.frame), makeSureBtn.frame.origin.y, 80, 40) ImageName:nil Target:self Action:@selector(kefuBtnClick) Title:@"客服"];
    [kefuBtn setTitleColor:[MyController colorWithHexString:DEFAULTCOLOR] forState:UIControlStateNormal];
    [kefuBtn setBackgroundColor:[UIColor whiteColor]];
    kefuBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:kefuBtn];
    
    UIView* lineV = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 0.5)];
    lineV.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    [bottomView addSubview:lineV];
}
- (void)makeSureBtnClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)kefuBtnClick{
    NSString* kefuPhone = @"4001388899";
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSString* str = [NSString stringWithFormat:@"tel:%@",kefuPhone];
    NSURL *telURL =[NSURL URLWithString:str];
    // 貌似tel:// 或者 tel: 都行
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    //记得添加到view上
    [self.view addSubview:callWebview];
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 40) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [MyController colorWithHexString:@"f6f6f6"];
    [_tableView setBackgroundView:tableBg];
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    //_tableView.backgroundColor = [UIColor colorWithRed:190 green:30 blue:96 alpha:1];
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSourceArr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"appoint";
    AppointmentToRecycleTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[AppointmentToRecycleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    AppointmentToRecycleModel* model = self.dataSourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppointmentToRecycleModel *model = nil;
    if (indexPath.row < self.dataSourceArr.count) {
        model = [self.dataSourceArr objectAtIndex:indexPath.row];
    }
    return [AppointmentToRecycleTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        AppointmentToRecycleTableViewCell *cell = (AppointmentToRecycleTableViewCell *)sourceCell;
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
