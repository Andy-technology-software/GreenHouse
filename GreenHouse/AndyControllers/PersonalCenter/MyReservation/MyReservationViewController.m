//
//  MyReservationViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyReservationViewController.h"

#import "MyReservationModel.h"

#import "MyReservationTableViewCell.h"

#import "GiftDetailViewController.h"

#import "MyAddressViewController.h"

#import "MyAddressModel.h"

#import "AppointmentDetailsViewController.h"

#import "ResubmitViewController.h"
@interface MyReservationViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,MyAddressViewControllerDelegate,AppointmentDetailsViewControllerDelegate,ResubmitViewControllerDelegate,AppointmentDetailsViewControllerDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr;
//请求需要的参数
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,assign)NSInteger deleteIndex;

@end

@implementation MyReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的预约";
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    
    self.pageIndex = 1;
    self.userid = [MyController getUserid];
    
    [self createTableView];
    
    [_tableView.header beginRefreshing];
}
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)sendBackIsSendSuccess:(BOOL)isSuccess{
    if (isSuccess) {
        [self createRequest];
    }
}
- (void)sendBackDeleteIndex:(NSInteger)deleteIndex{
    [self.datasourceArr removeObjectAtIndex:deleteIndex];
    [_tableView reloadData];
}
#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7]) style:UITableViewStylePlain];
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
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self headRefresh];
    }];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{//精度
        // 进入刷新状态后会自动调用这个block
        [self footRefresh];
    }];
}
#pragma mark - 下拉刷新
- (void)headRefresh{
    self.pageIndex = 1;
    
    [self createRequest];
}
#pragma mark - 上拉加载
- (void)footRefresh{
    self.pageIndex++;
    
    [self createRequest];
}
#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasourceArr.count;
}
#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyReservationModel* s0Model = self.datasourceArr[indexPath.row];
    AppointmentDetailsViewController* vc = [[AppointmentDetailsViewController alloc] init];
    vc.presentId = s0Model.orderid;
    vc.goodsId = s0Model.goodsid;
    vc.deleteIndex = indexPath.row;
    vc.AppointmentDetailsViewControllerDelegate = self;
    vc.title = @"兑换详情";
    vc.typeInt = s0Model.typeInt;
    vc.remark = s0Model.titleNameStr;
    vc.AppointmentDetailsViewControllerDelegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)sendBackNeedRefresh:(BOOL)isNeedRefresh{
    if (isNeedRefresh) {
        [self createRequest];
    }
}
#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"MyReservation";
    MyReservationTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[MyReservationTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    MyReservationModel* model = self.datasourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyReservationModel *model = nil;
    if (indexPath.row < self.datasourceArr.count) {
        model = [self.datasourceArr objectAtIndex:indexPath.row];
    }
    return [MyReservationTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        MyReservationTableViewCell *cell = (MyReservationTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UITableViewRowAction *layTopRowAction1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        self.deleteIndex = indexPath.row;
        
        UIAlertView* al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要删除该预约？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [al show];
        [tableView setEditing:NO animated:YES];
    }];
    layTopRowAction1.backgroundColor = [UIColor redColor];
    UITableViewRowAction *layTopRowAction2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"编辑" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        self.deleteIndex = indexPath.row;
        
        MyReservationModel* model = self.datasourceArr[indexPath.row];
        
        ResubmitViewController* vc = [[ResubmitViewController alloc] init];
        vc.presentId = model.orderid;
        vc.remark = model.titleNameStr;
        vc.ResubmitViewControllerDelegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        [tableView setEditing:NO animated:YES];
    }];
    layTopRowAction2.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    
    NSArray *arr = @[layTopRowAction1,layTopRowAction2];
    return arr;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (1 == buttonIndex) {
        [HUD loading];
        MyReservationModel* model = self.datasourceArr[self.deleteIndex];
        [self createDeleteMyYuyue:model.orderid AndDeleteIndex:self.deleteIndex];
    }
}
- (void)sendBackAddress:(MyAddressModel *)addressModel{
    MyReservationModel* model = self.datasourceArr[self.deleteIndex];
    
    [self createUpdateMyYuyue:model.orderid andAddressId:addressModel.myAddressidId];
}
- (void)createRequest{
    NSString* requestUrl = MYBESPOKEURL;
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestUrl parameters:@{
                                          @"userid":self.userid,
                                          @"pnum":[NSString stringWithFormat:@"%ld",self.pageIndex],
                                          @"num":@"10"
                                          }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSData *jsonData = [[responseObject objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
              NSArray *sourceArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
              NSMutableArray *_array = [NSMutableArray arrayWithCapacity:0];
              if (![sourceArr isKindOfClass:[NSNull class]]) {
                  for (NSDictionary* dic in sourceArr) {
                      MyReservationModel* s0Model = [[MyReservationModel alloc] init];
                      s0Model.headImageStr = dic[@"thumb"];
                      s0Model.titleNameStr = dic[@"remark"];
                      s0Model.addressStr = dic[@"jfqy"];
                      s0Model.timeStr = [NSString stringWithFormat:@"兑换截至：%@",dic[@"endtime"]];
                      s0Model.jifenStr = [NSString stringWithFormat:@"积分 %@",dic[@"point"]];//@"积分 40";
                      s0Model.yuyueTypeStr = dic[@"givetype"];
                      s0Model.typeInt = 0;//[dic[@"typeInt"] intValue];
                      s0Model.goodsid = dic[@"goodsid"];
                      s0Model.orderid = dic[@"orderid"];
                      [_array addObject:s0Model];
                  }
                  if (self.pageIndex == 1) {
                      [self.datasourceArr removeAllObjects];
                      [self.datasourceArr addObjectsFromArray:_array];
                      [_tableView reloadData];
                      [_tableView.header endRefreshing];
                  }else {
                      [self.datasourceArr addObjectsFromArray:_array];
                      [_tableView reloadData];
                      [_tableView.footer endRefreshing];
                  }
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
                  [_tableView.header endRefreshing];
                  [_tableView.footer endRefreshing];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"加载失败"];
              [_tableView.header endRefreshing];
              [_tableView.footer endRefreshing];
          }];
}
- (void)createDeleteMyYuyue:(NSString*)idStr AndDeleteIndex:(NSInteger)index{
    
    NSString* requestAddress = BESPOKEDELETEURL;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"id":idStr
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD success:responseObject[@"data"]];
                  [self.datasourceArr removeObjectAtIndex:index];
                  [_tableView reloadData];
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"请检查网络"];
          }];
}
- (void)createUpdateMyYuyue:(NSString*)idStr andAddressId:(NSString*)addressId{
    
    NSString* requestAddress = BESPOKEUPDATEURL;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid,
                                              @"id":idStr,
                                              @"info":addressId
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD success:responseObject[@"data"]];
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"请检查网络"];
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
