//
//  LoginViewController.m
//  E展汇
//
//  Created by 徐仁强 on 16/2/3.
//  Copyright © 2016年 徐仁强. All rights reserved.
//

#import "LoginViewController.h"

#import "RegistNowViewController.h"

#import "ForgetPasswordViewController.h"

#import "AppDelegate.h"
@interface LoginViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}

@property(nonatomic,retain)UIImageView* loginIV;
@property(nonatomic,retain)UIImageView* leftNameIV1;
@property(nonatomic,retain)UIImageView* leftPWIV1;
@property(nonatomic,retain)UIImageView* nameImageView;
@property(nonatomic,retain)UIImageView* PWImageView;

@property(nonatomic,retain)UITextField* nameTF;
@property(nonatomic,retain)UITextField* PWTF;

@property(nonatomic,retain)UILabel* zhucewangjiLable;

@property(nonatomic,retain)UIButton* dengluBtn;
@property(nonatomic,retain)UIButton* zhuceBtn;
@property(nonatomic,retain)UIButton* wangjimimaBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createTableView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated{

    self.navigationController.navigationBarHidden = YES;
}

- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], [MyController getScreenHeight]) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.image = [UIImage imageNamed:@"denglubeijing"];
    [_tableView setBackgroundView:tableBg];
    //分割线类型
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    //_tableView.backgroundColor = [UIColor colorWithRed:190 green:30 blue:96 alpha:1];
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self makecellUI:cell];
    return cell;
}
- (void)makecellUI:(UITableViewCell*)cell{
    self.loginIV = [[UIImageView alloc] init];
    self.loginIV.image = [UIImage imageNamed:@"企业详情背景默认"];
    [cell addSubview:self.loginIV];
    [self.loginIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo([MyController getScreenWidth] / 2 - 43);
        make.top.mas_equalTo(65);
        make.width.mas_offset(86);
        make.height.mas_offset(135);
    }];
    
    self.nameImageView = [[UIImageView alloc] init];
    [cell addSubview:self.nameImageView];
    self.nameImageView.image = [UIImage imageNamed:@"登录框"];
    
    [self.nameImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo([MyController getScreenHeight] - 190);
        make.height.mas_offset(40);
    }];
    
    self.leftNameIV1 = [[UIImageView alloc] init];
    self.leftNameIV1.image = [UIImage imageNamed:@"用户名"];
    [cell addSubview:self.leftNameIV1];
    [self.leftNameIV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.nameImageView);
        make.width.mas_offset(40);
        make.height.mas_equalTo(self.nameImageView);
    }];
    
    self.nameTF = [MyController createTextFieldWithFrame:cell.frame placeholder:@"请输入用户名" passWord:NO leftImageView:nil rightImageView:nil Font:16];
    self.nameTF.keyboardType = UIKeyboardTypeNumberPad;
    [cell addSubview:self.nameTF];
    [self.nameTF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(65);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.nameImageView);
        make.height.mas_offset(40);
    }];
    
    self.PWImageView = [[UIImageView alloc] init];
    [cell addSubview:self.PWImageView];
    self.PWImageView.image = [UIImage imageNamed:@"登录框"];
    
    [self.PWImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.nameImageView.mas_bottom).offset(2);
        make.height.mas_offset(40);
    }];
    
    
    self.leftPWIV1 = [[UIImageView alloc] init];
    self.leftPWIV1.image = [UIImage imageNamed:@"输入密码"];
    [cell addSubview:self.leftPWIV1];
    [self.leftPWIV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.PWImageView);
        make.width.mas_offset(40);
        make.height.mas_equalTo(self.PWImageView);
    }];
    
    LoginDataBaseModel* mmm = [[[DBManager shareManager] getAllLoginModel] lastObject];
    if ([MyController isBlankString:mmm.userId]) {
        self.nameTF.text = mmm.phoneNum;
    }
    
    self.PWTF = [MyController createTextFieldWithFrame:cell.frame placeholder:@"请输入密码" passWord:YES leftImageView:nil rightImageView:nil Font:16];
    [cell addSubview:self.PWTF];
    [self.PWTF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(65);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.PWImageView);
        make.height.mas_offset(40);
    }];
    
    self.dengluBtn = [MyController createButtonWithFrame:cell.frame ImageName:nil Target:self Action:@selector(dengluBtnClick) Title:@"登录"];
    [self.dengluBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.dengluBtn setBackgroundColor:[UIColor whiteColor]];
    self.dengluBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cell addSubview:self.dengluBtn];
    
    [self.dengluBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(self.PWImageView.mas_bottom).offset(10);
        make.right.mas_equalTo(0);
        make.height.mas_offset(40);
    }];
    
    self.zhucewangjiLable = [[UILabel alloc] init];
    self.zhucewangjiLable.text = @"立即注册  | 忘记密码 ？";
    [cell addSubview:self.zhucewangjiLable];
    self.zhucewangjiLable.textColor = [UIColor whiteColor];
    self.zhucewangjiLable.numberOfLines = 1;
    self.zhucewangjiLable.font = [UIFont systemFontOfSize:12];
    
    [self.zhucewangjiLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(self.dengluBtn.mas_bottom).offset(13);
        make.height.mas_offset(12);
    }];
    
    self.zhuceBtn = [MyController createButtonWithFrame:cell.frame ImageName:nil Target:self Action:@selector(zhuceBtnClick) Title:nil];
    [cell addSubview:self.zhuceBtn];
    
    [self.zhuceBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(200);
        make.top.mas_equalTo(self.dengluBtn.mas_bottom);
        make.right.mas_equalTo(-65);
        make.height.mas_offset(30);
    }];
    
    self.wangjimimaBtn = [MyController createButtonWithFrame:cell.frame ImageName:nil Target:self Action:@selector(wangjimimaBtnClick) Title:nil];
    [cell addSubview:self.wangjimimaBtn];
    
    [self.wangjimimaBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.zhuceBtn.mas_right);
        make.top.mas_equalTo(self.zhuceBtn);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(self.zhuceBtn);
    }];
    
}
- (void)leftDengluBtnClick{
}
- (void)dengluBtnClick{
    if (![RegularExpressions validateMobile:self.nameTF.text]) {
        
        [HUD warning:@"请正确输入手机号"];
        return;
    }else if (self.PWTF.text.length < 6){
        
        [HUD warning:@"请输入六位以上密码"];
        return;
    }else{
        [HUD loading];
        [self createLoginRequest];
    }
    
}
- (void)zhuceBtnClick{
    RegistNowViewController* vc = [[RegistNowViewController alloc] init];
    vc.title = @"注册";
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)wangjimimaBtnClick{
    ForgetPasswordViewController* vc = [[ForgetPasswordViewController alloc] init];
    vc.title = @"忘记密码";
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _tableView.frame.size.height;
}
- (void)createLoginRequest{
    
    NSString* requestAddress = LOGINURL;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"username":self.nameTF.text,
                                              @"password":self.PWTF.text
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD hide];
                  [[DBManager shareManager] deleteLoginData];
                  NSString *dataStr = [responseObject objectForKey:@"data"];
                  NSDictionary *dic  = [MyController dictionaryWithJsonString:dataStr];
                  [[DBManager shareManager]deleteLoginData];
                  LoginDataBaseModel *model = [[LoginDataBaseModel alloc] init];
                  model.userId = [dic objectForKey:@"uid"];
                  model.phoneNum = self.nameTF.text;
                  model.nickName = [dic objectForKey:@"truename"];
                  model.userHeadImage = [MyController returnStr:dic[@"img"]];//后台未返回
                  model.myInvateCode = [MyController returnStr:dic[@"myInvateCode"]];
                  model.recommendPreson = [MyController returnStr:dic[@"invateCode"]];
                  model.password = self.PWTF.text;
                  [[DBManager shareManager] insertLoginModel:model];
                  [(AppDelegate *)[UIApplication sharedApplication].delegate setIndexVC];
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"请检查网络"];
          }];
}


@end
