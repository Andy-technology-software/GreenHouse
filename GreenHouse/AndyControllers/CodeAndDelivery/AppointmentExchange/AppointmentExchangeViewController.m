//
//  AppointmentExchangeViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/4/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AppointmentExchangeViewController.h"

#import "MyAddressModel.h"

#import "MyAddressTableViewCell.h"

#import "AppointmentExchange0Model.h"

#import "AppointmentExchange2Model.h"

#import "AppointmentExchangeHeaderModel.h"

#import "AppointmentExchangeHeaderView.h"

#import "AppointmentExchange0TableViewCell.h"

#import "AppointmentExchange2TableViewCell.h"

#import "MyAddressViewController.h"
@interface AppointmentExchangeViewController ()<UITableViewDataSource,UITableViewDelegate,AppointmentExchange0TableViewCellDelegate,AppointmentExchange2TableViewCellDelegate,MyAddressViewControllerDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr0;
@property(nonatomic,retain)NSMutableArray* datasourceArr1;
@property(nonatomic,retain)NSMutableArray* datasourceArr2;
@property(nonatomic,retain)NSMutableArray* datasourceHeadArr;
//请求需要的参数
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,copy)NSString* info;
//兑换方式
@property(nonatomic,assign)NSInteger givetype;

@end

@implementation AppointmentExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"预约兑换";
    
    self.datasourceArr0 = [[NSMutableArray alloc] init];
    self.datasourceArr1 = [[NSMutableArray alloc] init];
    self.datasourceArr2 = [[NSMutableArray alloc] init];
    self.datasourceHeadArr = [[NSMutableArray alloc] init];

    self.givetype = 1;
    
    self.userid = [MyController getUserid];
    self.info = @"";
    [self makeData];
    
    [self createTableView];
    
    [self makeBottomUI];
    
    [self createGetMyAddress];
}
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)sendBackAddress:(MyAddressModel *)addressModel{
    [self.datasourceArr1 removeAllObjects];
    [self.datasourceArr1 addObject:addressModel];
    //一个section刷新
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)dingdian{
    self.givetype = 0;
    AppointmentExchange0Model* model = [self.datasourceArr0 firstObject];
    model.isDingdianDuihuan = !model.isDingdianDuihuan;
    if (model.isDingdianDuihuan) {
        [self.datasourceArr1 removeAllObjects];
        MyAddressModel* model = [[MyAddressModel alloc] init];
        model.titleStr = @"请选择定点兑换地址~";
        model.telStr = @"";
        model.nameStr = @"";
        [self.datasourceArr1 addObject:model];
        [_tableView reloadData];
    }
}
- (void)songhuo{
    self.givetype = 1;
    AppointmentExchange0Model* model = [self.datasourceArr0 firstObject];
    model.isDingdianDuihuan = !model.isDingdianDuihuan;
    if (!model.isDingdianDuihuan) {
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        [self createGetMyAddress];
    }
}
- (void)sendBackBeizhu:(NSString *)beizhu{
    AppointmentExchange2Model* model = [self.datasourceArr2 firstObject];
    model.beizhuStr = beizhu;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    [self.view addSubview:bottomView];
    
    UIButton* makeSureBtn = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:@"立即预约"];
    [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:makeSureBtn];
}
- (void)makeSureBtnClick{
    AppointmentExchange0Model* s0Model = [self.datasourceArr0 lastObject];
    AppointmentExchange2Model* beizhuModel = [self.datasourceArr2 firstObject];
    if ([MyController isBlankString:self.thumb]) {
        self.thumb = @"";
    }
    MyAddressModel* addmodel = [self.datasourceArr1 lastObject];
    if ([MyController isBlankString:addmodel.myAddressidId]) {
        if (self.givetype) {
            [HUD error:@"请选取送货上门地址"];
        }else{
            [HUD error:@"请选择定点兑换地址"];
        }
        return;
    }
    if (!s0Model.isDingdianDuihuan) {
        self.info = [NSString stringWithFormat:@"{\"uid\":%d,\"addressid\":%d,\"remark\":\"%@\",\"note\":\"%@\",\"point\":%d,\"thumb\":\"%@\",\"gilfbh\":\"%@\",\"givetype\":%ld,\"qty\":1,\"goodsid\":\"%@\"}",[self.userid intValue],[addmodel.myAddressidId intValue],self.presentName,beizhuModel.beizhuStr,[self.needJifen intValue],self.thumb,s0Model.guigeStr,self.givetype,self.goodsid];
        [HUD loading];
        [self createpresenBookRequest];
    }else{
        self.info = [NSString stringWithFormat:@"{\"uid\":%d,\"addressid\":%d,\"remark\":\"%@\",\"note\":\"%@\",\"point\":%d,\"thumb\":\"%@\",\"gilfbh\":\"%@\",\"givetype\":%ld,\"qty\":1,\"goodsid\":\"%@\"}",[self.userid intValue],[addmodel.myAddressidId intValue],self.presentName,beizhuModel.beizhuStr,[self.needJifen intValue],self.thumb,s0Model.guigeStr,self.givetype,self.goodsid];
        [HUD loading];
        [self createpresenBookRequest];
    }
}
- (void)makeData{
    [self.datasourceArr0 addObject:self.s0Model];
    
    AppointmentExchange2Model* model2 = [[AppointmentExchange2Model alloc] init];
    model2.beizhuStr = @"";
    [self.datasourceArr2 addObject:model2];
    
    NSArray* titA = [[NSArray alloc] initWithObjects:[MyController returnStr:self.presentName],@"送货地址",@"简单备注", nil];
    for (int i = 0; i < titA.count; i++) {
        AppointmentExchangeHeaderModel* modelH = [[AppointmentExchangeHeaderModel alloc] init];
        modelH.titleStr = titA[i];
        [self.datasourceHeadArr addObject:modelH];
    }
    
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
    if (0 == section) {
        return self.datasourceArr0.count;
    }else if (1 == section){
        return self.datasourceArr1.count;
    }
    return self.datasourceArr2.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (1 == indexPath.section) {
        MyAddressViewController* vc = [[MyAddressViewController alloc] init];
        vc.MyAddressViewControllerDelegate = self;
        vc.isNeedBack = YES;
        if (0 == self.givetype) {
            vc.isDingdian = YES;
        }
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        NSString *cellIdentifier = @"AppointmentExchange0";
        AppointmentExchange0TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[AppointmentExchange0TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.AppointmentExchange0TableViewCellDelegate = self;
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        AppointmentExchange0Model* model = self.datasourceArr0[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }else if (1 == indexPath.section){
        NSString *cellIdentifier = @"AppointmentExchange1";
        MyAddressTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[MyAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        MyAddressModel* model = self.datasourceArr1[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }
    NSString *cellIdentifier = @"AppointmentExchange2";
    AppointmentExchange2TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[AppointmentExchange2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.AppointmentExchange2TableViewCellDelegate = self;
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    AppointmentExchange2Model* model = self.datasourceArr2[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        AppointmentExchange0Model *model = nil;
        if (indexPath.row < self.datasourceArr0.count) {
            model = [self.datasourceArr0 objectAtIndex:indexPath.row];
        }
        return [AppointmentExchange0TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            AppointmentExchange0TableViewCell *cell = (AppointmentExchange0TableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }else if (1 == indexPath.section){
        MyAddressModel *model = nil;
        if (indexPath.row < self.datasourceArr1.count) {
            model = [self.datasourceArr1 objectAtIndex:indexPath.row];
        }
        return [MyAddressTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            MyAddressTableViewCell *cell = (MyAddressTableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }
    AppointmentExchange2Model *model = nil;
    if (indexPath.row < self.datasourceArr2.count) {
        model = [self.datasourceArr2 objectAtIndex:indexPath.row];
    }
    return [AppointmentExchange2TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        AppointmentExchange2TableViewCell *cell = (AppointmentExchange2TableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    AppointmentExchangeHeaderView *headView = [AppointmentExchangeHeaderView headViewWithTableView:tableView];
    AppointmentExchangeHeaderModel* model = self.datasourceHeadArr[section];
    [headView makeHeader:model];
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (void)createpresenBookRequest{
    NSString* requestAddress = PRESENTBOOKURL;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid,
                                              @"id":self.presentId,
                                              @"info":self.info
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
- (void)createGetMyAddress{
    [HUD loading];
    
    self.datasourceArr1 = [[NSMutableArray alloc] init];
    
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
                  if (temA.count) {
                      for (NSDictionary* dic in temA) {
                          MyAddressModel* model = [[MyAddressModel alloc] init];
                          model.titleStr = [NSString stringWithFormat:@"%@ %@ %@ %@",dic[@"province"],dic[@"city"],dic[@"area"],dic[@"address"]];
                          model.telStr = [NSString stringWithFormat:@"手机：%@",dic[@"tel"]];//@"手机：1212312312";
                          model.nameStr = dic[@"addressee"];
                          model.myAddressidId = dic[@"addressid"];
                          
                          [self.datasourceArr1 addObject:model];
                      }
                  }else{
                      MyAddressModel* model = [[MyAddressModel alloc] init];
                      model.titleStr = @"您没有设置默认地址，请选择收货地址~";
                      model.telStr = @"";
                      model.nameStr = @"";
                      [self.datasourceArr1 addObject:model];
                  }
              }else{
                  MyAddressModel* model = [[MyAddressModel alloc] init];
                  model.titleStr = @"您没有设置默认地址，请选择收货地址~";
                  model.telStr = @"";
                  model.nameStr = @"";
                  [self.datasourceArr1 addObject:model];
              }
              
              NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
              [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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
