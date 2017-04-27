//
//  ConfirmAppointmentRecyclingViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/7/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "ConfirmAppointmentRecyclingViewController.h"

#import "RecyclingCarModel.h"

#import "ConfirmAppointmentRecyclingS0Model.h"

#import "RecyclingCarTableViewCell.h"

#import "ConfirmAppointmentRecyclingS0TableViewCell.h"

#import "MyAddressViewController.h"

#import "MyAddressModel.h"
@interface ConfirmAppointmentRecyclingViewController ()<UITableViewDataSource,UITableViewDelegate,MyAddressViewControllerDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr0;
@property(nonatomic,copy)NSString* info;
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,copy)NSString* idStr;

@end

@implementation ConfirmAppointmentRecyclingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"确认呼叫";
    
    self.userid = [MyController getUserid];
    
    self.datasourceArr0 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.datasourceArr1.count; i++) {
        RecyclingCarModel* model = self.datasourceArr1[i];
        model.isSelected = NO;
        model.isFromMakesure = YES;
    }
    
    [self createTableView];
    
    [self makeBottomUI];
    
    [self createGetMyAddress];
}
- (void)sendBackAddress:(MyAddressModel *)addressModel{
    [self.datasourceArr0 removeAllObjects];
    ConfirmAppointmentRecyclingS0Model* model = [[ConfirmAppointmentRecyclingS0Model alloc] init];
    model.contectStr = addressModel.nameStr;
    model.telStr = addressModel.telStr;
    model.addressStr = addressModel.titleStr;
    model.isHaveAddress = YES;
    [self.datasourceArr0 addObject:model];
    [_tableView reloadData];
    self.info = [NSString stringWithFormat:@"{\"dlzh\":\"%@\",\"shdz\":\"%@\",\"lxfs\":\"%@\"}",model.contectStr,model.addressStr,[model.telStr substringFromIndex:3]];
}

- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    [self.view addSubview:bottomView];
    
    UIButton* makeSureBtn = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:@"确认预约"];
    [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:makeSureBtn];
    
    UIView* lineV = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 0.5)];
    lineV.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    [bottomView addSubview:lineV];
}
- (void)makeSureBtnClick{
    ConfirmAppointmentRecyclingS0Model* model = [self.datasourceArr0 lastObject];
    if (model.isHaveAddress) {
        self.idStr = @"";
        for (int i = 0; i < self.datasourceArr1.count; i++) {
            RecyclingCarModel* model = self.datasourceArr1[i];
            self.idStr = [self.idStr stringByAppendingString:[NSString stringWithFormat:@"%@,",model.idStr]];
        }
        self.idStr = [self.idStr substringToIndex:self.idStr.length - 1];
        
        [self createDeleteCarRequest];
    }else{
        [HUD warning:@"请选取收货地址"];
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
    if (0 == section) {
        return self.datasourceArr0.count;
    }
    return self.datasourceArr1.count;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        MyAddressViewController* vc = [[MyAddressViewController alloc] init];
        vc.MyAddressViewControllerDelegate = self;
        vc.isNeedBack = YES;
        vc.isDingdian = NO;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        NSString *cellIdentifier = @"confir0";
        ConfirmAppointmentRecyclingS0TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[ConfirmAppointmentRecyclingS0TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        ConfirmAppointmentRecyclingS0Model* model = self.datasourceArr0[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }
    NSString *cellIdentifier = @"confir1";
    RecyclingCarTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[RecyclingCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    RecyclingCarModel* model = self.datasourceArr1[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        ConfirmAppointmentRecyclingS0Model *model = nil;
        if (indexPath.row < self.datasourceArr0.count) {
            model = [self.datasourceArr0 objectAtIndex:indexPath.row];
        }
        return [ConfirmAppointmentRecyclingS0TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            ConfirmAppointmentRecyclingS0TableViewCell *cell = (ConfirmAppointmentRecyclingS0TableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }
    RecyclingCarModel *model = nil;
    if (indexPath.row < self.datasourceArr1.count) {
        model = [self.datasourceArr1 objectAtIndex:indexPath.row];
    }
    return [RecyclingCarTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        RecyclingCarTableViewCell *cell = (RecyclingCarTableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}
- (void)createDeleteCarRequest{
    NSString* requestUrl = CARTSUBMIT;
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestUrl parameters:@{
                                          @"userid":self.userid,
                                          @"id ":self.idStr,
                                          @"info":self.info
                                          }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([responseObject[@"result"] intValue]) {
                  [HUD success:responseObject[@"data"]];
                  [self.ConfirmAppointmentRecyclingViewControllerDelegate sendBackYuyueIdStr:self.idStr];
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

- (void)createGetMyAddress{
    [HUD loading];
    NSString* requestAddress = MYADDRESS;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid,
                                              @"flg":@"1"
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD hide];
                  NSArray* temA = [[NSArray alloc] init];
                  temA = [MyController arraryWithJsonString:responseObject[@"data"]];
                  [self.datasourceArr0 removeAllObjects];
                  if (temA.count) {
                      for (NSDictionary* dic in temA) {
                          ConfirmAppointmentRecyclingS0Model* model = [[ConfirmAppointmentRecyclingS0Model alloc] init];
                          model.contectStr = dic[@"addressee"];
                          model.telStr = [NSString stringWithFormat:@"手机：%@",dic[@"tel"]];
                          model.addressStr = [NSString stringWithFormat:@"%@ %@ %@ %@",dic[@"province"],dic[@"city"],dic[@"area"],dic[@"address"]];
                          model.isHaveAddress = YES;
                          [self.datasourceArr0 addObject:model];
                          [_tableView reloadData];
                          self.info = [NSString stringWithFormat:@"{\"dlzh\":\"%@\",\"shdz\":\"%@\",\"lxfs\":\"%@\"}",model.contectStr,model.addressStr,dic[@"mobile"]];
                      }
                  }else{
                      ConfirmAppointmentRecyclingS0Model* model = [[ConfirmAppointmentRecyclingS0Model alloc] init];
                      model.contectStr = @"皮卡丘";
                      model.telStr = @"188888888888";
                      model.addressStr = @"山东青岛黄岛创业大厦";
                      model.isHaveAddress = NO;
                      [self.datasourceArr0 addObject:model];
                  }
              }else{
                  [HUD hide];
                  ConfirmAppointmentRecyclingS0Model* model = [[ConfirmAppointmentRecyclingS0Model alloc] init];
                  model.contectStr = @"皮卡丘";
                  model.telStr = @"188888888888";
                  model.addressStr = @"山东青岛黄岛创业大厦";
                  model.isHaveAddress = NO;
                  [self.datasourceArr0 addObject:model];
              }
              
              [_tableView reloadData];
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD hide];
              ConfirmAppointmentRecyclingS0Model* model = [[ConfirmAppointmentRecyclingS0Model alloc] init];
              model.contectStr = @"皮卡丘";
              model.telStr = @"188888888888";
              model.addressStr = @"山东青岛黄岛创业大厦";
              model.isHaveAddress = NO;
              [self.datasourceArr0 addObject:model];
              [_tableView reloadData];
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
