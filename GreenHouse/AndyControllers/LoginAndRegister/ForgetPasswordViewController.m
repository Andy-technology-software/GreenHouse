//
//  ForgetPasswordViewController.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/5/21.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "ForgetPasswordViewController.h"

#import "AppDelegate.h"
@interface ForgetPasswordViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>{
    UITableView* _tableView;
    NSString *code;
    NSTimer *countDownTimer;
    NSInteger secondsCountDown;
}

@property(nonatomic,retain)UIImageView* shoujihaoIV;
@property(nonatomic,retain)UIImageView* mimaIV;
@property(nonatomic,retain)UIImageView* mimaIV1;
@property(nonatomic,retain)UIImageView* yanzhengmaIV;

@property(nonatomic,retain)UITextField* shoujihaoTF;
@property(nonatomic,retain)UITextField* mimaTF;
@property(nonatomic,retain)UITextField* mimaTF1;
@property(nonatomic,retain)UITextField* yanzhengmaTF;

@property(nonatomic,retain)UILabel* shoujihaoLable;
@property(nonatomic,retain)UILabel* mimaLable;
@property(nonatomic,retain)UILabel* mimaLable1;

@property(nonatomic,retain)UIButton* huoquyanzhengBtn;
@property(nonatomic,retain)UIButton* registBtn;



@end

@implementation ForgetPasswordViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBar.titleTextAttributes = @{UITextAttributeTextColor: [UIColor whiteColor],
//                                                                    UITextAttributeFont : [UIFont boldSystemFontOfSize:16]};
    
    
    [self createTableView];
    
    [self createLeftNvc];
}
- (void)createLeftNvc{
    UIButton*rightButton = [MyController createButtonWithFrame:CGRectMake(10,25,27,27) ImageName:@"详情(" Target:self Action:@selector(backBtn11Click) Title:nil];
    [rightButton setImage:[UIImage imageNamed:@"详情("]forState:UIControlStateNormal];
    [rightButton setImage:[UIImage imageNamed:@"详情(-点击"]forState:UIControlStateHighlighted];
    [self.view addSubview:rightButton];
}
- (void)backBtn11Click{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], [MyController getScreenHeight]) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.image = [UIImage imageNamed:@"denglubeijing"];
    [_tableView setBackgroundView:tableBg];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
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
    
    self.shoujihaoIV = [[UIImageView alloc] init];
    [cell addSubview:self.shoujihaoIV];
    self.shoujihaoIV.image = [UIImage imageNamed:@"登录框"];
    
    [self.shoujihaoIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo([MyController getScreenHeight] - 245);
        make.height.mas_offset(40);
    }];
    
    self.shoujihaoLable = [[UILabel alloc] init];
    self.shoujihaoLable.text = @"手 机 号";
    [cell addSubview:self.shoujihaoLable];
    self.shoujihaoLable.textAlignment = NSTextAlignmentLeft;
    self.shoujihaoLable.numberOfLines = 1;
    self.shoujihaoLable.font = [UIFont systemFontOfSize:14];
    
    [self.shoujihaoLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.top.mas_equalTo(self.shoujihaoIV);
        make.height.mas_equalTo(self.shoujihaoIV);
        make.width.mas_offset(65);
    }];
    
    self.shoujihaoTF = [MyController createTextFieldWithFrame:cell.frame placeholder:@"请输入手机号" passWord:NO leftImageView:nil rightImageView:nil Font:16];
    self.shoujihaoTF.keyboardType = UIKeyboardTypeNumberPad;
    [cell addSubview:self.shoujihaoTF];
    [self.shoujihaoTF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.shoujihaoLable.mas_right);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.shoujihaoLable);
        make.height.mas_equalTo(self.shoujihaoLable);
    }];
    
    self.mimaIV = [[UIImageView alloc] init];
    [cell addSubview:self.mimaIV];
    self.mimaIV.image = [UIImage imageNamed:@"登录框"];
    
    [self.mimaIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.shoujihaoIV.mas_bottom).offset(2);
        make.height.mas_equalTo(self.shoujihaoIV);
    }];
    
    self.mimaLable = [[UILabel alloc] init];
    self.mimaLable.text = @"新 密 码";
    [cell addSubview:self.mimaLable];
    self.mimaLable.textAlignment = NSTextAlignmentLeft;
    self.mimaLable.numberOfLines = 1;
    self.mimaLable.font = [UIFont systemFontOfSize:14];
    
    [self.mimaLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.top.mas_equalTo(self.mimaIV);
        make.height.mas_equalTo(self.mimaIV);
        make.width.mas_offset(65);
    }];
    
    self.mimaTF = [MyController createTextFieldWithFrame:cell.frame placeholder:@"请输入密码" passWord:YES leftImageView:nil rightImageView:nil Font:16];
    [cell addSubview:self.mimaTF];
    [self.mimaTF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mimaLable.mas_right);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.mimaLable);
        make.height.mas_equalTo(self.mimaLable);
    }];
        self.mimaIV1 = [[UIImageView alloc] init];
    [cell addSubview:self.mimaIV1];
    self.mimaIV1.image = [UIImage imageNamed:@"登录框"];
    
    [self.mimaIV1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.mimaIV.mas_bottom).offset(2);
        make.height.mas_equalTo(self.mimaIV);
    }];
    
    self.mimaLable1 = [[UILabel alloc] init];
    self.mimaLable1.text = @"确认密码";
    [cell addSubview:self.mimaLable1];
    self.mimaLable1.textAlignment = NSTextAlignmentLeft;
    self.mimaLable1.numberOfLines = 1;
    self.mimaLable1.font = [UIFont systemFontOfSize:14];
    
    [self.mimaLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.top.mas_equalTo(self.mimaIV1);
        make.height.mas_equalTo(self.mimaIV1);
        make.width.mas_offset(65);
    }];
    
    self.mimaTF1 = [MyController createTextFieldWithFrame:cell.frame placeholder:@"请再次输入密码" passWord:YES leftImageView:nil rightImageView:nil Font:16];
    [cell addSubview:self.mimaTF1];
    [self.mimaTF1 mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mimaLable1.mas_right);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.mimaLable1);
        make.height.mas_equalTo(self.mimaLable1);
    }];
    
    self.yanzhengmaIV = [[UIImageView alloc] init];
    [cell addSubview:self.yanzhengmaIV];
    self.yanzhengmaIV.image = [UIImage imageNamed:@"登录框"];
    
    [self.yanzhengmaIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(self.mimaIV1.mas_bottom).offset(2);
        make.height.mas_equalTo(self.mimaIV1);
    }];
    
    self.yanzhengmaTF = [MyController createTextFieldWithFrame:cell.frame placeholder:@"请输入验证码" passWord:NO leftImageView:nil rightImageView:nil Font:16];
    [cell addSubview:self.yanzhengmaTF];
    [self.yanzhengmaTF mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(13);
        make.right.mas_equalTo(-110);
        make.top.mas_equalTo(self.yanzhengmaIV);
        make.height.mas_equalTo(self.yanzhengmaIV);
    }];
    
    self.huoquyanzhengBtn = [MyController createButtonWithFrame:cell.frame ImageName:@"用户注册-获取验证码" Target:self Action:@selector(huoquyanzhengBtnClick) Title:@"获取验证码"];
    [self.huoquyanzhengBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    [self.huoquyanzhengBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.huoquyanzhengBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [cell addSubview:self.huoquyanzhengBtn];
    
    [self.huoquyanzhengBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.yanzhengmaIV);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(self.yanzhengmaIV);
        make.width.mas_offset(100);
    }];
    
    self.registBtn = [MyController createButtonWithFrame:cell.frame ImageName:nil Target:self Action:@selector(registBtnClick) Title:nil];
    if (self.isChongzhi) {
        [self.registBtn setTitle:@"密码重置" forState:UIControlStateNormal];
    }else{
        [self.registBtn setTitle:@"找回密码" forState:UIControlStateNormal];
    }
    [self.registBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.registBtn setBackgroundColor:[UIColor whiteColor]];
    self.registBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [cell addSubview:self.registBtn];
    
    [self.registBtn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.huoquyanzhengBtn.mas_bottom).offset(10);
        make.right.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.height.mas_offset(40);
    }];
}

- (void)huoquyanzhengBtnClick{
    [HUD loading];
    [self YanZhengCodeRequest];
}
- (void)registBtnClick{
    if (![RegularExpressions validateMobile:self.shoujihaoTF.text]) {
        [HUD warning:@"请正确输入手机号"];
        return;
    }else if (![self.mimaTF.text isEqualToString:self.mimaTF1.text]){
        [HUD warning:@"两次密码输入不一致"];
        return;
    }else if (self.mimaTF.text.length < 6){
        [HUD warning:@"请输入六位以上密码"];
        return;
    }else if (![code isEqualToString:self.yanzhengmaTF.text]){
        [HUD warning:@"请正确输入验证码"];
        return;
    }else{
        [HUD loading];
        [self createRegisterRequest];
    }
}

-(void)timeFireMethod{
    secondsCountDown--;
    [self.huoquyanzhengBtn setTitle:[NSString stringWithFormat:@"%ld秒可再获取",secondsCountDown] forState:UIControlStateNormal];
    self.huoquyanzhengBtn.userInteractionEnabled = NO;
    if(secondsCountDown==0){
        [self.huoquyanzhengBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        self.huoquyanzhengBtn.userInteractionEnabled = YES;
        [countDownTimer invalidate];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _tableView.frame.size.height;
}

- (void)YanZhengCodeRequest{
    NSString* requestAddress = GETCODE;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"username":self.shoujihaoTF.text
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD success:@"验证码已发送"];
                  NSString *dataStr = [responseObject objectForKey:@"data"];
                  code = dataStr;
                  secondsCountDown = 60;
                  countDownTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"请检查网络"];
          }];
    
}
- (void)createRegisterRequest{
    NSString* requestAddress = CHANGEPASSWORDURL;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"username":self.shoujihaoTF.text,
                                              @"password":self.mimaTF.text
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  NSString *dataStr = [responseObject objectForKey:@"data"];
                  [HUD success:dataStr];
                  if (self.isChongzhi) {
                      [[DBManager shareManager] deleteLoginData];
                      [(AppDelegate *)[UIApplication sharedApplication].delegate logOut];
                  }else{
                      [self.navigationController popViewControllerAnimated:YES];
                  }
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
