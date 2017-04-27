//
//  RecyclingCarViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/7/27.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "RecyclingCarViewController.h"

#import "RecyclingCarEditViewController.h"

#import "ConfirmAppointmentRecyclingViewController.h"
@interface RecyclingCarViewController ()<RecyclingCarEditViewControllerDelegate,ConfirmAppointmentRecyclingViewControllerDelegate>{
    UILabel* jifenLable;
    float totalpoint;
}
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,assign)NSInteger pageIndex;

@end
@implementation RecyclingCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"回收车";
    
    self.userid = [MyController getUserid];
    
    self.pageIndex = 1;
    
    totalpoint = 0.00;
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    self.idDatasourceArr = [[NSMutableArray alloc] init];
//    [self makeData];
    
    [self createTableView];
    
    [self makeBottomUI];
    
    [self createRightNav];
 
    [_tableView.header beginRefreshing];
}
- (void)sendBackYuyueIdStr:(NSString *)idStr{
    if (![MyController isBlankString:idStr]) {
        NSArray *array = [idStr componentsSeparatedByString:@","];
        int i = (int)[self.idDatasourceArr count] - 1;
        for(;i >= 0;i --){
            //containsObject 判断元素是否存在于数组中(根据两者的内存地址判断，相同：YES  不同：NO）
            if([array containsObject:[self.idDatasourceArr objectAtIndex:i]]) {
                [self.datasourceArr removeObjectAtIndex:i];
            }
        }
        jifenLable.text = [NSString stringWithFormat:@"总价：0.00积分"];
        [MyController fuwenbenLabel:jifenLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(3, jifenLable.text.length - 3) AndColor:[UIColor redColor]];
        [_tableView reloadData];
    }
}
- (void)sendBackIdStr:(NSString *)idStr{
    if (![MyController isBlankString:idStr]) {
        NSArray *array = [idStr componentsSeparatedByString:@","];
        int i = (int)[self.idDatasourceArr count] - 1;
        for(;i >= 0;i --){
            //containsObject 判断元素是否存在于数组中(根据两者的内存地址判断，相同：YES  不同：NO）
            if([array containsObject:[self.idDatasourceArr objectAtIndex:i]]) {
                [self.datasourceArr removeObjectAtIndex:i];
            }
        }
        [_tableView reloadData];
    }
}
- (void)sendBackSelectCarNum:(NSInteger)cellIndex{
    totalpoint = 0.00;
    RecyclingCarModel* model = self.datasourceArr[cellIndex];
    model.isSelected = !model.isSelected;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:cellIndex inSection:0];
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
    for (int i = 0; i < self.datasourceArr.count; i++) {
        RecyclingCarModel* model1 = self.datasourceArr[i];
        if (model1.isSelected) {
            totalpoint += model1.point * model1.carNum;
        }
    }
    jifenLable.text = [NSString stringWithFormat:@"总价：%.2f积分",totalpoint];
    [MyController fuwenbenLabel:jifenLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(3, jifenLable.text.length - 3) AndColor:[UIColor redColor]];
}
- (void)createRightNav{
    UIButton*rightButton1 = [[UIButton alloc]initWithFrame:CGRectMake(160,0,40,30)];
    [rightButton1 setTitle:@"编辑" forState:UIControlStateNormal];
    rightButton1.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightButton1 addTarget:self action:@selector(carBtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:rightButton1];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightItem1, nil];
}

- (void)carBtnClick{
    RecyclingCarEditViewController* vc = [[RecyclingCarEditViewController alloc] init];
    vc.title = @"回收车";
    vc.RecyclingCarEditViewControllerDelegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewWillAppear:(BOOL)animated{
    if (self.datasourceArr.count) {
        for (int i = 0; i < self.datasourceArr.count; i++) {
            RecyclingCarModel* model = self.datasourceArr[i];
            model.isFromMakesure = NO;
        }
        
    }
}
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    
    makeSureBtn = [MyController createButtonWithFrame:CGRectMake(10, 10, 20, 20) ImageName:@"不爱点击" Target:self Action:@selector(makeSureBtnClick) Title:nil];
    [bottomView addSubview:makeSureBtn];
    
    UILabel* quanxuanLable = [MyController createLabelWithFrame:CGRectMake(CGRectGetMaxX(makeSureBtn.frame) + 5, 0, 40, 40) Font:14 Text:@"全选"];
    [bottomView addSubview:quanxuanLable];
    
    UIButton* makeSureBtntem = [MyController createButtonWithFrame:CGRectMake(0, 0, 75, 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:nil];
    [bottomView addSubview:makeSureBtntem];
    
    jifenLable = [MyController createLabelWithFrame:CGRectMake(CGRectGetMaxX(quanxuanLable.frame) + 5, 0, [MyController getScreenWidth] - 90 - CGRectGetMaxX(quanxuanLable.frame), 40) Font:14 Text:@"总计: 0积分"];
    jifenLable.textAlignment = NSTextAlignmentRight;
    [bottomView addSubview:jifenLable];
    [MyController fuwenbenLabel:jifenLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(3, jifenLable.text.length - 3) AndColor:[UIColor redColor]];
    
    UIButton* makeSureBtn1 = [MyController createButtonWithFrame:CGRectMake([MyController getScreenWidth] - 80, 0, 80, 40) ImageName:nil Target:self Action:@selector(makeSure1BtnClick) Title:@"确认"];
    [makeSureBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    makeSureBtn1.titleLabel.font = [UIFont systemFontOfSize:14];
    [makeSureBtn1 setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    [bottomView addSubview:makeSureBtn1];
    
    UIView* lineV = [MyController viewWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 0.5)];
    lineV.backgroundColor = [MyController colorWithHexString:@"d8d8d8"];
    [bottomView addSubview:lineV];
}
- (void)makeSureBtnClick{
    self.isSelectAll = !self.isSelectAll;
    totalpoint = 0.0;
    if (self.isSelectAll) {
        [makeSureBtn setBackgroundImage:[UIImage imageNamed:@"爱点击"] forState:UIControlStateNormal];
        for (int i = 0; i < self.datasourceArr.count; i++) {
            RecyclingCarModel* model = self.datasourceArr[i];
            totalpoint += model.point * model.carNum;
        }
        jifenLable.text = [NSString stringWithFormat:@"总价：%.2f积分",totalpoint];
    }else{
        [makeSureBtn setBackgroundImage:[UIImage imageNamed:@"不爱点击"] forState:UIControlStateNormal];
        jifenLable.text = [NSString stringWithFormat:@"总价：0积分"];
    }
    for (int i = 0; i < self.datasourceArr.count; i++) {
        RecyclingCarModel* model = self.datasourceArr[i];
        model.isSelected = self.isSelectAll;
    }
    [MyController fuwenbenLabel:jifenLable FontNumber:[UIFont systemFontOfSize:14] AndRange:NSMakeRange(3, jifenLable.text.length - 3) AndColor:[UIColor redColor]];
    [_tableView reloadData];
}
- (void)makeSure1BtnClick{
    ConfirmAppointmentRecyclingViewController* vc = [[ConfirmAppointmentRecyclingViewController alloc] init];
    vc.datasourceArr1 = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.datasourceArr.count; i++) {
        RecyclingCarModel* model = self.datasourceArr[i];
        if (model.isSelected) {
            [vc.datasourceArr1 addObject:model];
        }
    }
    if (vc.datasourceArr1.count) {
        vc.ConfirmAppointmentRecyclingViewControllerDelegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [HUD warning:@"请选择要提交的物品"];
    }
    
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7]  -40) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [MyController colorWithHexString:@"f6f6f6"];
    [_tableView setBackgroundView:tableBg];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headRefresh];
    }];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{//精度
        [self footRefresh];
    }];
}
- (void)headRefresh{
    self.pageIndex = 1;
    [self createRequest];
}
- (void)footRefresh{
    self.pageIndex++;
    [self createRequest];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasourceArr.count;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"repltCar";
    RecyclingCarTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[RecyclingCarTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.RecyclingCarTableViewCellDelegate = self;
    celll.cellIndex = indexPath.row;
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    RecyclingCarModel* model = self.datasourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    RecyclingCarModel *model = nil;
    if (indexPath.row < self.datasourceArr.count) {
        model = [self.datasourceArr objectAtIndex:indexPath.row];
    }
    return [RecyclingCarTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        RecyclingCarTableViewCell *cell = (RecyclingCarTableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}

- (void)createRequest{
    NSString* requestUrl = CARLIST;
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestUrl parameters:@{
                                          @"userid":self.userid,
                                          @"pnum":[NSString stringWithFormat:@"%ld",self.pageIndex],
                                          @"num":@"10"
                                          }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSData *jsonData = [[responseObject objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
              NSArray *sourceArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
              NSMutableArray *_array = [NSMutableArray arrayWithCapacity:0];
              NSMutableArray *_idArray = [NSMutableArray arrayWithCapacity:0];
              if (![sourceArr isKindOfClass:[NSNull class]]) {
                  for (NSDictionary* dic in sourceArr) {
                      RecyclingCarModel* model = [[RecyclingCarModel alloc] init];
                      model.headImageStr = dic[@"imgurl"];
                      model.titleStr = [NSString stringWithFormat:@"%@ %@",dic[@"name"],dic[@"gilfstyle"]];
                      model.numStr = [NSString stringWithFormat:@"数量：%@/%@",dic[@"qty"],dic[@"guige"]];
                      model.carNum = [dic[@"qty"] intValue];
                      model.priceStr = [NSString stringWithFormat:@"预估价：%.2f积分",[dic[@"point"] floatValue] * [dic[@"qty"] intValue]];
                      model.point = [dic[@"point"] intValue];
                      model.isSelected = NO;
                      model.idStr = dic[@"id"];
                      [_array addObject:model];
                      [_idArray addObject:dic[@"id"]];
                  }
                  if (self.pageIndex == 1) {
                      [self.datasourceArr removeAllObjects];
                      [self.idDatasourceArr removeAllObjects];
                      [self.datasourceArr addObjectsFromArray:_array];
                      [self.idDatasourceArr addObjectsFromArray:_idArray];
                      [_tableView reloadData];
                      [_tableView.header endRefreshing];
                  }else {
                      [self.datasourceArr addObjectsFromArray:_array];
                      [self.idDatasourceArr addObjectsFromArray:_idArray];
                      [_tableView reloadData];
                      [_tableView.footer endRefreshing];
                  }
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
                  [_tableView.header endRefreshing];
                  [_tableView.footer endRefreshing];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"加载失败"];
              [_tableView.header endRefreshing];
              [_tableView.footer endRefreshing];
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
