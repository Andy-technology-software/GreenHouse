//
//  OnTheRecylingClassViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/6/29.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "OnTheRecylingClassViewController.h"

#import "MyProfileViewSelectInfoModel.h"

#import "MyProfileViewSelectInfoTableViewCell.h"
@interface OnTheRecylingClassViewController ()<UITableViewDataSource,UITableViewDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr;
@property(nonatomic,copy)NSString* classStr;
@property(nonatomic,copy)NSString* idStr;
@property(nonatomic,assign)BOOL isGilfnoStr;

@end

@implementation OnTheRecylingClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择投递种类";
    
    self.classStr = @"";
    
    self.idStr = @"";
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    
    [self createTableView];
    
    [self makeBottomUI];
    
    [HUD loading];
    [self createBackruleRequest];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    [self.view addSubview:bottomView];
    
    UIButton* makeSureBtn = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:@"确认"];
    [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:makeSureBtn];
    
    UIView* lineV = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 0.5)];
    lineV.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    [bottomView addSubview:lineV];
}
- (void)makeSureBtnClick{
    for (int i = 0; i < self.datasourceArr.count; i++) {
        MyProfileViewSelectInfoModel* model = self.datasourceArr[i];
        if (model.isSelected) {
            self.classStr = [self.classStr stringByAppendingString:[NSString stringWithFormat:@"%@,",model.titleStr]];
            self.idStr = [self.idStr stringByAppendingString:[NSString stringWithFormat:@"%@,",model.titleIdStr]];
            if (1 == [model.gilfno intValue] || 10 == [model.gilfno intValue]) {
                self.isGilfnoStr = YES;
            }
        }
    }
    
    if (![MyController isBlankString:self.idStr]) {
        self.classStr = [self.classStr substringToIndex:self.classStr.length - 1];
        self.idStr = [self.idStr substringToIndex:self.idStr.length - 1];
        [self.OnTheRecylingClassViewControllerDelegate sendBackClassStr:self.classStr AndIdStr:self.idStr Andgilfno:self.isGilfnoStr];
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [HUD warning:@"请选取分类"];
    }
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7]  -40) style:UITableViewStylePlain];
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
    return self.datasourceArr.count;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyProfileViewSelectInfoModel* model = self.datasourceArr[indexPath.row];
    model.isSelected = !model.isSelected;
    NSIndexPath *indexPathR = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPathR,nil] withRowAnimation:UITableViewRowAnimationNone];
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"MyProfileViewSelectInfo";
    MyProfileViewSelectInfoTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[MyProfileViewSelectInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    MyProfileViewSelectInfoModel* model = self.datasourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyProfileViewSelectInfoModel *model = nil;
    if (indexPath.row < self.datasourceArr.count) {
        model = [self.datasourceArr objectAtIndex:indexPath.row];
    }
    return [MyProfileViewSelectInfoTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        MyProfileViewSelectInfoTableViewCell *cell = (MyProfileViewSelectInfoTableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}
- (void)createBackruleRequest{
    NSString* requestAddress = BACKRULE;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD hide];
                  NSArray* temArr = [MyController arraryWithJsonString:responseObject[@"data"]];
                  if (temArr.count) {
                      for (NSDictionary* dic in temArr) {
                          MyProfileViewSelectInfoModel* model = [[MyProfileViewSelectInfoModel alloc] init];
                          model.titleStr = dic[@"gilfstyle"];
                          model.titleIdStr = dic[@"id"];
                          model.gilfno = dic[@"gilfno"];
                          [self.datasourceArr addObject:model];

                      }
                      
                      [_tableView reloadData];
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
