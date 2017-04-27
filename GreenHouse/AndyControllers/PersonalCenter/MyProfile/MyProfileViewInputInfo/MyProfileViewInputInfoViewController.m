//
//  MyProfileViewInputInfoViewController.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyProfileViewInputInfoViewController.h"

@interface MyProfileViewInputInfoViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}

@end

@implementation MyProfileViewInputInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createTableView];
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height-[MyController isIOS7]) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [UIColor colorWithRed:219/255.0 green:225/255.0 blue:230/255.0 alpha:1];
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
    
    UITextField* tf = [MyController createTextFieldWithFrame:CGRectMake(0, 10, [MyController getScreenWidth], 40) placeholder:self.placrInfo passWord:NO leftImageView:nil rightImageView:nil Font:14];
    tf.tag = 100;
    if ([@"请输入您的年龄" isEqualToString:self.placrInfo]) {
        tf.keyboardType = UIKeyboardTypeNumberPad;
    }
    tf.layer.borderColor = [[UIColor grayColor] CGColor];
    tf.layer.borderWidth = 0.5;
    tf.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 8, 0)];
    tf.leftViewMode = UITextFieldViewModeAlways;
    [cell addSubview:tf];
    
    UIButton* sureBtn = [MyController createButtonWithFrame:CGRectMake(0, 80, [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(sureBtnClick) Title:@"确定"];
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [sureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    [sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cell addSubview:sureBtn];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (void)sureBtnClick{
    UITextField* tf = (UITextField*)[_tableView viewWithTag:100];
    if ([@"请输入您的邮箱" isEqualToString:self.placrInfo]) {
        if (![RegularExpressions validateEmail:tf.text]) {
            [HUD warning:@"请正确输入邮箱"];
            return;
        }
    }
    [self.MyProfileViewInputInfoViewControllerDelegate sendBackStr:tf.text];
    [self.navigationController popViewControllerAnimated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.frame.size.height;
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
