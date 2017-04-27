//
//  AddCommonlyUsedAddressViewController.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/5/29.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "AddCommonlyUsedAddressViewController.h"

#import "AddCommonlyUsedAddressModel.h"

#import "AddCommonlyUsedAddress1Model.h"

#import "AddCommonlyUsedAddress2Model.h"

#import "AddCommonlyUsedAddressHeaderModel.h"

#import "AddCommonlyUsedAddressTableViewCell.h"

#import "AddCommonlyUsedAddress1TableViewCell.h"

#import "AddCommonlyUsedAddress2TableViewCell.h"

#import "AddCommonlyUsedAddressHeadrView.h"
@interface AddCommonlyUsedAddressViewController ()<UITableViewDataSource,UITableViewDelegate,AddCommonlyUsedAddressTableViewCellDelegate,AddCommonlyUsedAddress2TableViewCellDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasource0Arr;
@property(nonatomic,retain)NSMutableArray* datasource1Arr;
@property(nonatomic,retain)NSMutableArray* datasource2Arr;
@property(nonatomic,retain)NSMutableArray* datasourceArr1;
@property(nonatomic,retain)NSMutableArray* headDatasourceArr;
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,copy)NSString* info;

@end

@implementation AddCommonlyUsedAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"添加常用地址";
    
    self.datasource0Arr = [[NSMutableArray alloc] init];
    self.datasource1Arr = [[NSMutableArray alloc] init];
    self.datasource2Arr = [[NSMutableArray alloc] init];
    self.datasourceArr1 = [[NSMutableArray alloc] init];
    self.headDatasourceArr = [[NSMutableArray alloc] init];
    
    self.userid = [MyController getUserid];
    
    [self makeData];
    
    [self createTableView];
    
    [self makeBottomUI];
}
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    [self.view addSubview:bottomView];
    
    UIButton* makeSureBtn = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:@"添加"];
    [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:makeSureBtn];
}
- (void)makeSureBtnClick{
    AddCommonlyUsedAddressModel* s0M = [self.datasource0Arr lastObject];
    AddCommonlyUsedAddressModel* s1M = [self.datasource1Arr lastObject];
    AddCommonlyUsedAddress2Model* s2M = [self.datasource2Arr lastObject];
    AddCommonlyUsedAddress1Model* s3M = [self.datasourceArr1 lastObject];
    
    if (![RegularExpressions validateMobile:s0M.contentStr]) {
        [HUD error:@"请正确输入手机号码"];
        return;
    }else if ([MyController isBlankString:s1M.contentStr]){
        [HUD error:@"请输入联系人姓名"];
        return;
    }else if ([MyController isBlankString:s2M.provinceStr]){
        [HUD error:@"请选取地区"];
        return;
    }else if ([MyController isBlankString:s2M.detailStr]){
        [HUD error:@"请输入详细地址"];
        return;
    }else {
        self.info = [NSString stringWithFormat:@"{\"addressee\":\"%@\",\"address\":\"%@\",\"province\":\"%@\",\"city\":\"%@\",\"area\":\"%@\",\"mobile\":\"%@\",\"tel\":\"%@\",\"isdefault\":%d,\"zipcode\":\"\"}",s1M.contentStr,s2M.detailStr,s2M.provinceStr,s2M.cityStr,s2M.areaStr,s0M.contentStr,s0M.contentStr,s3M.isDefault];
        [self createAddaddress];
    }
}
- (void)sendBackStr:(NSString *)str AndCellIndex:(NSInteger)index{
    if (0 == index) {
        AddCommonlyUsedAddressModel* s0M = [self.datasource0Arr lastObject];
        s0M.contentStr = str;
        s0M.placeStr = @"请输入手机号码";
    }else if (1 == index){
        AddCommonlyUsedAddressModel* s0M = [self.datasource1Arr lastObject];
        s0M.contentStr = str;
        s0M.placeStr = @"请输入姓名";
    }
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:index];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)send2BackStr:(NSString *)str AndCellIndex:(NSInteger)index{
    AddCommonlyUsedAddress2Model* s0M = [self.datasource2Arr lastObject];
    s0M.detailStr = str;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:index];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)send2BackAreaStr:(NSString *)prostr andCityStr:(NSString *)cityStr andAreaStr:(NSString *)areaStr{
    AddCommonlyUsedAddress2Model* s0M = [self.datasource2Arr lastObject];
    s0M.provinceStr = @"上海市";
    s0M.cityStr = @"上海市";
    s0M.areaStr = areaStr;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)makeData{
    AddCommonlyUsedAddressHeaderModel* model0 = [[AddCommonlyUsedAddressHeaderModel alloc] init];
    model0.titleStr = @"手机号码";
    [self.headDatasourceArr addObject:model0];
    
    AddCommonlyUsedAddressHeaderModel* model1 = [[AddCommonlyUsedAddressHeaderModel alloc] init];
    model1.titleStr = @"联系人姓名";
    [self.headDatasourceArr addObject:model1];
    
    AddCommonlyUsedAddressHeaderModel* model2 = [[AddCommonlyUsedAddressHeaderModel alloc] init];
    model2.titleStr = @"详细地址";
    [self.headDatasourceArr addObject:model2];
    
    AddCommonlyUsedAddressModel* s0M = [[AddCommonlyUsedAddressModel alloc] init];
    s0M.contentStr = @"";
    s0M.placeStr = @"请输入手机号码";
    [self.datasource0Arr addObject:s0M];
    
    AddCommonlyUsedAddressModel* s1M = [[AddCommonlyUsedAddressModel alloc] init];
    s1M.contentStr = @"";
    s1M.placeStr = @"请输入姓名";
    [self.datasource1Arr addObject:s1M];
    
    AddCommonlyUsedAddress2Model* s2M = [[AddCommonlyUsedAddress2Model alloc] init];
    s2M.provinceStr = @"";
    s2M.cityStr = @"";
    s2M.areaStr = @"";
    s2M.detailStr = @"";
    [self.datasource2Arr addObject:s2M];
    
    AddCommonlyUsedAddress1Model* s22M = [[AddCommonlyUsedAddress1Model alloc] init];
    s22M.isDefault = NO;
    [self.datasourceArr1 addObject:s22M];
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
        return self.datasource0Arr.count;
    }else if (1 == section){
        return self.datasource1Arr.count;
    }else if (2 == section){
        return self.datasource2Arr.count;
    }
    return self.datasourceArr1.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (3 == indexPath.section) {
        AddCommonlyUsedAddress1Model* s22M = [self.datasourceArr1 lastObject];
        s22M.isDefault = !s22M.isDefault;
        //一个section刷新
        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
        [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        NSString *cellIdentifier = @"add0";
        AddCommonlyUsedAddressTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[AddCommonlyUsedAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        celll.AddCommonlyUsedAddressTableViewCellDelegate = self;
        celll.cellIndex = indexPath.section;
        AddCommonlyUsedAddressModel* model = self.datasource0Arr[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }else if (1 == indexPath.section){
        NSString *cellIdentifier = @"add1";
        AddCommonlyUsedAddressTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[AddCommonlyUsedAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        celll.AddCommonlyUsedAddressTableViewCellDelegate = self;
        celll.cellIndex = indexPath.section;
        AddCommonlyUsedAddressModel* model = self.datasource1Arr[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }else if (2 == indexPath.section){
        NSString *cellIdentifier = @"add2";
        AddCommonlyUsedAddress2TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[AddCommonlyUsedAddress2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        celll.AddCommonlyUsedAddress2TableViewCellDelegate = self;
        celll.cellIndex = indexPath.section;
        AddCommonlyUsedAddress2Model* model = self.datasource2Arr[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }
    NSString *cellIdentifier = @"add3";
    AddCommonlyUsedAddress1TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[AddCommonlyUsedAddress1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    AddCommonlyUsedAddress1Model* model = self.datasourceArr1[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        AddCommonlyUsedAddressModel *model = nil;
        if (indexPath.row < self.datasource0Arr.count) {
            model = [self.datasource0Arr objectAtIndex:indexPath.row];
        }
        return [AddCommonlyUsedAddressTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            AddCommonlyUsedAddressTableViewCell *cell = (AddCommonlyUsedAddressTableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }else if (1 == indexPath.section){
        AddCommonlyUsedAddressModel *model = nil;
        if (indexPath.row < self.datasource1Arr.count) {
            model = [self.datasource1Arr objectAtIndex:indexPath.row];
        }
        return [AddCommonlyUsedAddressTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            AddCommonlyUsedAddressTableViewCell *cell = (AddCommonlyUsedAddressTableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }else if (2 == indexPath.section){
        AddCommonlyUsedAddress2Model *model = nil;
        if (indexPath.row < self.datasource2Arr.count) {
            model = [self.datasource2Arr objectAtIndex:indexPath.row];
        }
        return [AddCommonlyUsedAddress2TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            AddCommonlyUsedAddress2TableViewCell *cell = (AddCommonlyUsedAddress2TableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }
    AddCommonlyUsedAddress1Model *model = nil;
    if (indexPath.row < self.datasourceArr1.count) {
        model = [self.datasourceArr1 objectAtIndex:indexPath.row];
    }
    return [AddCommonlyUsedAddress1TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        AddCommonlyUsedAddress1TableViewCell *cell = (AddCommonlyUsedAddress1TableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (3  > section) {
        AddCommonlyUsedAddressHeadrView *headView = [AddCommonlyUsedAddressHeadrView headViewWithTableView:tableView];
        AddCommonlyUsedAddressHeaderModel* model = self.headDatasourceArr[section];
        [headView makeHeader:model];
        return headView;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (3  > section) {
        return 40;
    }
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (void)createAddaddress{
    NSString* requestAddress = ADDADDRESS;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid,
                                              @"info":self.info
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  NSString *dataStr = [responseObject objectForKey:@"data"];
                  [HUD success:dataStr];
                  [self.AddCommonlyUsedAddressViewControllerDelegate sendBackNeedLoading:YES];
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
