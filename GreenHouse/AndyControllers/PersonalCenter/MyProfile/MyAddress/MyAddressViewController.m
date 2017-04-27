//
//  MyAddressViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/4/26.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyAddressViewController.h"

#import "MyAddressModel.h"

#import "MyAddressTableViewCell.h"

#import "AddCommonlyUsedAddressViewController.h"
@interface MyAddressViewController ()<UITableViewDataSource,UITableViewDelegate,AddCommonlyUsedAddressViewControllerDelegate,UIAlertViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr;
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,assign)NSInteger deleteIndex;

@end

@implementation MyAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.userid = [MyController getUserid];
    if (self.isDingdian) {
        self.title = @"定点地址";
    }else{
        self.title = @"我的地址";
    }
    
    self.pageIndex = 1;
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    
    [self createTableView];
    
    [self makeBottomUI];
    [_tableView.header beginRefreshing];
}
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)sendBackNeedLoading:(BOOL)needLoading{
    if (needLoading) {
        [self createGetMyAddress];
    }
}
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    [self.view addSubview:bottomView];
    
    UIButton* makeSureBtn = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:@"添加常用地址"];
    [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:makeSureBtn];
}
- (void)makeSureBtnClick{
    AddCommonlyUsedAddressViewController* vc = [[AddCommonlyUsedAddressViewController alloc] init];
    vc.AddCommonlyUsedAddressViewControllerDelegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (self.isDingdian) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7]) style:UITableViewStylePlain];
    }else{
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 40) style:UITableViewStylePlain];
    }
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [UIColor whiteColor];
    [_tableView setBackgroundView:tableBg];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    //_tableView.backgroundColor = [UIColor colorWithRed:190 green:30 blue:96 alpha:1];
    [self.view addSubview:_tableView];
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headRefresh];
    }];
    
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self footRefresh];
    }];
}
- (void)headRefresh{
    self.pageIndex = 1;
    if (self.isDingdian) {
        [self createGetDingdianAddress];
    }else{
        [self createGetMyAddress];
    }
}
- (void)footRefresh{
    self.pageIndex++;
    if (self.isDingdian) {
        [self createGetDingdianAddress];
    }else{
        [self createGetMyAddress];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasourceArr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.isNeedBack) {
        MyAddressModel* model = self.datasourceArr[indexPath.row];
        [self.MyAddressViewControllerDelegate sendBackAddress:model];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"Myaddress";
    MyAddressTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[MyAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    MyAddressModel* model = self.datasourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyAddressModel *model = nil;
    if (indexPath.row < self.datasourceArr.count) {
        model = [self.datasourceArr objectAtIndex:indexPath.row];
    }
    return [MyAddressTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        MyAddressTableViewCell *cell = (MyAddressTableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isDingdian) {
        return NO;
    }
    return YES;
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *layTopRowAction1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        self.deleteIndex = indexPath.row;
        
        UIAlertView* al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要删除该地址？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [al show];
        
        [tableView setEditing:NO animated:YES];
    }];

    NSArray *arr = @[layTopRowAction1];
    return arr;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (1 == buttonIndex) {
        MyAddressModel* model = self.datasourceArr[self.deleteIndex];
        [self createDeleteMyAddress:model.myAddressidId AndDeleteIndex:self.deleteIndex];
    }
}
- (void)createGetMyAddress{
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    
    NSString* requestAddress = MYADDRESS;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD hide];
                  NSArray* temA = [[NSArray alloc] init];
                  temA = [MyController arraryWithJsonString:responseObject[@"data"]];
                  for (NSDictionary* dic in temA) {
                      MyAddressModel* model = [[MyAddressModel alloc] init];
                      model.titleStr = [NSString stringWithFormat:@"%@ %@ %@",dic[@"city"],dic[@"area"],dic[@"address"]];
                      model.telStr = [NSString stringWithFormat:@"手机：%@",dic[@"tel"]];//@"手机：1212312312";
                      model.nameStr = dic[@"addressee"];
                      model.myAddressidId = dic[@"addressid"];
                      model.isdefault = [dic[@"isdefault"] boolValue];
                      [self.datasourceArr addObject:model];
                  }
                  [_tableView reloadData];
                  [_tableView.header endRefreshing];
                  [_tableView.footer endRefreshing];
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"请检查网络"];
          }];
}
- (void)createDeleteMyAddress:(NSString*)idStr AndDeleteIndex:(NSInteger)index{
    [HUD loading];
    
    NSString* requestAddress = DELETEADDRESS;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid,
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
- (void)createGetDingdianAddress{
    NSString* requestAddress = PRESENTADDRESSURL;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"pnum":[NSString stringWithFormat:@"%ld",self.pageIndex],
                                              @"num":@"10"
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD hide];
                  NSArray* temA = [[NSArray alloc] init];
                  temA = [MyController arraryWithJsonString:responseObject[@"data"]];
                   NSMutableArray *_array = [NSMutableArray arrayWithCapacity:0];
                  for (NSDictionary* dic in temA) {
                      MyAddressModel* model = [[MyAddressModel alloc] init];
                      model.titleStr = [NSString stringWithFormat:@"地址：%@",dic[@"name"]];
                      model.telStr = [NSString stringWithFormat:@"说明：%@",dic[@"remark"]];//@"手机：1212312312";
                      model.nameStr = @"  ";
                      model.myAddressidId = dic[@"lid"];
                      model.isdefault = [dic[@"isdefault"] boolValue];
                      [_array addObject:model];
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
              [HUD error:@"请检查网络"];
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
