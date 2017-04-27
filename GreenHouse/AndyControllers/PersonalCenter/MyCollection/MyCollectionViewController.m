//
//  MyCollectionViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyCollectionViewController.h"

#import "GiftExchangeModel.h"

#import "GiftExchangeTableViewCell.h"

#import "GiftDetailViewController.h"
@interface MyCollectionViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr;
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,assign)BOOL isNoFirst;
@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.isNoFirst = NO;
    self.title = @"我的收藏";
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    
    self.pageIndex = 1;
    self.userid = [MyController getUserid];
    
    [self createTableView];
    
    [_tableView.header beginRefreshing];
}
- (void)viewWillAppear:(BOOL)animated{
    if (self.isNoFirst) {
        [self createRequest];
    }
    self.isNoFirst = YES;
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7]) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [UIColor whiteColor];
    [_tableView setBackgroundView:tableBg];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headRefresh];
    }];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{//精度
        [self footRefresh];
    }];
}
- (void)headRefresh{
    self.pageIndex = 1;
    
    [self createRequest];
}
- (void)footRefresh{
    self.pageIndex++;
    
    [self createRequest];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasourceArr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GiftExchangeModel* model = self.datasourceArr[indexPath.row];
    GiftDetailViewController* vc = [[GiftDetailViewController alloc] init];
    vc.presentId = model.idStr;
    [self.navigationController pushViewController:vc animated:YES];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"GiftExchange";
    GiftExchangeTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[GiftExchangeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    GiftExchangeModel* model = self.datasourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GiftExchangeModel *model = nil;
    if (indexPath.row < self.datasourceArr.count) {
        model = [self.datasourceArr objectAtIndex:indexPath.row];
    }
    return [GiftExchangeTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        GiftExchangeTableViewCell *cell = (GiftExchangeTableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}
- (void)createRequest{
    NSString* requestUrl = MYCOLLECTIONURL;
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
                      GiftExchangeModel* s0Model = [[GiftExchangeModel alloc] init];
                      s0Model.headImageStr = dic[@"thumb"];
                      s0Model.titleNameStr = dic[@"title"];
                      s0Model.addressStr = dic[@"jfqy"];
                      s0Model.idStr = dic[@"id"];
                      s0Model.timeStr = [NSString stringWithFormat:@"兑换截至：%@",dic[@"endtime"]];//@"兑换截至：2016-05-05";
                      s0Model.jifenStr = [NSString stringWithFormat:@"积分 %@",dic[@"point"]];//@"积分 40";
                      s0Model.shichangjiaStr = [NSString stringWithFormat:@"市场价：￥%@",dic[@"price"]];//@"市场价：￥20.00";
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
