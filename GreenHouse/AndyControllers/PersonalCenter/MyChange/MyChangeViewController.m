//
//  MyChangeViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyChangeViewController.h"

#import "MyReservationModel.h"

#import "MyReservationTableViewCell.h"

#import "GiftDetailViewController.h"

#import "AppointmentDetailsViewController.h"
@interface MyChangeViewController ()<UITableViewDataSource,UITableViewDelegate,AppointmentDetailsViewControllerDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr;
//请求需要的参数
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,assign)NSInteger pageIndex;
@end

@implementation MyChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的兑换";
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    
    self.pageIndex = 1;
    self.userid = [MyController getUserid];
    
    [self createTableView];
    
    [_tableView.header beginRefreshing];
}
- (void)viewWillAppear:(BOOL)animated{
    
}

#pragma mark - 临时数据
- (void)makeData{
    for (int i = 0; i < 10; i++) {
        MyReservationModel* s0Model = [[MyReservationModel alloc] init];
        s0Model.headImageStr = @"http://g.hiphotos.baidu.com/news/q%3D100/sign=6424915b0dd162d983ee661c21dea950/359b033b5bb5c9ea73e2dc7cd239b6003af3b318.jpg";
        s0Model.titleNameStr = @"大花棉袄";
        s0Model.addressStr = @"浦东区";
        s0Model.timeStr = @"兑换截至：2016-05-05";
        s0Model.jifenStr = @"积分 40";
        s0Model.yuyueTypeStr = @"自己兑换";
        [self.datasourceArr addObject:s0Model];
    }
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
//    MyReservationModel* s0Model = self.datasourceArr[indexPath.row];
//    GiftDetailViewController* vc = [[GiftDetailViewController alloc] init];
//    vc.presentId = s0Model.goodsid;
//    [self.navigationController pushViewController:vc animated:YES];
    MyReservationModel* s0Model = self.datasourceArr[indexPath.row];
    AppointmentDetailsViewController* vc = [[AppointmentDetailsViewController alloc] init];
    vc.presentId = s0Model.orderid;
    vc.goodsId = s0Model.goodsid;
    vc.deleteIndex = indexPath.row;
    vc.title = @"兑换详情";
    vc.remark = s0Model.titleNameStr;
    vc.typeInt = s0Model.typeInt;
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
#pragma mark - 我的兑换数据请求
- (void)createRequest{
    NSString* requestUrl = MYCASHINGURL;
    NSLog(@"-----%@",requestUrl);
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
              NSLog(@"我的预约----%@",responseObject[@"data"]);
              NSMutableArray *_array = [NSMutableArray arrayWithCapacity:0];
              if (![sourceArr isKindOfClass:[NSNull class]]) {
                  for (NSDictionary* dic in sourceArr) {
                      MyReservationModel* s0Model = [[MyReservationModel alloc] init];
                      s0Model.headImageStr = dic[@"thumb"];
                      s0Model.titleNameStr = dic[@"remark"];
                      s0Model.addressStr = dic[@"jfqy"];
                      if ([@"待兑换" isEqualToString: dic[@"status"]]) {
                          s0Model.typeInt = 2;
                      }else if ([@"已完成" isEqualToString: dic[@"status"]]){
                          s0Model.typeInt = 3;
                      }
                      s0Model.timeStr = [NSString stringWithFormat:@"兑换截至：%@",dic[@"endtime"]];
                      s0Model.jifenStr = [NSString stringWithFormat:@"积分 %@",dic[@"point"]];//@"积分 40";
                      s0Model.yuyueTypeStr = dic[@"givetype"];
                      s0Model.goodsid = dic[@"goodsid"];
                      s0Model.orderid = dic[@"orderid"];
                      [_array addObject:s0Model];
                  }
                  //循环完成
                  if (self.pageIndex == 1) {
                      //删除原有数据 对数据源重新追加数据
                      [self.datasourceArr removeAllObjects];
                      [self.datasourceArr addObjectsFromArray:_array];
                      NSLog(@"数据源----%@",self.datasourceArr);
                      //刷新表格
                      [_tableView reloadData];
                      //下拉刷新停止
                      [_tableView.header endRefreshing];
                  }else {
                      //对现有数据源进行追加数据
                      [self.datasourceArr addObjectsFromArray:_array];
                      //刷新表格
                      [_tableView reloadData];
                      //上拉加载停止
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
              NSLog(@"-----%@",error);
              [_tableView.header endRefreshing];
              [_tableView.footer endRefreshing];
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
