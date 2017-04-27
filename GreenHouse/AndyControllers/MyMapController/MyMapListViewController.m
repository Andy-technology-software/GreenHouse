//
//  MyMapListViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/4/26.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyMapListViewController.h"

#import "MapListModel.h"

#import "MapListTableViewCell.h"
@interface MyMapListViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr;
@property (nonatomic,assign)CLLocationCoordinate2D dingwei;
@property(nonatomic,copy)NSString* userid;
@end

@implementation MyMapListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    
    self.userid = [MyController getUserid];
    
    [self createTableView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(List:) name:@"List" object:nil];
}
- (void)List:(NSNotification *)text{

    [self getLat];
    
}
- (void)viewWillAppear:(BOOL)animated{

}
-(void)getLat {
    [[CCLocationManager shareLocation] getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
        self.dingwei = locationCorrrdinate;
        
        [self createRequest];
    }];
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 40) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [UIColor whiteColor];
    [_tableView setBackgroundView:tableBg];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasourceArr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"MapList";
    MapListTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[MapListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    MapListModel* model = self.datasourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MapListModel *model = nil;
    if (indexPath.row < self.datasourceArr.count) {
        model = [self.datasourceArr objectAtIndex:indexPath.row];
    }
    return [MapListTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        MapListTableViewCell *cell = (MapListTableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}

- (void)createRequest{
    [HUD loading];
    self.datasourceArr = [[NSMutableArray alloc] init];
    NSString* requestUrl = BACKMAPURL;
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestUrl parameters:@{
                                          @"userid":self.userid,
                                          @"jingdu":[NSString stringWithFormat:@"%.6f",self.dingwei.longitude],
                                          @"weidu":[NSString stringWithFormat:@"%.6f",self.dingwei.latitude]
                                          }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSData *jsonData = [[responseObject objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
              NSArray *sourceArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
              if (![sourceArr isKindOfClass:[NSNull class]]) {
                  [HUD hide];
                  for (NSDictionary* dic in sourceArr) {
                      MapListModel* s0Model = [[MapListModel alloc] init];
                      s0Model.bianhaoStr = [NSString stringWithFormat:@"编号：%@",dic[@"hsxbh"]];//@"编号：007";
                      s0Model.dizhiStr = dic[@"jtdz"];
                      s0Model.zhunagtaiStr= [NSString stringWithFormat:@"状态：%@",dic[@"hsxzt"]];//@"状态：可投递";
                      s0Model.juliStr = [NSString stringWithFormat:@"%.2fkm",[dic[@"distance"] floatValue]];//@"0.02Km";
                      [self.datasourceArr addObject:s0Model];
                  }
                  [_tableView reloadData];
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"加载失败"];
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
