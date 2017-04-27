//
//  CodeAndDeliveryViewController.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/4/24.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "CodeAndDeliveryViewController.h"

#import "CodeAndDeliveryS0Model.h"

#import "CodeAndDeliveryS0TableViewCell.h"

#import "DeliverySuccessViewController.h"
@interface CodeAndDeliveryViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr;
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,copy)NSString* info;
@property(nonatomic,copy)NSString* xianghao;
@end

@implementation CodeAndDeliveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"扫码投递";
    
    self.userid = [MyController getUserid];
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    
    [self createTableView];
    
    [self makeBottomUI];
    
    [HUD loading];
    
    [self createScanpostRequest];
}
- (void)viewWillAppear:(BOOL)animated{

}
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 100)];
    [self.view addSubview:bottomView];
    
    UILabel* infoLable = [MyController createLabelWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 60) Font:14 Text:@"请耐心等待10秒开始投递。\n请2分钟内投递完成。"];
    infoLable.backgroundColor = [UIColor clearColor];
    infoLable.textAlignment = NSTextAlignmentCenter;
    infoLable.numberOfLines = 3;
    infoLable.alpha = 0.6;
    [bottomView addSubview:infoLable];
    
    UIButton* makeSureBtn = [MyController createButtonWithFrame:CGRectMake(0, 60, [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:@"知道了"];
    [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:makeSureBtn];
}
- (void)makeSureBtnClick{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 100) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [MyController colorWithHexString:@"f6f6f6"];
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
    NSString *cellIdentifier = @"codeAndDelivery";
    CodeAndDeliveryS0TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[CodeAndDeliveryS0TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    CodeAndDeliveryS0Model* model = self.datasourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CodeAndDeliveryS0Model *model = nil;
    if (indexPath.row < self.datasourceArr.count) {
        model = [self.datasourceArr objectAtIndex:indexPath.row];
    }
    return [CodeAndDeliveryS0TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        CodeAndDeliveryS0TableViewCell *cell = (CodeAndDeliveryS0TableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}

- (void)createScanpostRequest{
    self.datasourceArr = [[NSMutableArray alloc] init];
    NSString* requestAddress = SCANPOSTURL;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid,
                                              @"code":self.code
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD hide];
                  NSString *dataStr = [responseObject objectForKey:@"data"];
                  NSDictionary* temDic = [MyController dictionaryWithJsonString:dataStr];
                  
                  CodeAndDeliveryS0Model* s0Model = [[CodeAndDeliveryS0Model alloc] init];
                  s0Model.titleArr = [[NSMutableArray alloc] init];
                  [s0Model.titleArr addObject:[NSString stringWithFormat:@"  箱号：%@",temDic[@"hsxbh"]]];
                  self.xianghao = temDic[@"xqmc"];
                  [s0Model.titleArr addObject:[NSString stringWithFormat:@"  地址：%@",temDic[@"jtdz"]]];
                  [s0Model.titleArr addObject:[NSString stringWithFormat:@"  您的IC卡号：%@",temDic[@"cardNo"]]];
                  s0Model.toudiImageStr = temDic[@"fileurl"];
                  s0Model.toudiStatusStr = [NSString stringWithFormat:@"  状态：%@",temDic[@"hsxzt"]];
                  [self.datasourceArr addObject:s0Model];
                  
                  [_tableView reloadData];
                  
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
              [_tableView reloadData];
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"请检查网络"];
          }];
}

- (void)createSuccesspostRequest{
    self.datasourceArr = [[NSMutableArray alloc] init];
    NSString* requestAddress = COMPLETEPOST;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid,
                                              @"code":self.xianghao
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  NSString *dataStr = [responseObject objectForKey:@"data"];
                  [HUD success:dataStr];
                  [self.navigationController popViewControllerAnimated:YES];
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
