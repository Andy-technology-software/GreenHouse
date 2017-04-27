//
//  GiftDetailViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "GiftDetailViewController.h"

#import "GiftDetailS0Model.h"

#import "GiftDetailS1Model.h"

#import "GiftDetailTableViewCell.h"

#import "GiftDetail1TableViewCell.h"

#import "AppointmentExchangeViewController.h"

#import "AppointmentExchange0Model.h"

#import "PicReviewViewController.h"
@interface GiftDetailViewController ()<UITableViewDataSource,UITableViewDelegate,GiftDetailS0CellDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr;
@property(nonatomic,retain)NSMutableArray* datasourceArr1;
//请求需要的参数
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,assign)BOOL isCollect;

//传给所需节分
@property(nonatomic,copy)NSString* needJifen;
//礼品id
@property(nonatomic,copy)NSString* goodsid;
//礼品封面
@property(nonatomic,copy)NSString* thumStr;

//礼品收藏数量
@property(nonatomic,assign)NSInteger collectQty;
@end

@implementation GiftDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    self.datasourceArr1 = [[NSMutableArray alloc] init];
    
    self.title = @"礼品详情";
    
    self.userid = [MyController getUserid];
    
    [self createTableView];
    
    [self makeBottomUI];
    
    [self makeRightNav];
    
    [HUD loading];
    [self createPrentDetailRequest];
}
- (void)viewWillAppear:(BOOL)animated{
    
}
- (void)indexSeleAD:(NSInteger)index{
    PicReviewViewController* vc = [[PicReviewViewController alloc] init];
    GiftDetailS0Model *model = [self.datasourceArr lastObject];
    vc.pictureArr = model.picArr;
    vc.dangqianSelect = index;
    vc.numStr = [NSString stringWithFormat:@"%ld",index];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)selectWhichBtn:(NSInteger)index{
    if (100 == index) {
    }else if (101 == index){
    }else if (102 == index){
    }
}
- (void)makeBottomUI{
    UIView* bottomView = [MyController viewWithFrame:CGRectMake(0, CGRectGetMaxY(_tableView.frame), [MyController getScreenWidth], 40)];
    [self.view addSubview:bottomView];
    
    UIButton* makeSureBtn = [MyController createButtonWithFrame:CGRectMake(0, 0, [MyController getScreenWidth], 40) ImageName:nil Target:self Action:@selector(makeSureBtnClick) Title:@"预约兑换"];
    [makeSureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [makeSureBtn setBackgroundColor:[MyController colorWithHexString:DEFAULTCOLOR]];
    makeSureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [bottomView addSubview:makeSureBtn];
}
- (void)makeSureBtnClick{
    GiftDetailS0Model* s0Model = [self.datasourceArr lastObject];
    GiftDetailS1Model* model = [self.datasourceArr1 lastObject];
    AppointmentExchangeViewController* vc= [[AppointmentExchangeViewController alloc] init];
    vc.presentId = self.presentId;
    vc.s0Model = [[AppointmentExchange0Model alloc] init];
    vc.s0Model.jifenStr = model.suoxujifenStr;
    vc.s0Model.guigeStr = model.lipinGuigeStr;
    vc.s0Model.duihuanNumStr = @"兑换数量  1";
    vc.s0Model.isDingdianDuihuan = NO;
    vc.presentName = model.nameStr;
    vc.thumb = self.thumStr;
    vc.goodsid = self.goodsid;
    vc.needJifen = self.needJifen;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)makeRightNav{
    UIButton*rightButton1 = [[UIButton alloc]initWithFrame:CGRectMake(160,0,60,30)];
    rightButton1.titleLabel.font = [UIFont systemFontOfSize:12];
    if (self.isCollect) {
        [rightButton1 setImage:[UIImage imageNamed:@""]forState:UIControlStateNormal];
        [rightButton1 setTitle:@"已收藏" forState:UIControlStateNormal];
    }else{
        [rightButton1 setImage:[UIImage imageNamed:@""]forState:UIControlStateNormal];
        [rightButton1 setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        [rightButton1 setTitle:@"收藏" forState:UIControlStateNormal];
    }
    [rightButton1 addTarget:self action:@selector(BtnClick)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem*rightItem1 = [[UIBarButtonItem alloc]initWithCustomView:rightButton1];
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:rightItem1, nil];
}
- (void)BtnClick{
    [HUD loading];
    [self createCollectRequest];
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
        return self.datasourceArr.count;
    }
    return self.datasourceArr1.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        NSString *cellIdentifier = @"GiftDetail0";
        GiftDetailTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if (!celll) {
            celll = [[GiftDetailTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        celll.GiftDetailS0Delegate = self;
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        GiftDetailS0Model* model = self.datasourceArr[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }
    NSString *cellIdentifier = @"GiftDetail1";
    GiftDetail1TableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[GiftDetail1TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    GiftDetailS1Model* model = self.datasourceArr1[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        GiftDetailS0Model *model = nil;
        if (indexPath.row < self.datasourceArr.count) {
            model = [self.datasourceArr objectAtIndex:indexPath.row];
        }
        return [GiftDetailTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            GiftDetailTableViewCell *cell = (GiftDetailTableViewCell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }
    GiftDetailS1Model *model = nil;
    if (indexPath.row < self.datasourceArr1.count) {
        model = [self.datasourceArr1 objectAtIndex:indexPath.row];
    }
    return [GiftDetail1TableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        GiftDetail1TableViewCell *cell = (GiftDetail1TableViewCell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (void)createPrentDetailRequest{
    
    NSString* requestAddress = PRESENTDETAILURL;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid,
                                              @"id":self.presentId
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD hide];
                  NSString *dataStr = [responseObject objectForKey:@"data"];
                  NSLog(@"礼品详情请求---%@",dataStr);
                  NSDictionary *dic  = [MyController dictionaryWithJsonString:dataStr];
                  
                  GiftDetailS0Model* s0Model = [[GiftDetailS0Model alloc] init];
                  s0Model.picArr = [[NSMutableArray alloc] init];
                  s0Model.bottomArr = [[NSMutableArray alloc] init];
                  
                  NSString* temStr = dic[@"goodsImgs"];
                  NSString* aa = [temStr stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
                  NSArray* temImageArr = [MyController arraryWithJsonString:aa];
                  for (NSDictionary* dic in temImageArr) {
                      [s0Model.picArr addObject:dic[@"goodimageurl"]];
                  }
                  self.thumStr = [MyController returnStr:dic[@"thumb"]];
                  
                  [s0Model.bottomArr addObject:[NSString stringWithFormat:@"%d",[dic[@"duihuanliang"] intValue]]];
                  [s0Model.bottomArr addObject:[NSString stringWithFormat:@"%d",[dic[@"clickQty"] intValue]]];
                  [s0Model.bottomArr addObject:[NSString stringWithFormat:@"%d",[dic[@"collectQty"] intValue]]];
                  
                  self.collectQty = [dic[@"collectQty"] intValue];
                  [self.datasourceArr addObject:s0Model];
                  
                  GiftDetailS1Model* model = [[GiftDetailS1Model alloc] init];
                  model.nameStr = dic[@"title"];
                  model.suoxujifenStr = [NSString stringWithFormat:@"所需积分:  %@",dic[@"point"]];//@"所需积分  40";
                  self.needJifen = dic[@"point"];
                  model.shichangPriceStr = [NSString stringWithFormat:@"市场价格:  %@",dic[@"price"]];//@"市场价格  110";
                  model.lipinGuigeStr = [NSString stringWithFormat:@"礼品规格:  %@",dic[@"spec"]];//@"礼品规格  ";
                  model.lipinDanweiStr = [NSString stringWithFormat:@"礼品单位:  %@",dic[@"cpentity"]];//@"礼品单位  个";
                  model.shengyuNumStr = [NSString stringWithFormat:@"剩余数量:  %@",dic[@"surplus"]];//@"剩余数量  200";
                  model.duihuanjiezhiStr = [NSString stringWithFormat:@"兑换截止:  %@",dic[@"endtime"]];//@"兑换截止至  2016-01-01";
                  model.xiangxiDesStr = [NSString stringWithFormat:@"详细描述:  %@",dic[@"remark"]];//@"详细描述  一个美丽的杯子，让你在匆忙的工作之中，享受惬意~；把午后的阳光流进脑海！";
                  [self.datasourceArr1 addObject:model];
                  
                  self.goodsid = dic[@"id"];
                  
                  self.isCollect = [dic[@"isCollect"] boolValue];
                  if (self.isCollect) {
                      [self makeRightNav];
                  }
                  
                  [_tableView reloadData];
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"请检查网络"];
          }];
}



#pragma mark - 礼品收藏请求
- (void)createCollectRequest{
    NSString* flgS;
    if (self.isCollect) {
        flgS = @"0";
    }else{
        flgS = @"1";
    }
    NSString* requestAddress = PRESENTCOLLECTURL;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid,
                                              @"id":self.presentId,
                                              @"flg":flgS
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  NSString *dataStr = [responseObject objectForKey:@"data"];
                  NSLog(@"礼品详情请求---%@",dataStr);
                  GiftDetailS0Model* s0Model = [self.datasourceArr lastObject];
                  self.isCollect = !self.isCollect;
                  if (self.isCollect) {
                      [s0Model.bottomArr removeLastObject];
                      self.collectQty = self.collectQty + 1;
                      [s0Model.bottomArr addObject:[NSString stringWithFormat:@"%ld",self.collectQty]];
                  }else{
                      [s0Model.bottomArr removeLastObject];
                      self.collectQty = self.collectQty - 1;
                      [s0Model.bottomArr addObject:[NSString stringWithFormat:@"%ld",self.collectQty]];
                  }
                  
                  [self makeRightNav];
                  [HUD success:dataStr];
                  [_tableView reloadData];
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              NSLog(@"失败");
              NSLog(@"失败===%@", error);
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
