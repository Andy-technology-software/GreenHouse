//
//  FeedbackViewController.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/6/4.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)UITextView* fanhuiTV;
@property(nonatomic,copy)NSString* userid;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.userid = [MyController getUserid];
    
    self.title = @"意见反馈";
    
    [self createTableView];
    
    [self makeBottomUI];
}
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    [self.view addSubview:bottomView];
    
    UIButton* makeSureBtn = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:@"提交反馈"];
    [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:makeSureBtn];
}
- (void)makeSureBtnClick{
    if ([MyController isBlankString:self.fanhuiTV.text]) {
        [HUD error:@"写一点对我们的建议吧~"];
        return;
    }else{
        [HUD loading];
        [self createSuccesspostRequest];
    }
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 40) style:UITableViewStylePlain];
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.fanhuiTV = [[UITextView alloc] initWithFrame:CGRectMake(10, 40, [MyController getScreenWidth] - 20, 160)];
    self.fanhuiTV.font = [UIFont systemFontOfSize:14];
    self.fanhuiTV.placeholder = @"给我们提一些建议吧~";
    self.fanhuiTV.layer.borderColor = [MyController colorWithHexString:DEFAULTCOLOR].CGColor;
    self.fanhuiTV.layer.borderWidth =1.0;
    self.fanhuiTV.layer.cornerRadius =5.0;
    self.fanhuiTV.alpha = 0.6;
    [cell addSubview:self.fanhuiTV];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _tableView.frame.size.height;
}
- (void)createSuccesspostRequest{
    NSString* requestAddress = USERADVISE;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid,
                                              @"content":self.fanhuiTV.text
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
