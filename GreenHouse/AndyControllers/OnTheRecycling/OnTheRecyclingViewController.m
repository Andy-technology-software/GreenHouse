//
//  OnTheRecyclingViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/4/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "OnTheRecyclingViewController.h"

#import "OnTheRecycling0Model.h"

#import "OnTheRecycling1Model.h"

#import "OnTheRecycling2Model.h"

#import "OnTheRecyclingAddModel.h"

#import "OnTheRecycling0TableViewCell.h"

#import "OnTheRecycling1TableViewCell.h"

#import "OnTheRecycling2TableViewCell.h"

#import "OnTheRecyclingAddressTableViewCell.h"

#import "OnTheRecyclingHeaderModel.h"

#import "OnTheRecyclingHeaderView.h"

#import "AppointmentToRecycleViewController.h"

#import "OnTheRecylingClassViewController.h"

#import "MyAddressViewController.h"

#import "MyAddressModel.h"

#import "AboutUsViewController.h"
@interface OnTheRecyclingViewController ()<UITableViewDataSource,UITableViewDelegate,OnTheRecycling1TableViewCellDelegate,OnTheRecycling2TableViewCellDelegate,OnTheRecylingClassViewControllerDelegate,OnTheRecyclingAddressTableViewCellDelegate,MyAddressViewControllerDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr0;
@property(nonatomic,retain)NSMutableArray* datasourceArr1;
@property(nonatomic,retain)NSMutableArray* datasourceArr2;
@property(nonatomic,retain)NSMutableArray* datasourceArr3;

@property(nonatomic,retain)NSMutableArray* datasourceHeadArr;

@property(nonatomic,copy)NSString* userid;
@property(nonatomic,copy)NSString* info;

@property(nonatomic,assign)BOOL isZhongliang;
@end

@implementation OnTheRecyclingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"上门回收";
    
    self.userid = [MyController getUserid];
    
    self.datasourceArr0 = [[NSMutableArray alloc] init];
    self.datasourceArr1 = [[NSMutableArray alloc] init];
    self.datasourceArr2 = [[NSMutableArray alloc] init];
    self.datasourceArr3 = [[NSMutableArray alloc] init];
    self.datasourceHeadArr = [[NSMutableArray alloc] init];
    self.info = @"";
    
    [self makeData];
    
    [self createTableView];
    
    [self makeBottomUI];
}
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)sendBackSeleAddress{
    MyAddressViewController* vc = [[MyAddressViewController alloc] init];
    vc.isNeedBack = YES;
    vc.MyAddressViewControllerDelegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)sendBackAddress:(MyAddressModel *)addressModel{
    OnTheRecyclingAddModel* s2M = [self.datasourceArr3 lastObject];
    s2M.addressStr = addressModel.titleStr;
    [_tableView reloadData];
}
- (void)sendBackClassStr:(NSString *)classStr AndIdStr:(NSString *)idStr Andgilfno:(BOOL)isGilfnoStr{
    OnTheRecycling0Model* model = [self.datasourceArr0 firstObject];
    model.fenleiStr = classStr;
    if (isGilfnoStr) {
        self.isZhongliang = YES;
    }else{
        self.isZhongliang = NO;
    }
    model.idStr = idStr;
    [_tableView reloadData];
}
- (void)xizeClick{
    AboutUsViewController* vc = [[AboutUsViewController alloc] init];
    vc.urlString = @"http://web.ronghaohuishou.cn/rule_desc.jsp";
    vc.title = @"回收细则";
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)sendBackZhongliang:(NSString *)zhongliang{
    OnTheRecycling1Model* model = [self.datasourceArr1 lastObject];
    if (![self isPureInt:zhongliang]) {
        [HUD error:@"重量请填写整数"];
         model.zhongliangStr = @"";
    }else{
        model.zhongliangStr = zhongliang;
    }
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)sendBackTel:(NSString *)tel{
    OnTheRecycling2Model* model = [self.datasourceArr2 lastObject];
    model.dianhuaStr = tel;
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    [self.view addSubview:bottomView];
    
    UIButton* makeSureBtn = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth] - 80, 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:@"立即预约回收"];
    [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:makeSureBtn];
    
    UIButton* kefuBtn = [MyController createButtonWithFrame:CGRectMake(CGRectGetMaxX(makeSureBtn.frame), makeSureBtn.frame.origin.y, 80, 40) ImageName:nil Target:self Action:@selector(kefuBtnClick) Title:@"客服"];
    [kefuBtn setTitleColor:[MyController colorWithHexString:DEFAULTCOLOR] forState:UIControlStateNormal];
    [kefuBtn setBackgroundColor:[UIColor whiteColor]];
    kefuBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:kefuBtn];
    
    UIView* lineV = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 0.5)];
    lineV.backgroundColor = [MyController colorWithHexString:DEFAULTCOLOR];
    [bottomView addSubview:lineV];
}
- (void)makeSureBtnClick{
    OnTheRecycling0Model* model0 = [self.datasourceArr0 firstObject];
    OnTheRecycling1Model* model = [self.datasourceArr1 lastObject];
    OnTheRecycling2Model* model2 = [self.datasourceArr2 lastObject];
    OnTheRecyclingAddModel* s2M = [self.datasourceArr3 lastObject];
    
    if ([MyController isBlankString:model0.idStr]) {
        [HUD error:@"请选择分类"];
        return;
    }else if ([MyController isBlankString:model.zhongliangStr] && self.isZhongliang) {
        [HUD error:@"请填写预估重量"];
        return;
    }else if (![RegularExpressions validateMobile:model2.dianhuaStr]){
        [HUD error:@"请正确填写联系电话"];
        return;
    }else if ([MyController isBlankString:s2M.addressStr]){
        [HUD error:@"请选择回收地址"];
        return;
    }else{
        if (!self.isZhongliang) {
            model.zhongliangStr = @"";
        }
        [HUD loading];
        OnTheRecycling0Model* mmm = [self.datasourceArr0 firstObject];
        self.info = [NSString stringWithFormat:@"{\"gilfstyle\":\"%@\",\"gilfno\":\"%@\",\"lxfs\":\"%@\",\"shdz\":\"%@\"}",mmm.fenleiStr,model.zhongliangStr,model2.dianhuaStr,[NSString stringWithFormat:@"%@",s2M.addressStr]];
        [self createSuccesspostRequest];
    }
}
- (void)kefuBtnClick{
    NSString* kefuPhone = @"4001388899";
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSString* str = [NSString stringWithFormat:@"tel:%@",kefuPhone];
    NSURL *telURL =[NSURL URLWithString:str];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
}
- (void)makeData{
    OnTheRecycling1Model* model = [[OnTheRecycling1Model alloc] init];
    model.zhongliangStr = @"";
    [self.datasourceArr1 addObject:model];
    
    LoginDataBaseModel *MModel = [[[DBManager shareManager] getAllLoginModel] lastObject];
    OnTheRecycling2Model* model2 = [[OnTheRecycling2Model alloc] init];
    model2.dianhuaStr = MModel.phoneNum;
    [self.datasourceArr2 addObject:model2];
    
    NSArray* titA = [[NSArray alloc] initWithObjects:@"请选择分类",@"请预估重量",@"请选择回收地址",@"请确认联系电话", nil];
    for (int i = 0; i < titA.count; i++) {
        OnTheRecyclingHeaderModel* modelH = [[OnTheRecyclingHeaderModel alloc] init];
        modelH.titleStr = titA[i];
        [self.datasourceHeadArr addObject:modelH];
    }
    
    OnTheRecycling0Model* model0 = [[OnTheRecycling0Model alloc] init];
    model0.isHaveMore = YES;
    model0.fenleiStr = @"请选择分类";
    model0.idStr = @"";
    [self.datasourceArr0 addObject:model0];
    
    OnTheRecyclingAddModel* s2M = [[OnTheRecyclingAddModel alloc] init];
    s2M.addressStr = @"";
    [self.datasourceArr3 addObject:s2M];
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
    }else if (3 == section){
        return self.datasourceArr2.count;
    }
    return self.datasourceArr3.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        OnTheRecylingClassViewController* vc = [[OnTheRecylingClassViewController alloc] init];
        vc.OnTheRecylingClassViewControllerDelegate = self;
        [self.navigationController pushViewController:vc animated:YES];
        
        OnTheRecycling0Model* model0 = self.datasourceArr0[0];
        model0.isHaveMore = YES;
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
        OnTheRecycling0Model* model = self.datasourceArr0[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }else if (1 == indexPath.section){
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
    }else if (3 == indexPath.section){
        NSString *cellIdentifier = @"OnTheRecycling2";
        OnTheRecycling2TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[OnTheRecycling2TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.OnTheRecycling2TableViewCellDelegate = self;
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        OnTheRecycling2Model* model = self.datasourceArr2[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }
    NSString *cellIdentifier = @"OnTheRecycling3";
    OnTheRecyclingAddressTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[OnTheRecyclingAddressTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    celll.OnTheRecyclingAddressTableViewCellDelegate = self;
    OnTheRecyclingAddModel* model = self.datasourceArr3[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        OnTheRecycling0Model *model = nil;
        if (indexPath.row < self.datasourceArr0.count) {
            model = [self.datasourceArr0 objectAtIndex:indexPath.row];
        }
        return [OnTheRecycling0TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            OnTheRecycling0TableViewCell *cell = (OnTheRecycling0TableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }else if (1 == indexPath.section){
        if (self.isZhongliang) {
            OnTheRecycling1Model *model = nil;
            if (indexPath.row < self.datasourceArr1.count) {
                model = [self.datasourceArr1 objectAtIndex:indexPath.row];
            }
            return [OnTheRecycling1TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
                OnTheRecycling1TableViewCell *cell = (OnTheRecycling1TableViewCell *)sourceCell;
                [cell configCellWithModel:model];
            }];
        }
        return 0;
    }else if (3 == indexPath.section){
        OnTheRecycling2Model *model = nil;
        if (indexPath.row < self.datasourceArr2.count) {
            model = [self.datasourceArr2 objectAtIndex:indexPath.row];
        }
        return [OnTheRecycling2TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            OnTheRecycling2TableViewCell *cell = (OnTheRecycling2TableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }
    OnTheRecyclingAddModel *model = nil;
    if (indexPath.row < self.datasourceArr3.count) {
        model = [self.datasourceArr3 objectAtIndex:indexPath.row];
    }
    return [OnTheRecyclingAddressTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        OnTheRecyclingAddressTableViewCell *cell = (OnTheRecyclingAddressTableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    OnTheRecyclingHeaderView *headView = [OnTheRecyclingHeaderView headViewWithTableView:tableView];
    OnTheRecyclingHeaderModel* model = self.datasourceHeadArr[section];
    [headView makeHeader:model];
    return headView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (1 == section) {
        if (self.isZhongliang) {
            return 40;
        }else{
            return 0;
        }
    }
    return 40;
}
- (void)createSuccesspostRequest{
    NSString* requestAddress = BACKONDOORURL;
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
                  
                  AppointmentToRecycleViewController* vc = [[AppointmentToRecycleViewController alloc] init];
                  OnTheRecycling0Model* model = [self.datasourceArr0 lastObject];
                  vc.fenleiStr = model.fenleiStr;
                  OnTheRecycling1Model* model1 = [self.datasourceArr1 lastObject];
                  vc.zhongliangStr = model1.zhongliangStr;
                  OnTheRecycling2Model* model2 = [self.datasourceArr2 lastObject];
                  vc.dianhuaStr = model2.dianhuaStr;
                  [self.navigationController pushViewController:vc animated:YES];
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"请检查网络"];
          }];
}

- (BOOL)isPureInt:(NSString*)string{
    NSScanner* scan = [NSScanner scannerWithString:string];
    int val;
    return[scan scanInt:val] && [scan isAtEnd];
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
