//
//  MyRecoveryDetailViewController.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/8/7.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyRecoveryDetailViewController.h"

#import "MyRecoveryDetailS0Model.h"

#import "MyRecoveryDetailS1Model.h"

#import "MyPointsModel.h"

#import "MyRecoveryDetailS0TableViewCell.h"

#import "MyPointsTableViewCell.h"

#import "MyRecoveryDetailS2TableViewCell.h"
@interface MyRecoveryDetailViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr0;
@property(nonatomic,retain)NSMutableArray* datasourceArr1;
@property(nonatomic,retain)NSMutableArray* datasourceArr2;
@property(nonatomic,copy)NSString* userid;
@end

@implementation MyRecoveryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"详情";
    
    self.userid = [MyController getUserid];
    
    self.datasourceArr0 = [[NSMutableArray alloc] init];
    self.datasourceArr1 = [[NSMutableArray alloc] init];
    self.datasourceArr2 = [[NSMutableArray alloc] init];
    
    [self createTableView];
    
    [HUD loading];
    [self createRequest];
}
- (void)viewWillAppear:(BOOL)animated{
    
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
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return self.datasourceArr0.count;
    }else if (1 == section){
        return self.datasourceArr1.count;
    }
    return self.datasourceArr2.count;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        NSString *cellIdentifier = @"xiangqing0";
        MyRecoveryDetailS0TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[MyRecoveryDetailS0TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        MyRecoveryDetailS0Model* model = self.datasourceArr0[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }else if (1 == indexPath.section){
        NSString *cellIdentifier = @"xiangqing1";
        MyPointsTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[MyPointsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        MyPointsModel* model = self.datasourceArr1[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }
    NSString *cellIdentifier = @"xiangqing2";
    MyRecoveryDetailS2TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[MyRecoveryDetailS2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    MyRecoveryDetailS1Model* model = self.datasourceArr2[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        MyRecoveryDetailS0Model *model = nil;
        if (indexPath.row < self.datasourceArr0.count) {
            model = [self.datasourceArr0 objectAtIndex:indexPath.row];
        }
        return [MyRecoveryDetailS0TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            MyRecoveryDetailS0TableViewCell *cell = (MyRecoveryDetailS0TableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }else if (1 == indexPath.section){
        MyPointsModel *model = nil;
        if (indexPath.row < self.datasourceArr1.count) {
            model = [self.datasourceArr1 objectAtIndex:indexPath.row];
        }
        return [MyPointsTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            MyPointsTableViewCell *cell = (MyPointsTableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }
    MyRecoveryDetailS1Model *model = nil;
    if (indexPath.row < self.datasourceArr2.count) {
        model = [self.datasourceArr2 objectAtIndex:indexPath.row];
    }
    return [MyRecoveryDetailS2TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        MyRecoveryDetailS2TableViewCell *cell = (MyRecoveryDetailS2TableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (1 == section) {
        return 40;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* titView = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40)];
    titView.backgroundColor = [MyController colorWithHexString:@"f6f6f6"];
    
    UILabel* temL = [MyController createLabelWithFrame:CGRectMake(10, 0, 200, 40) Font:14 Text:@"旧物列表"];
    [titView addSubview:temL];
    
    return titView;
}
- (void)createRequest{
    NSString* requestUrl = MYBACKDETAIL;
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestUrl parameters:@{
                                          @"userid":self.userid,
                                          @"id ":self.idStr
                                          }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSDictionary* sourceDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
              if ([responseObject[@"result"] intValue]) {
                  [HUD hide];
                  MyRecoveryDetailS0Model* s0Mdel = [[MyRecoveryDetailS0Model alloc] init];
                  s0Mdel.zhuangtaiStr = sourceDic[@"state"];
                  s0Mdel.lianxirenStr = [MyController returnStr:[NSString stringWithFormat:@"%@",sourceDic[@"dlzh"]]];
                  s0Mdel.dizhiStr = sourceDic[@"shdz"];
                  s0Mdel.dianhuaStr = sourceDic[@"lxfs"];
                  [self.datasourceArr0 addObject:s0Mdel];
                  
                  NSArray* temArr = sourceDic[@"detail"];
                  for (NSDictionary* dic in temArr) {
                      MyPointsModel* model = [[MyPointsModel alloc] init];
                      model.jifenStr = [NSString stringWithFormat:@"%2.f",[dic[@"point"] floatValue]];
                      model.titleStr = dic[@"gilfstyle"];
                      model.timeStr = dic[@"gilfno"];//@"2010 01-01 10:23";
                      [self.datasourceArr1 addObject:model];
                  }
                  MyRecoveryDetailS1Model* S2Model = [[MyRecoveryDetailS1Model alloc] init];
                  S2Model.yuyueStr = sourceDic[@"createDate"];
                  S2Model.huishouStr = sourceDic[@"shrq"];
                  [self.datasourceArr2 addObject:S2Model];
                  
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
