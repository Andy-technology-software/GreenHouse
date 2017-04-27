//
//  LoginViewController.h
//  E展汇
//
//  Created by 徐仁强 on 16/2/3.
//  Copyright © 2016年 徐仁强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@end

/*
 //
 //  WoViewController.m
 //  E展汇
 //
 //  Created by lingnet on 16/1/6.
 //  Copyright © 2016年 徐仁强. All rights reserved.
 //
 
 #import "WoViewController.h"
 
 #import "MySelfModel.h"
 
 #import "MySelfSection0Model.h"
 
 #import "MySelfTableViewCell.h"
 
 #import "MySelfSection0TableViewCell.h"
 
 #import "MoreViewController.h"
 
 #import "YZMessageViewController.h"
 #import "MyFocusOnViewController.h"
 #import "MyAccountViewController.h"
 #import "RedRecordViewController.h"
 #import "MyAuthenticationViewController.h"
 #import "MyFinanceViewController.h"
 #import "MyExhibitionViewController.h"
 
 #import "BusinessDeViewController.h"
 #import "ChangeQiYeViewController.h"
 #import "ChangeViewController.h"
 #import "DetailViewController.h"
 #import "MyProductViewController.h"
 #import "LoginViewController.h"
 //#import "SearchViewController.h"
 @interface WoViewController ()<UITableViewDataSource,UITableViewDelegate,MySelfSection0TableViewCellDeleagte>{
 UITableView* _tableView;
 NSString *flag;
 
 }
 @property(nonatomic,retain)NSMutableArray* leftImageArr;
 @property(nonatomic,retain)NSMutableArray* titleArr;
 @property(nonatomic,retain)NSMutableArray* datasourceArr;
 @property(nonatomic,retain)NSMutableArray* datasourceArr0;
 @end
 
 @implementation WoViewController
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 // Do any additional setup after loading the view.
 
 }
 - (void)changIndex{
 [self rdv_tabBarController].selectedIndex = 0;
 }
 - (void)viewWillAppear:(BOOL)animated{
 self.navigationController.navigationBarHidden = YES;
 
 LoginViewController *loginvc = [[LoginViewController alloc] init];
 NSArray* modelArr = [[DBManager shareManager] getAllLoginModel];
 LoginDataBaseModel* model = [modelArr lastObject];
 if (!model.userId) {
 [self presentViewController:loginvc animated:NO completion:nil];
 }
 
 self.datasourceArr = [[NSMutableArray alloc] init];
 self.datasourceArr0 = [[NSMutableArray alloc] init];
 
 flag = model.isPersion;
 if ([flag isEqualToString:@"1"]) {
 //        self.leftImageArr = [[NSMutableArray alloc] initWithObjects:@"我-gr",@"我-zh",@"我-d",@"我-zh",@"我-cp",@"我-zl",@"我-rz",@"我-vip",@"我-wl",@"我-jr", nil];
 //        self.titleArr = [[NSMutableArray alloc] initWithObjects:@"个人信息",@"我的账户",@"我的订单",@"我的展会",@"我的产品",@"我的资料",@"我的认证",@"我的VIP",@"我的物流",@"我的金融", nil];
 self.leftImageArr = [[NSMutableArray alloc] initWithObjects:@"",@"我-zh",@"我-d",@"我-zh",@"我-cp",@"我-zl",@"我-rz",@"我-vip",@"我-wl",@"我-jr", nil];
 self.titleArr = [[NSMutableArray alloc] initWithObjects:@"",@"我的账户",@"我的订单",@"我的展会",@"我的产品",@"我的资料",@"我的认证",@"我的VIP",@"我的物流",@"我的金融", nil];
 }else{
 //        self.leftImageArr = [[NSMutableArray alloc] initWithObjects:@"我-gr",@"我-zh",@"我-d",@"我-zl",@"我-rz",@"我-vip",@"我-wl",@"我-jr", nil];
 //        self.titleArr = [[NSMutableArray alloc] initWithObjects:@"个人信息",@"我的账户",@"我的订单",@"我的资料",@"我的认证",@"我的VIP",@"我的物流",@"我的金融", nil];
 self.leftImageArr = [[NSMutableArray alloc] initWithObjects:@"",@"我-zh",@"我-d",@"我-zl",@"我-rz",@"我-vip",@"我-wl",@"我-jr", nil];
 self.titleArr = [[NSMutableArray alloc] initWithObjects:@"",@"我的账户",@"我的订单",@"我的资料",@"我的认证",@"我的VIP",@"我的物流",@"我的金融", nil];
 
 }
 for (int i = 0; i < self.leftImageArr.count; i++) {
 MySelfModel* model = [[MySelfModel alloc] init];
 model.leftImageStr = self.leftImageArr[i];
 model.titleStr = self.titleArr[i];
 [self.datasourceArr addObject:model];
 }
 
 
 [self createTableView];
 [self requestBusinessData];
 [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changIndex) name:@"deng" object:nil];
 
 }
 - (void)viewWillDisappear:(BOOL)animated{
 self.navigationController.navigationBarHidden = NO;
 }
 #pragma mark - 一大堆代理
 - (void)gengduo{
 NSLog(@"更多");
 MoreViewController* vc = [[MoreViewController alloc] init];
 [self.navigationController pushViewController:vc animated:YES];
 }
 - (void)hongbao{
 NSLog(@"红包");
 RedRecordViewController *vc = [[RedRecordViewController alloc] init];
 [self.navigationController pushViewController:vc animated:YES];
 
 }
 - (void)xiaoxi{
 NSLog(@"消息");
 YZMessageViewController *vc = [[YZMessageViewController alloc] init];
 [self.navigationController pushViewController:vc animated:YES];
 }
 - (void)guanzhu{
 NSLog(@"关注");
 MyFocusOnViewController *vc = [[MyFocusOnViewController alloc] init];
 [self.navigationController pushViewController:vc animated:YES];
 }
 #pragma mark - 初始化tableView
 - (void)createTableView{
 self.automaticallyAdjustsScrollViewInsets = NO;
 _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, [MyController getScreenHeight] - 49) style:UITableViewStylePlain];
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
 #pragma mark - tableView行数
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 if (1 == section) {
 return self.datasourceArr.count;
 }
 return self.datasourceArr0.count;
 }
 #pragma mark - tableVie点击cell
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 if ([flag isEqualToString:@"1"]) {
 if (indexPath.section == 1 && indexPath.row == 1) {
 MyAccountViewController *vc = [[MyAccountViewController alloc] init];
 [self.navigationController pushViewController:vc animated:YES];
 }else if (indexPath.section == 1 && indexPath.row == 6){
 MyAuthenticationViewController *vc = [[MyAuthenticationViewController alloc] init];
 [self.navigationController pushViewController:vc animated:YES];
 }else if (indexPath.section == 1 && indexPath.row == 9){
 MyFinanceViewController *vc = [[MyFinanceViewController alloc] init];
 [self.navigationController pushViewController:vc animated:YES];
 }else if (indexPath.section == 1 && indexPath.row == 3){
 //            CreateExhibtionViewController *vc = [[CreateExhibtionViewController alloc] init];
 //            [self.navigationController pushViewController:vc animated:YES];
 MyExhibitionViewController *vc = [[MyExhibitionViewController alloc] init];
 [self.navigationController pushViewController:vc animated:YES];
 }else if (indexPath.section == 1 && indexPath.row == 0){
 BusinessDeViewController *vc = [[BusinessDeViewController alloc] init];
 //          DetailViewController *vc = [[DetailViewController alloc] init];
 [self.navigationController pushViewController:vc animated:YES];
 
 }else if (indexPath.section == 1 && indexPath.row == 5){
 ChangeQiYeViewController *vc = [[ChangeQiYeViewController alloc] init];
 //            ChangeViewController *vc = [[ChangeViewController alloc] init];
 
 [self.navigationController pushViewController:vc animated:YES];
 }
 else if (indexPath.section == 1 && indexPath.row == 4){
 
 MyProductViewController *vc = [[MyProductViewController alloc] init];
 
 [self.navigationController pushViewController:vc animated:YES];
 }
 }else{
 if (indexPath.section == 1 && indexPath.row == 1) {
 MyAccountViewController *vc = [[MyAccountViewController alloc] init];
 [self.navigationController pushViewController:vc animated:YES];
 }else if (indexPath.section == 1 && indexPath.row == 4){
 MyAuthenticationViewController *vc = [[MyAuthenticationViewController alloc] init];
 [self.navigationController pushViewController:vc animated:YES];
 }else if (indexPath.section == 1 && indexPath.row == 7){
 MyFinanceViewController *vc = [[MyFinanceViewController alloc] init];
 [self.navigationController pushViewController:vc animated:YES];
 }else if (indexPath.section == 1 && indexPath.row == 0){
 // BusinessDeViewController *vc = [[BusinessDeViewController alloc] init];
 DetailViewController *vc = [[DetailViewController alloc] init];
 [self.navigationController pushViewController:vc animated:YES];
 
 }else if (indexPath.section == 1 && indexPath.row == 3){
 // ChangeQiYeViewController *vc = [[ChangeQiYeViewController alloc] init];
 ChangeViewController *vc = [[ChangeViewController alloc] init];
 
 [self.navigationController pushViewController:vc animated:YES];
 }
 
 }
 
 
 }
 #pragma mark - 自定义tableView
 - (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 if (0 == indexPath.section) {
 NSString *cellIdentifier = @"MySelf0";
 MySelfSection0TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
 if (!celll) {
 celll = [[MySelfSection0TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
 }
 celll.myselfDelegate = self;
 MySelfSection0Model *model = nil;
 model = [self.datasourceArr0 objectAtIndex:indexPath.row];
 celll.selectionStyle = UITableViewCellSelectionStyleNone;
 [celll configCellWithModel:model];
 
 return celll;
 }
 
 NSString *cellIdentifier = @"MySelf";
 MySelfTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
 if (!celll) {
 celll = [[MySelfTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
 }
 MySelfModel *model = nil;
 model = [self.datasourceArr objectAtIndex:indexPath.row];
 celll.selectionStyle = UITableViewCellSelectionStyleNone;
 [celll configCellWithModel:model];
 
 return celll;
 }
 #pragma mark - tableView行高
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 if (0 == indexPath.section) {
 MySelfSection0Model *model = nil;
 if (indexPath.row < self.datasourceArr0.count) {
 model = [self.datasourceArr0 objectAtIndex:indexPath.row];
 }
 
 return [MySelfSection0TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
 MySelfSection0TableViewCell *cell = (MySelfSection0TableViewCell *)sourceCell;
 // 配置数据
 [cell configCellWithModel:model];
 }];
 }else{
 if (indexPath.row == 0) {
 return 0;
 }else{
 
 MySelfModel *model = nil;
 if (indexPath.row < self.datasourceArr.count) {
 model = [self.datasourceArr objectAtIndex:indexPath.row];
 }
 return [MySelfTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
 MySelfTableViewCell *cell = (MySelfTableViewCell *)sourceCell;
 // 配置数据
 [cell configCellWithModel:model];
 }];
 }
 }
 
 
 
 }
 #pragma mark - tableView组数
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
 return 2;
 }
 - (void)didReceiveMemoryWarning {
 [super didReceiveMemoryWarning];
 // Dispose of any resources that can be recreated.
 }
 
 - (void)requestBusinessData{
 NSString* requestUrl = @"http://123.57.15.162:8080/exhibition/app/user_app!userInfo.action";
 AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
 manager.responseSerializer = [AFJSONResponseSerializer serializer];
 manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
 LoginDataBaseModel* loginModel = [[[DBManager shareManager]getAllLoginModel]lastObject];
 
 
 [manager POST:requestUrl parameters:@{
 
 @"userid":loginModel.userId,
 
 }
 success:^(AFHTTPRequestOperation *operation, id responseObject) {
 NSDictionary *dic = [MyController dictionaryWithJsonString:[responseObject objectForKey:@"data"]];
 NSLog(@"---企业信息数据------%@",dic);
 if ([[responseObject objectForKey:@"result"] intValue]) {
 
 MySelfSection0Model* model1 = [[MySelfSection0Model alloc] init];
 model1.headImageStr = dic[@"img"];
 model1.nameStr = dic[@"nickName"];
 
 
 [self.datasourceArr0 addObject:model1];
 [_tableView reloadData];
 
 }else{
 NSLog(@"请求成功了。。。。但是没有返回userid");
 [HUD error:@"服务器错误"];
 }
 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
 NSLog(@"失败");
 NSLog(@"失败===%@", error);
 [HUD error:@"请检查网络"];
 }];
 }
 @end
*/