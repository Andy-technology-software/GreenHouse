//
//  MyICCardViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyICCardViewController.h"

#import "ICCardHeaderModel.h"

#import "ICManagementHeaderView.h"

#import "ICManagementModel.h"

#import "ICManagementTableViewCell.h"
@interface MyICCardViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
    FDAlertView *alert;
    UIButton* makeSureBtn;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr;
@property(nonatomic,retain)NSMutableArray* headDatasourceArr;
@property(nonatomic,retain)UIView* popView;
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,copy)NSString* codeStr;

@end

@implementation MyICCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"IC卡管理";
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    self.headDatasourceArr = [[NSMutableArray alloc] init];
    
    self.userid = [MyController getUserid];
    
    [self makeData];
    
    [self createTableView];
    
    [self makeBottomUI];
    
    [HUD loading];
    [self createMtICCard];
}
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    [self.view addSubview:bottomView];
    
    makeSureBtn = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:@"开始绑定"];
    [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:makeSureBtn];
}
- (void)makeSureBtnClick{
    [self BtnClick];
}
- (void)BtnClick{
    self.popView = [MyController createImageViewWithFrame:CGRectMake(20, [MyController getScreenHeight] / 2 - 100, [MyController getScreenWidth] - 40, 200) ImageName:nil];
    self.popView.backgroundColor = [MyController colorWithHexString:@"6b7479"];
    
    UIView* bv = [MyController createImageViewWithFrame:CGRectMake(0, 0, self.popView.frame.size.width, 200) ImageName:nil];
    bv.backgroundColor = [UIColor whiteColor];
    [self.popView addSubview:bv];
    
    UILabel* titLable = [MyController createLabelWithFrame:CGRectMake(0, 0, self.popView.frame.size.width, 50) Font:16 Text:@"IC卡绑定"];
    titLable.textAlignment = NSTextAlignmentCenter;
    [self.popView addSubview:titLable];
    
    UILabel* titLable1 = [MyController createLabelWithFrame:CGRectMake(20, CGRectGetMaxY(titLable.frame), self.popView.frame.size.width - 40, 50) Font:14 Text:@"请输入IC卡号"];
    [self.popView addSubview:titLable1];
    
    UITextField* tf = [MyController createTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(titLable1.frame), self.popView.frame.size.width - 40, 40) placeholder:@"请输入卡号" passWord:NO leftImageView:nil rightImageView:nil Font:14];
    tf.tag = 10086;
    tf.layer.borderColor= [UIColor lightGrayColor].CGColor;
    tf.layer.borderWidth= 0.5;
    [self.popView addSubview:tf];
    
    UIButton* sureBtn = [MyController createButtonWithFrame:CGRectMake(0, CGRectGetMaxY(tf.frame) + 10, self.popView.frame.size.width / 2, 50) ImageName:nil Target:self Action:@selector(sureBtnClick) Title:@"确定"];
    [sureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.popView addSubview:sureBtn];
    
    UIButton* cancleBtn = [MyController createButtonWithFrame:CGRectMake(self.popView.frame.size.width / 2, CGRectGetMaxY(tf.frame) + 10, self.popView.frame.size.width / 2, 50) ImageName:nil Target:self Action:@selector(cancleBtnClick) Title:@"取消"];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancleBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.popView addSubview:cancleBtn];
    
    UIView* linV = [MyController viewWithFrame:CGRectMake(0, sureBtn.frame.origin.y, self.popView.frame.size.width, 0.5)];
    linV.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [self.popView addSubview:linV];
    
    alert = [[FDAlertView alloc] init];
    alert.contentView = self.popView;
    [alert show];
}
#pragma mark - 确定响应
- (void)sureBtnClick{
    UITextField* tf = (UITextField*)[self.popView viewWithTag:10086];
    if ([MyController isBlankString:tf.text]) {
        [HUD error:@"请输入卡号"];
        return;
    }else{
        [alert hide];
        [HUD loading];
        [self createBindingICCard];
    }
}
- (void)cancleBtnClick{
    [alert hide];
}

- (void)makeData{
    ICCardHeaderModel* model = [[ICCardHeaderModel alloc] init];
    model.titleStr = @"当前绑定卡号";
    [self.headDatasourceArr addObject:model];
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 40) style:UITableViewStylePlain];
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
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasourceArr.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"ICCard";
    ICManagementTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[ICManagementTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    ICManagementModel* model = self.datasourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ICManagementModel *model = nil;
    if (indexPath.row < self.datasourceArr.count) {
        model = [self.datasourceArr objectAtIndex:indexPath.row];
    }
    return [ICManagementTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        ICManagementTableViewCell *cell = (ICManagementTableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ICManagementHeaderView *headView = [ICManagementHeaderView headViewWithTableView:tableView];
    ICCardHeaderModel* model = self.headDatasourceArr[section];
    [headView makeHeader:model];
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (void)createMtICCard{
    
    NSString* requestAddress = MYCARDURL;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD hide];
                  NSString *dataStr = [responseObject objectForKey:@"data"];
                  NSDictionary *dic  = [MyController dictionaryWithJsonString:dataStr];
                  if (![MyController isBlankString:dic[@"cardNo"]]) {
                      ICManagementModel* s0Model = [[ICManagementModel alloc] init];
                      s0Model.icCardNum = dic[@"cardNo"];
                      [self.datasourceArr addObject:s0Model];
                      
                      [makeSureBtn setTitle:@"重新绑定" forState:UIControlStateNormal];
                  }else{
                      ICManagementModel* s0Model = [[ICManagementModel alloc] init];
                      s0Model.icCardNum = @"您尚未绑定IC卡";
                      [self.datasourceArr addObject:s0Model];
                      
                      [makeSureBtn setTitle:@"开始绑定" forState:UIControlStateNormal];
                  }
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
- (void)createBindingICCard{
    UITextField* tf = (UITextField*)[self.popView viewWithTag:10086];
    
    NSString* requestAddress = BINDINGICCARD;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid,
                                              @"code":tf.text
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  NSString *dataStr = [responseObject objectForKey:@"data"];
                  [self.datasourceArr removeAllObjects];
                  ICManagementModel* s0Model = [[ICManagementModel alloc] init];
                  s0Model.icCardNum = tf.text;
                  [self.datasourceArr addObject:s0Model];
                  [HUD success:dataStr];
                  
                  [makeSureBtn setTitle:@"重新绑定" forState:UIControlStateNormal];
                  
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
