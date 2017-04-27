//
//  PersonalCenterViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "PersonalCenterViewController.h"

#import "PersonalCenterModel.h"

#import "PersonalCenter1Model.h"

#import "PersonalCenterTableViewCell.h"

#import "PersonalCenter1TableViewCell.h"

#import "MyProfile1Model.h"

#import "MyProfileView1TableViewCell.h"

#import "MyPointsViewController.h"

#import "MyDeliveryViewController.h"

#import "MyReservationViewController.h"

#import "MyChangeViewController.h"

#import "MyCollectionViewController.h"

#import "MyICCardViewController.h"

#import "MyProfileViewController.h"

#import "AppDelegate.h"

#import "SeetingViewController.h"

#import "MyRecoveryViewController.h"

#import "IntegralDonateViewController.h"
@interface PersonalCenterViewController ()<UITableViewDataSource,UITableViewDelegate,PersonalCenterTableViewCellDelegate>{
    UITableView* _tableView;
    FDAlertView *alert;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr;
@property(nonatomic,retain)NSMutableArray* datasourceArr1;
@property(nonatomic,retain)NSMutableArray* datasourceArr2;
@property(nonatomic,assign)BOOL isNotFirst;
@property(nonatomic,retain)UIView* popView;
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,copy)NSString* yaoqingmaStr;
@end
@implementation PersonalCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"个人中心";
    
    self.userid = [MyController getUserid];
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    self.datasourceArr1 = [[NSMutableArray alloc] init];
    self.datasourceArr2 = [[NSMutableArray alloc] init];
    
    [self makeData];
    
    [self createTableView];
    
    [self makeBottomUI];
    
    [self makeRightNav];
}
- (void)viewWillAppear:(BOOL)animated{
    if (self.isNotFirst) {
        [[[SDWebImageManager sharedManager] imageCache] clearDisk];
        [[[SDWebImageManager sharedManager] imageCache] clearMemory];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        [self.datasourceArr removeAllObjects];
        LoginDataBaseModel* model = [[[DBManager shareManager] getAllLoginModel] firstObject];
        PersonalCenterModel* s0Model = [[PersonalCenterModel alloc] init];
        s0Model.headImageStr = model.userHeadImage;
        s0Model.zhanghaoStr = model.nickName;
        [self.datasourceArr addObject:s0Model];
        [_tableView reloadData];
    }
    self.isNotFirst = YES;
}
- (void)makeRightNav{
    UIButton*rightButton1 = [[UIButton alloc]initWithFrame:CGRectMake(160,0,30,30)];
    [rightButton1 setImage:[UIImage imageNamed:@"icn_setting"]forState:UIControlStateNormal];
    [rightButton1 setImage:[UIImage imageNamed:@"icn_setting"] forState:UIControlStateHighlighted];
    //    rightButton1.backgroundColor = [UIColor redColor];
    [rightButton1 addTarget:self action:@selector(BtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:rightButton1];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightItem1, nil];
}

- (void)BtnClick{
    SeetingViewController* vc = [[SeetingViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)personInfo{
    MyProfileViewController* vc = [[MyProfileViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES]; 
}
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    [self.view addSubview:bottomView];
    
    UIButton* makeSureBtn = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:@"退出登录"];
    [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:makeSureBtn];
}
- (void)makeSureBtnClick{
    [[DBManager shareManager] deleteLoginData];
    [(AppDelegate *)[UIApplication sharedApplication].delegate logOut];
}
- (void)makeData{
    [self.datasourceArr removeAllObjects];
    [self.datasourceArr1 removeAllObjects];
    
    LoginDataBaseModel* loginModel = [[[DBManager shareManager] getAllLoginModel] firstObject];
    PersonalCenterModel* s0Model = [[PersonalCenterModel alloc] init];
    s0Model.headImageStr = loginModel.userHeadImage;
    
    if (![MyController isBlankString:loginModel.nickName]) {
        s0Model.zhanghaoStr = loginModel.nickName;
    }else{
        s0Model.zhanghaoStr = loginModel.phoneNum;
    }
    [self.datasourceArr addObject:s0Model];
    
    NSArray* temA = [[NSArray alloc] initWithObjects:@"我的积分",@"积分捐赠",@"我的投递",@"我的回收",@"我的预约",@"我的兑换",@"我的收藏",@"我的IC卡", nil];
    for (int i = 0; i < temA.count; i++) {
        PersonalCenter1Model* model = [[PersonalCenter1Model alloc] init];
        model.titleStr = temA[i];
        [self.datasourceArr1 addObject:model];
    }
    
    
    MyProfile1Model* myModel = [[MyProfile1Model alloc] init];
    myModel.titleStr = @"我的邀请码";
    myModel.titleStr1 = loginModel.myInvateCode;
    [self.datasourceArr2 addObject:myModel];
    
    MyProfile1Model* myModel1 = [[MyProfile1Model alloc] init];
    myModel1.titleStr = @"我的推荐人";
    myModel1.titleStr1 = loginModel.recommendPreson;
    [self.datasourceArr2 addObject:myModel1];
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
        return self.datasourceArr.count;
    }else if (2 == section){
        return self.datasourceArr2.count;
    }
    return self.datasourceArr1.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (1 == indexPath.section) {
        if (0 == indexPath.row) {
            MyPointsViewController* vc = [[MyPointsViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (1 == indexPath.row){
            IntegralDonateViewController* vc = [[IntegralDonateViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (2 == indexPath.row){
            MyDeliveryViewController* vc = [[MyDeliveryViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (3 == indexPath.row){
            MyRecoveryViewController* vc = [[MyRecoveryViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (4 == indexPath.row){
            MyReservationViewController* vc = [[MyReservationViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (5 == indexPath.row){
            MyChangeViewController* vc = [[MyChangeViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (6 == indexPath.row){
            MyCollectionViewController* vc = [[MyCollectionViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (7 == indexPath.row){
            MyICCardViewController* vc = [[MyICCardViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (2 == indexPath.section){
        MyProfile1Model* model = [self.datasourceArr2 lastObject];
        if ([MyController isBlankString:model.titleStr1]) {
            if (1 == indexPath.row) {
                [self makePopView];
            }
        }
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        NSString *cellIdentifier = @"persion0";
        PersonalCenterTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[PersonalCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.PersonalCenterTableViewCellDelegate = self;
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        PersonalCenterModel* model = self.datasourceArr[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }else if (1 == indexPath.section){
        NSString *cellIdentifier = @"persion1";
        PersonalCenter1TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[PersonalCenter1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        PersonalCenter1Model* model = self.datasourceArr1[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }
    NSString *cellIdentifier = @"persion2";
    MyProfileView1TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[MyProfileView1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    MyProfile1Model* model = self.datasourceArr2[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        PersonalCenterModel *model = nil;
        if (indexPath.row < self.datasourceArr.count) {
            model = [self.datasourceArr objectAtIndex:indexPath.row];
        }
        return [PersonalCenterTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            PersonalCenterTableViewCell *cell = (PersonalCenterTableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }else if (1 == indexPath.section){
        PersonalCenter1Model *model = nil;
        if (indexPath.row < self.datasourceArr1.count) {
            model = [self.datasourceArr1 objectAtIndex:indexPath.row];
        }
        return [PersonalCenter1TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            PersonalCenter1TableViewCell *cell = (PersonalCenter1TableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }
    MyProfile1Model *model = nil;
    if (indexPath.row < self.datasourceArr2.count) {
        model = [self.datasourceArr2 objectAtIndex:indexPath.row];
    }
    return [MyProfileView1TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        MyProfileView1TableViewCell *cell = (MyProfileView1TableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (void)makePopView{
    self.popView = [MyController createImageViewWithFrame:CGRectMake(20, [MyController getScreenHeight] / 2 - 100, [MyController getScreenWidth] - 40, 200) ImageName:nil];
    self.popView.backgroundColor = [MyController colorWithHexString:@"6b7479"];
    //    self.popView.alpha = 0.8;
    
    UIView* bv = [MyController createImageViewWithFrame:CGRectMake(0, 0, self.popView.frame.size.width, 200) ImageName:nil];
    bv.backgroundColor = [UIColor whiteColor];
    [self.popView addSubview:bv];
    
    UILabel* titLable = [MyController createLabelWithFrame:CGRectMake(0, 0, self.popView.frame.size.width, 50) Font:16 Text:@"我的推荐人"];
    titLable.textAlignment = NSTextAlignmentCenter;
    [self.popView addSubview:titLable];
    
    UILabel* titLable1 = [MyController createLabelWithFrame:CGRectMake(0, CGRectGetMaxY(titLable.frame), self.popView.frame.size.width, 50) Font:12 Text:@"*推荐人只能绑定一次。成功绑定即可获得积分。"];
    titLable1.textAlignment = NSTextAlignmentCenter;
    titLable1.textColor = [UIColor redColor];
    [self.popView addSubview:titLable1];
    
    UITextField* tf = [MyController createTextFieldWithFrame:CGRectMake(20, CGRectGetMaxY(titLable1.frame), self.popView.frame.size.width - 40, 40) placeholder:@"请输入推荐码" passWord:NO leftImageView:nil rightImageView:nil Font:14];
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
    LoginDataBaseModel* model = [[[DBManager shareManager]getAllLoginModel]lastObject];
    if ([model.myInvateCode isEqualToString:tf.text]) {
        [HUD error:@"不能输入自己的邀请码"];
        return;
    }else{
        if (![MyController isBlankString:tf.text]) {
            [alert hide];
            [HUD loading];
            self.yaoqingmaStr = tf.text;
            [self createAddyaoqingma:tf.text];
        }else{
            [HUD error:@"请输入推荐码"];
        }
    }
}
- (void)cancleBtnClick{
    [alert hide];
}
- (void)createAddyaoqingma:(NSString*)code{
    [HUD loading];
    
    NSString* requestAddress = ADDRECOMMENDPERSON;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid,
                                              @"code":code
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD success:responseObject[@"data"]];
                  MyProfile1Model* myModel1 = [self.datasourceArr2 lastObject];
                  myModel1.titleStr = @"我的推荐人";
                  myModel1.titleStr1 = self.yaoqingmaStr;
                  
                  LoginDataBaseModel* loginM = [[[DBManager shareManager] getAllLoginModel] lastObject];
                  [[DBManager shareManager] upYaoqingma:self.yaoqingmaStr other:loginM.recommendPreson];
                  //一个section刷新
                  NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
                  [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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
