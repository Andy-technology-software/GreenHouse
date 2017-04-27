//
//  JiuwuDetailViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/7/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "JiuwuDetailViewController.h"

#import "JiuwuDetailModel.h"

#import "JiuwuDetailViewTableViewCell.h"

#import "RecyclingCarViewController.h"

#import "NewOnTheRecyclingIndexViewController.h"
@interface JiuwuDetailViewController ()<UITableViewDataSource,UITableViewDelegate,JiuwuDetailViewTableViewCellDelegate>{
    UITableView* _tableView;
    double qty;
    UIButton*rightButton1;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr;
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,copy)NSString* info;

@end

@implementation JiuwuDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"旧物详情";
    
    self.userid = [MyController getUserid];
    
    self.info = @"";
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    
    [self.datasourceArr addObject:self.jiuwuModel];
    
    [self createTableView];
    
    [self makeBottomUI];
    
    [self createRightNav];
}

- (void)viewWillAppear:(BOOL)animated{
    [self createJiuwucheRequest];
}
- (void)sendBackShuliangStr:(NSString *)shuliangStr{
    JiuwuDetailModel* model = [self.datasourceArr lastObject];
    model.jianStr = shuliangStr;
    qty = [shuliangStr floatValue];
    model.jifenStr = [NSString stringWithFormat:@"%.2f",[model.jianStr intValue] * [self.point floatValue]];
    [_tableView reloadData];
}
- (void)backBtnClick{
    for (UIViewController *controller in self.navigationController.viewControllers) {
           if ([controller isKindOfClass:[NewOnTheRecyclingIndexViewController class]]) {
                   [self.navigationController popToViewController:controller animated:YES];
               }
    }
}
- (void)createRightNav{
    rightButton1 = [[UIButton alloc]initWithFrame:CGRectMake(160,0,30,30)];
    [rightButton1 setImage:[UIImage imageNamed:@"shopcar"]forState:UIControlStateNormal];
    [rightButton1 setImage:[UIImage imageNamed:@"shopcar"] forState:UIControlStateHighlighted];
    [rightButton1 addTarget:self action:@selector(carBtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:rightButton1];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightItem1, nil];
}

- (void)carBtnClick{
    RecyclingCarViewController* vc = [[RecyclingCarViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    [self.view addSubview:bottomView];
    
    UIButton* makeSureBtn = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:@"加入旧物车"];
    [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:makeSureBtn];
    
    UIView* lineV = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 0.5)];
    lineV.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    [bottomView addSubview:lineV];
}
- (void)makeSureBtnClick{
    JiuwuDetailModel* model = [self.datasourceArr lastObject];
    if (![MyController isBlankString:model.jianStr]) {
        self.info = [NSString stringWithFormat:@"{\"gilfstyle\":\"%@\",\"guige\":\"%@\",\"qty\":%.2f,\"point\":\"%@\"}",self.gilfstyle,self.guige,qty,self.point];
        [HUD loading];
        [self createRequest];
    }else{
        [HUD warning:@"请输入预估数量"];
    }
    
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7]  -40) style:UITableViewStylePlain];
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
    NSString *cellIdentifier = @"jiuwuDetail";
    JiuwuDetailViewTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[JiuwuDetailViewTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.JiuwuDetailViewTableViewCellDelegate = self;
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    JiuwuDetailModel* model = self.datasourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    JiuwuDetailModel *model = nil;
    if (indexPath.row < self.datasourceArr.count) {
        model = [self.datasourceArr objectAtIndex:indexPath.row];
    }
    return [JiuwuDetailViewTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        JiuwuDetailViewTableViewCell *cell = (JiuwuDetailViewTableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}
- (void)createRequest{
    NSString* requestUrl = CRATCREATE;
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestUrl parameters:@{
                                          @"userid":self.userid,
                                          @"info ":self.info
                                          }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSArray* sourceArr = [MyController arraryWithJsonString:responseObject[@"data"]];
              if ([responseObject[@"result"] intValue]) {
                  [HUD success:responseObject[@"data"]];
                  [self.navigationController popViewControllerAnimated:YES];
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"加载失败"];
          }];
}
- (void)createJiuwucheRequest{
    NSString* requestUrl = CARLIST;
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestUrl parameters:@{
                                          @"userid":self.userid,
                                          @"pnum":@"1",
                                          @"num":@"10"
                                          }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSData *jsonData = [[responseObject objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
              NSArray *sourceArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
              if (sourceArr.count) {
                  [rightButton1 setImage:[UIImage imageNamed:@"shopcar_red"]forState:UIControlStateNormal];
              }else{
                  [rightButton1 setImage:[UIImage imageNamed:@"shopcar"]forState:UIControlStateNormal];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
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
