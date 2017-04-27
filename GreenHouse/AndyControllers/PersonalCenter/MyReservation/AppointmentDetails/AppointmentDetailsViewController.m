//
//  AppointmentDetailsViewController.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/6/11.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AppointmentDetailsViewController.h"

#import "MyAddressModel.h"

#import "MyAddressTableViewCell.h"

#import "AppointmentExchange0Model.h"

#import "AppointmentExchange2Model.h"

#import "AppointmentDetailsModel.h"

#import "AppointmentExchangeHeaderModel.h"

#import "AppointmentExchangeHeaderView.h"

#import "AppointmentExchange00TableViewCell.h"

#import "AppointmentExchange2TableViewCell.h"

#import "AppointmentDetailsTableViewCell.h"

#import "ResubmitViewController.h"

#import "ZCZBarViewController.h"
@interface AppointmentDetailsViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,ResubmitViewControllerDelegate>{
    UITableView* _tableView;
    FDAlertView *alert;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr0;
@property(nonatomic,retain)NSMutableArray* datasourceArr1;
@property(nonatomic,retain)NSMutableArray* datasourceArr2;
@property(nonatomic,retain)NSMutableArray* datasourceArr3;
@property(nonatomic,retain)NSMutableArray* datasourceHeadArr;

@property(nonatomic,assign)BOOL isDingdian;
//请求需要的参数
@property(nonatomic,copy)NSString* userid;

@property(nonatomic,retain)UIView* popView;
@end

@implementation AppointmentDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.datasourceArr0 = [[NSMutableArray alloc] init];
    self.datasourceArr1 = [[NSMutableArray alloc] init];
    self.datasourceArr2 = [[NSMutableArray alloc] init];
    self.datasourceArr3 = [[NSMutableArray alloc] init];
    self.datasourceHeadArr = [[NSMutableArray alloc] init];
    
    self.userid = [MyController getUserid];

    [self makeData];
    
    [self createTableView];
    
    [self createGetYuyueDetail];
}
- (void)viewWillAppear:(BOOL)animated{
    
}

- (void)sendBackIsSendSuccess:(BOOL)isSuccess{
    if (isSuccess) {
        [self createGetYuyueDetail];
    }
}
#pragma mark - 底部按钮UI
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    [self.view addSubview:bottomView];
    
    if (0 == self.typeInt) {
        UIButton* makeSureBtn = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth] - 60, 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:@"编辑"];
        [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
        makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [bottomView addSubview:makeSureBtn];
        
        UIButton* makeSureBtn1 = [MyController createButtonWithFrame:CGRectMake(CGRectGetMaxX(makeSureBtn.frame), 0, 60, 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick1) Title:@"删除"];
        [makeSureBtn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [makeSureBtn1 setBackgroundColor:[UIColor whiteColor]];
        makeSureBtn1.titleLabel.font = [UIFont systemFontOfSize:16];
        [bottomView addSubview:makeSureBtn1];
        
        UIView* lineV = [MyController viewWithFrame:CGRectMake(makeSureBtn1.frame.origin.x, 0, 60, 0.5)];
        lineV.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
        [bottomView addSubview:lineV];
    }else if (2 == self.typeInt){
        UIButton* makeSureBtn1 = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth]/2, 40) ImageName:nil Target:self Action:@selector(duanxinBtnClick) Title:@"短信兑换"];
        [makeSureBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [makeSureBtn1 setBackgroundColor:[UIColor lightGrayColor]];
        makeSureBtn1.titleLabel.font = [UIFont systemFontOfSize:16];
        [bottomView addSubview:makeSureBtn1];
        
        UIButton* makeSureBtn = [MyController createButtonWithFrame:CGRectMake([MyController getScreenWidth]/2, 0, [MyController getScreenWidth]/2, 40) ImageName:nil Target:self Action:@selector(saomaBtnClick) Title:@"扫码兑换"];
        [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
        makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [bottomView addSubview:makeSureBtn];
        
        if (self.isDingdian) {
            makeSureBtn.frame = CGRectMake(0, 0, [MyController getScreenWidth], 40);
        }

    }else if (3 == self.typeInt){
        
    }
    
}
#pragma mark - 短信兑换按钮响应
- (void)duanxinBtnClick{
    [self BtnClick];
}

#pragma mark - 创建pop界面
- (void)BtnClick{
    self.popView = [MyController createImageViewWithFrame:CGRectMake(20, [MyController getScreenHeight] / 2 - 100, [MyController getScreenWidth] - 40, 200) ImageName:nil];
    self.popView.backgroundColor = [MyController colorWithHexString:@"6b7479"];
    //    self.popView.alpha = 0.8;
    
    UIView* bv = [MyController createImageViewWithFrame:CGRectMake(0, 0, self.popView.frame.size.width, 200) ImageName:nil];
    bv.backgroundColor = [UIColor whiteColor];
    [self.popView addSubview:bv];
    
    UILabel* titLable = [MyController createLabelWithFrame:CGRectMake(0, 0, self.popView.frame.size.width, 50) Font:16 Text:@"短信兑换"];
    titLable.textAlignment = NSTextAlignmentCenter;
    [self.popView addSubview:titLable];
    
    UILabel* titLable1 = [MyController createLabelWithFrame:CGRectMake(20, CGRectGetMaxY(titLable.frame), self.popView.frame.size.width - 40, 50) Font:14 Text:@"请输入短信验证码"];
    [self.popView addSubview:titLable1];
    
    UITextField* tf = [MyController createTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(titLable1.frame), self.popView.frame.size.width - 40, 40) placeholder:@"请输入短信验证码" passWord:NO leftImageView:nil rightImageView:nil Font:14];
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
- (void)sureBtnClick{
    UITextField* tf = (UITextField*)[self.popView viewWithTag:10086];
    if ([MyController isBlankString:tf.text]) {
        [HUD error:@"请输入短信验证码"];
        return;
    }else{
        [alert hide];
        [HUD loading];
        [self createDuanxinDuihuan:tf.text AndycodeStr1:self.presentId];
    }
}
- (void)cancleBtnClick{
    [alert hide];
}
- (void)saomaBtnClick{
    ZCZBarViewController*vc=[[ZCZBarViewController alloc]initWithIsQRCode:NO Block:^(NSString *result, BOOL isFinish) {
        if (isFinish) {
            if (self.isDingdian) {
                [self createSaomaDuihuan:self.presentId AndycodeStr1:result];
            }else{
                [self createSaomaDuihuan:result AndycodeStr1:self.goodsId];
            }
        }
    }];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)makeSureBtnClick{
    ResubmitViewController* vc = [[ResubmitViewController alloc] init];
    vc.presentId = self.presentId;
    vc.remark = self.remark;
    vc.ResubmitViewControllerDelegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)makeSureBtnClick1{
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否要删除该预约？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [al show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (1 == buttonIndex) {
        [HUD loading];
        [self createDeleteMyYuyue:self.presentId];
    }
}
- (void)makeData{
    NSArray* titA = [[NSArray alloc] initWithObjects:self.remark,@"送货地址",@"简单备注", nil];
    for (int i = 0; i < titA.count; i++) {
        AppointmentExchangeHeaderModel* modelH = [[AppointmentExchangeHeaderModel alloc] init];
        modelH.titleStr = titA[i];
        [self.datasourceHeadArr addObject:modelH];
    }
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    if (3 == self.typeInt) {
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
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return self.datasourceArr0.count;
    }else if (1 == section){
        
        return self.datasourceArr1.count;
    }else if (2 == section){
        
        return self.datasourceArr2.count;
    }
    
    return self.datasourceArr3.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        NSString *cellIdentifier = @"AppointmentExchange00";
        AppointmentExchange00TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[AppointmentExchange00TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        AppointmentExchange0Model* model = self.datasourceArr0[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }else if (1 == indexPath.section){
        NSString *cellIdentifier = @"AppointmentExchange01";
        MyAddressTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[MyAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        MyAddressModel* model = self.datasourceArr1[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }else if (2 == indexPath.section){
        NSString *cellIdentifier = @"AppointmentExchange02";
        AppointmentExchange2TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[AppointmentExchange2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        AppointmentExchange2Model* model = self.datasourceArr2[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }
    NSString *cellIdentifier = @"AppointmentExchange03";
    AppointmentDetailsTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[AppointmentDetailsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    AppointmentDetailsModel* model = self.datasourceArr3[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        AppointmentExchange0Model *model = nil;
        if (indexPath.row < self.datasourceArr0.count) {
            model = [self.datasourceArr0 objectAtIndex:indexPath.row];
        }
        return [AppointmentExchange00TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            AppointmentExchange00TableViewCell *cell = (AppointmentExchange00TableViewCell *)sourceCell;
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
    }else if (2 == indexPath.section){
        AppointmentExchange2Model *model = nil;
        if (indexPath.row < self.datasourceArr2.count) {
            model = [self.datasourceArr2 objectAtIndex:indexPath.row];
        }
        return [AppointmentExchange2TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            AppointmentExchange2TableViewCell *cell = (AppointmentExchange2TableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }
    AppointmentDetailsModel *model = nil;
    if (indexPath.row < self.datasourceArr3.count) {
        model = [self.datasourceArr3 objectAtIndex:indexPath.row];
    }
    return [AppointmentDetailsTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        AppointmentDetailsTableViewCell *cell = (AppointmentDetailsTableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (3 == section) {
        return nil;
    }
    AppointmentExchangeHeaderView *headView = [AppointmentExchangeHeaderView headViewWithTableView:tableView];
    AppointmentExchangeHeaderModel* model = self.datasourceHeadArr[section];
    [headView makeHeader:model];
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (3 == section) {
        return 0;
    }
    return 40;
}
- (void)createGetYuyueDetail{
    [HUD loading];
    
    [self.datasourceArr0 removeAllObjects];
    [self.datasourceArr1 removeAllObjects];
    [self.datasourceArr2 removeAllObjects];
    [self.datasourceArr3 removeAllObjects];
    
    self.datasourceArr1 = [[NSMutableArray alloc] init];
    
    NSString* requestAddress = BESPOKEDETAILURL;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid,
                                              @"id":self.presentId
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD hide];
                  NSDictionary* souceDic = [MyController dictionaryWithJsonString:responseObject[@"data"]];
                  AppointmentExchange0Model* s0Model = [[AppointmentExchange0Model alloc] init];
                  s0Model.jifenStr = [NSString stringWithFormat:@"所需积分：%@",souceDic[@"point"]];//@"所需积分：1";
                  s0Model.guigeStr = [NSString stringWithFormat:@"礼品规格：%@",[MyController returnStr:souceDic[@"spec"]]];//@"礼品规格：400g";
                  s0Model.duihuanNumStr = @"兑换数量  1";
                  if ([@"定点兑换" isEqualToString:souceDic[@"givetype"]]) {
                      s0Model.isDingdianDuihuan = YES;
                  }else{
                      s0Model.isDingdianDuihuan = NO;
                  }
                  [self.datasourceArr0 addObject:s0Model];

                  
                  NSDictionary* addDic = souceDic[@"address"];
                  MyAddressModel* model0 = [[MyAddressModel alloc] init];
                  if ([@"定点兑换" isEqualToString:souceDic[@"givetype"]]) {
                      model0.titleStr = [NSString stringWithFormat:@"地址：%@",addDic[@"name"]];//@"手机：1212312312";
                      model0.telStr = [NSString stringWithFormat:@"说明：%@",addDic[@"remark"]];//addDic[@"addressee"];
                      model0.myAddressidId = addDic[@"addDic"];
                      self.isDingdian = YES;
                  }else{
                      model0.titleStr = [NSString stringWithFormat:@"%@ %@ %@ %@",addDic[@"province"],addDic[@"city"],addDic[@"area"],addDic[@"address"]];
                      model0.telStr = [NSString stringWithFormat:@"手机：%@",addDic[@"tel"]];//@"手机：1212312312";
                      model0.nameStr = addDic[@"addressee"];
                      model0.myAddressidId = addDic[@"addressid"];
                      self.isDingdian = NO;
                  }
                  model0.myAddressidId = addDic[@"addressee"];
                  
                  [self.datasourceArr1 addObject:model0];
                  
                  AppointmentExchange2Model* s2M = [[AppointmentExchange2Model alloc] init];
                  s2M.beizhuStr = souceDic[@"note"];
                  s2M.isNoEditable = YES;
                  [self.datasourceArr2 addObject:s2M];
                  
                  AppointmentDetailsModel* s3M = [[AppointmentDetailsModel alloc] init];
                  s3M.sendTime = souceDic[@"addtime"];
                  if (2 == self.typeInt) {
                      s3M.statusStr = [NSString stringWithFormat:@"兑换状态：待兑换"];
                      s3M.compTime = @"";
                  }else if (3 == self.typeInt){
                      s3M.statusStr = [NSString stringWithFormat:@"兑换状态：已完成"];
                      s3M.compTime = [NSString stringWithFormat:@"完成时间：%@",souceDic[@"completetime"]];
                  }else{
                      s3M.statusStr = @"";
                      s3M.compTime = @"";
                  }
                  [self.datasourceArr3 addObject:s3M];
                  
                  [_tableView reloadData];
                  
                  [self makeBottomUI];
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"请检查网络"];
          }];
}

- (void)createDeleteMyYuyue:(NSString*)idStr{
    NSString* requestAddress = BESPOKEDELETEURL;
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
                  [self.AppointmentDetailsViewControllerDelegate sendBackDeleteIndex:self.deleteIndex];
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

- (void)createSaomaDuihuan:(NSString*)codeStr AndycodeStr1:(NSString*)AndycodeStr1{
    [HUD loading];
    NSString* requestAddress = CASHINGSURE;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid,
                                              @"id":AndycodeStr1,
                                              @"code":codeStr
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD success:responseObject[@"data"]];
                  [self.AppointmentDetailsViewControllerDelegate sendBackNeedRefresh:YES];
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
- (void)createDuanxinDuihuan:(NSString*)codeStr AndycodeStr1:(NSString*)AndycodeStr1{
    [HUD loading];
    NSString* requestAddress = MESSAGESURE;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid,
                                              @"id":AndycodeStr1,
                                              @"code":codeStr
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD success:responseObject[@"data"]];
                  [self.AppointmentDetailsViewControllerDelegate sendBackNeedRefresh:YES];
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
