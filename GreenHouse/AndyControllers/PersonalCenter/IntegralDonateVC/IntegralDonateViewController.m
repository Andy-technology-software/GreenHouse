//
//  IntegralDonateViewController.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/6/28.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "IntegralDonateViewController.h"

#import "OnTheRecycling0Model.h"

#import "OnTheRecycling1Model.h"

#import "OnTheRecycling0TableViewCell.h"

#import "OnTheRecycling1TableViewCell.h"

#import "OnTheRecyclingHeaderModel.h"

#import "OnTheRecyclingHeaderView.h"
@interface IntegralDonateViewController ()<UITableViewDataSource,UITableViewDelegate,OnTheRecycling1TableViewCellDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr0;
@property(nonatomic,retain)NSMutableArray* tempDatasourceArr0;
@property(nonatomic,retain)NSMutableArray* datasourceArr1;
@property(nonatomic,retain)NSMutableArray* datasourceHeadArr;
@property(nonatomic,assign)BOOL isShowClass;
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,copy)NSString* info;

@end


@implementation IntegralDonateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"积分捐赠";
    self.isShowClass = NO;
    self.userid = [MyController getUserid];
    
    self.datasourceArr0 = [[NSMutableArray alloc] init];
    self.datasourceArr1 = [[NSMutableArray alloc] init];
    self.datasourceHeadArr = [[NSMutableArray alloc] init];
    self.tempDatasourceArr0 = [[NSMutableArray alloc] init];
    self.info = @"";
    
    [self makeData];
    
    [self createTableView];
    
    [self makeBottomUI];
    
    [HUD loading];
    [self createBackruleRequest];
}
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)sendBackZhongliang:(NSString *)zhongliang{
    OnTheRecycling1Model* model = [self.datasourceArr1 lastObject];
    model.zhongliangStr = zhongliang;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    [self.view addSubview:bottomView];
    
    UIButton* makeSureBtn = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:@"确认捐赠"];
    [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:makeSureBtn];
    
    UIView* lineV = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 0.5)];
    lineV.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    [bottomView addSubview:lineV];
}
- (void)makeSureBtnClick{
    OnTheRecycling0Model* model0 = [self.tempDatasourceArr0 firstObject];
    OnTheRecycling1Model* model = [self.datasourceArr1 lastObject];
    if ([MyController isBlankString:model0.idStr]) {
        [HUD error:@"请选择慈善机构"];
        return;
    }else if ([MyController isBlankString:model.zhongliangStr]) {
        [HUD error:@"请输入捐赠积分"];
        return;
    }else{
        [HUD loading];
        [self createSuccesspostRequest:model0.idStr andPointStr:model.zhongliangStr];
    }
}
- (void)makeData{
    OnTheRecycling1Model* model = [[OnTheRecycling1Model alloc] init];
    model.zhongliangStr = @"";
    model.isJuanzeng = YES;
    [self.datasourceArr1 addObject:model];
    
    OnTheRecycling0Model* model0 = [[OnTheRecycling0Model alloc] init];
    model0.fenleiStr = @"请选择慈善机构";
    model0.idStr = @"";
    model0.isHaveMore = YES;
    [self.tempDatasourceArr0 addObject:model0];
    [self.datasourceArr0 addObject:model0];
    NSArray* titA = [[NSArray alloc] initWithObjects:@"请选择慈善机构",@"请输入捐赠积分", nil];
    for (int i = 0; i < titA.count; i++) {
        OnTheRecyclingHeaderModel* modelH = [[OnTheRecyclingHeaderModel alloc] init];
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
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return self.tempDatasourceArr0.count;
    }
    return self.datasourceArr1.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        if (self.isShowClass) {
            self.isShowClass = NO;
            
            if (self.datasourceArr0.count) {
                [self.tempDatasourceArr0 removeAllObjects];
                [self.tempDatasourceArr0 addObject:self.datasourceArr0[indexPath.row]];
            }
        }else{
            self.isShowClass = YES;
            
            if (self.datasourceArr0.count) {
                [self.tempDatasourceArr0 removeAllObjects];
                [self.tempDatasourceArr0 addObjectsFromArray:self.datasourceArr0];
            }
        }
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        NSString *cellIdentifier = @"OnTheRecycling0";
        OnTheRecycling0TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[OnTheRecycling0TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        OnTheRecycling0Model* model = self.tempDatasourceArr0[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }
    NSString *cellIdentifier = @"OnTheRecycling1";
    OnTheRecycling1TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[OnTheRecycling1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.OnTheRecycling1TableViewCellDelegate = self;
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    OnTheRecycling1Model* model = self.datasourceArr1[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        OnTheRecycling0Model *model = nil;
        if (indexPath.row < self.tempDatasourceArr0.count) {
            model = [self.tempDatasourceArr0 objectAtIndex:indexPath.row];
        }
        return [OnTheRecycling0TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            OnTheRecycling0TableViewCell *cell = (OnTheRecycling0TableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }
    OnTheRecycling1Model *model = nil;
    if (indexPath.row < self.datasourceArr1.count) {
        model = [self.datasourceArr1 objectAtIndex:indexPath.row];
    }
    return [OnTheRecycling1TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        OnTheRecycling1TableViewCell *cell = (OnTheRecycling1TableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OnTheRecyclingHeaderView *headView = [OnTheRecyclingHeaderView headViewWithTableView:tableView];
    OnTheRecyclingHeaderModel* model = self.datasourceHeadArr[section];
    [headView makeHeader:model];
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (void)createSuccesspostRequest:(NSString*)idStr andPointStr:(NSString*)pointStr{
    NSString* requestAddress = CONTRIBUTE;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid,
                                              @"id":idStr,
                                              @"point":pointStr
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
- (void)createBackruleRequest{
    NSString* requestAddress = FINDMISSIONS;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"num":@"999",
                                              @"pnum":@"1"
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD hide];
                  NSArray* temArr = [MyController arraryWithJsonString:responseObject[@"data"]];
                  if (temArr.count) {
                      for (NSDictionary* dic in temArr) {
                          OnTheRecycling0Model* model0 = [[OnTheRecycling0Model alloc] init];
                          model0.fenleiStr = dic[@"truename"];
                          model0.idStr = dic[@"uid"];
                          model0.gilfnoStr = dic[@"username"];
                          [self.datasourceArr0 addObject:model0];
                      }
                    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
                      [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
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
