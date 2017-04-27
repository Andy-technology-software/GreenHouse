//
//  GiftExchangeViewController.m
//  AndyCoder
//
//  Created by 徐仁强 on 16/4/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "GiftExchangeViewController.h"

#import "GiftExchangeModel.h"

#import "GiftExchangeTableViewCell.h"

#import "GiftDetailViewController.h"

#import "WJDropdownMenu.h"
@interface GiftExchangeViewController ()<UITableViewDataSource,UITableViewDelegate,WJMenuDelegate>{
    UITableView* _tableView;
    
}
@property (nonatomic,weak)WJDropdownMenu *menu;

//列表数据源
@property(nonatomic,retain)NSMutableArray* datasourceArr;
//筛选数据源
@property(nonatomic,retain)NSMutableArray* datasourceAreaArr;
@property(nonatomic,retain)NSMutableArray* datasourceAreaIdArr;
@property(nonatomic,retain)NSMutableArray* datasourceTypeArr;
@property(nonatomic,retain)NSMutableArray* datasourceTypeIdArr;
@property(nonatomic,retain)NSMutableArray* datasourcePriceArr;
@property(nonatomic,retain)NSMutableArray* datasourcePriceIdArr;

//请求需要的参数
@property(nonatomic,copy)NSString* userid;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,copy)NSString* areaStr;
@property(nonatomic,copy)NSString* typeStr;
@property(nonatomic,copy)NSString* priceStr;
@property(nonatomic,copy)NSString* info;//查询条件

@end

@implementation GiftExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"礼品兑换";
    
    self.datasourceArr = [[NSMutableArray alloc] init];
    
    self.pageIndex = 1;
    self.userid = [MyController getUserid];
    self.info = @"";
    
    [self createTableView];
    
    [HUD loading];
    [self createQueryRequest];
    
    [_tableView.header beginRefreshing];
}
- (void)viewWillAppear:(BOOL)animated{
    
}
#pragma mark - 初始化tableView
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7] + 40, self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7] - 40) style:UITableViewStylePlain];
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
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self headRefresh];
    }];
    _tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{//精度
        // 进入刷新状态后会自动调用这个block
        [self footRefresh];
    }];
}
#pragma mark - 下拉刷新
- (void)headRefresh{
    self.pageIndex = 1;
    
    [self createRequest];
}
#pragma mark - 上拉加载
- (void)footRefresh{
    self.pageIndex++;
    
    [self createRequest];
}
#pragma mark - tableView行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasourceArr.count;
}
#pragma mark - tableVie点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GiftExchangeModel* model = self.datasourceArr[indexPath.row];
    GiftDetailViewController* vc = [[GiftDetailViewController alloc] init];
    vc.presentId = model.idStr;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - 自定义tableView
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"GiftExchange";
    GiftExchangeTableViewCell *celll = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!celll) {
        celll = [[GiftExchangeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    GiftExchangeModel* model = self.datasourceArr[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
#pragma mark - tableView行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    GiftExchangeModel *model = nil;
    if (indexPath.row < self.datasourceArr.count) {
        model = [self.datasourceArr objectAtIndex:indexPath.row];
    }
    return [GiftExchangeTableViewCell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        GiftExchangeTableViewCell *cell = (GiftExchangeTableViewCell *)sourceCell;
        // 配置数据
        [cell configCellWithModel:model];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*********************************************************菜单************************************************************************/
- (void)makeMenUI{
    // 创建menu
    WJDropdownMenu *menu = [[WJDropdownMenu alloc]initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, 40)];
    menu.delegate = self;         //  设置代理
    [self.view addSubview:menu];
    self.menu = menu;
    
    // 设置属性(可不设置)
    menu.caverAnimationTime = 0.2;//  增加了遮盖层动画时间设置   不设置默认是  0.15
    menu.menuTitleFont = 12;      //  设置menuTitle字体大小    不设置默认是  11
    menu.tableTitleFont = 11;     //  设置tableTitle字体大小   不设置默认是  10
    menu.cellHeight = 38;         //  设置tableViewcell高度   不设置默认是  40
    menu.menuArrowStyle = menuArrowStyleSolid; // 旋转箭头的样式(空心箭头 or 实心箭头)
    menu.tableViewMaxHeight = 200; // tableView的最大高度(超过此高度就可以滑动显示)
    menu.CarverViewColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.5];//设置遮罩层颜色
    
#warning 此处有两种方法导入数据 1.第一种是直接导入菜单一级子菜单二级子菜单三级子菜单的所有数据  2.第二种是根据每次点击index的请求数据后返回下一菜单的数据时导入数据一级一级联动的网络请求数据所有的方法都是以net开头
    // 第一种方法一次性导入所有菜单数据
    [self createAllMenuData];
    
    // 第二中方法net网络请求一级一级导入数据，先在此导入菜单数据，然后分别再后面的net开头的代理方法中导入一级一级子菜单的数据
    //[menu netCreateMenuTitleArray:threeMenuTitleArray];
}

- (void)createAllMenuData{
    NSArray *threeMenuTitleArray =  @[@"区域",@"类型",@"积分"];
    //  创建第一个菜单的first数据second数据
    NSArray *firstArrOne = [NSArray arrayWithArray:self.datasourceAreaArr];//[NSArray arrayWithObjects:@"A一级菜单1",@"A一级菜单2",@"A一级菜单3", nil];
    NSArray *firstMenu = [NSArray arrayWithObject:firstArrOne];
    
    //  创建第二个菜单的first数据second数据
    NSArray *firstArrTwo = [NSArray arrayWithArray:self.datasourceTypeArr];//[NSArray arrayWithObjects:@"B一级菜单1",@"B一级菜单2", nil];
//    NSArray *secondArrTwo = @[@[@"B二级菜单11",@"B二级菜单12"],@[@"B二级菜单21",@"B二级菜单22"]];
//    NSArray *thirdArrTwo = @[@[@"B三级菜单11-1",@"B三级菜单11-2",@"B三级菜单11-3"],@[@"B三级菜单12-1",@"B三级菜单12-2"],@[@"B三级菜单21-1",@"B三级菜单21-2"],@[@"B三级菜单21-1",@"B三级菜单21-2"],@[@"B三级菜单22-1",@"B三级菜单22-2"]];
    NSArray *secondMenu = [NSArray arrayWithObjects:firstArrTwo, nil];
    
    //  创建第三个菜单的first数据second数据
    NSArray *firstArrThree = [NSArray arrayWithArray:self.datasourcePriceArr];//[NSArray arrayWithObjects:@"C一级菜单1",@"C一级菜单2", nil];
//    NSArray *secondArrThree = @[@[@"C二级菜单11",@"C二级菜单12"],@[@"C二级菜单21",@"C二级菜单22",@"C二级菜单23",@"C二级菜单24"]];
    NSArray *threeMenu = [NSArray arrayWithObjects:firstArrThree, nil];
    
    [self.menu createThreeMenuTitleArray:threeMenuTitleArray FirstArr:firstMenu SecondArr:secondMenu threeArr:threeMenu];
}

- (void)hideMenu{
    //  点击收缩menu
    [self.menu drawBackMenu];
}

#pragma mark -- 代理方法返回点击时对应的index

- (void)menuCellDidSelected:(NSInteger)MenuTitleIndex firstIndex:(NSInteger)firstIndex secondIndex:(NSInteger)secondIndex thirdIndex:(NSInteger)thirdIndex{
    
    NSLog(@"菜单数:%ld      一级菜单数:%ld      二级子菜单数:%ld  三级子菜单:%ld",MenuTitleIndex,firstIndex,secondIndex,thirdIndex);
    self.areaStr = @"";
    self.typeStr = @"";
    self.priceStr = @"";
    if (0 == MenuTitleIndex) {
        self.areaStr = self.datasourceAreaIdArr[firstIndex];
    }else if (1 == MenuTitleIndex){
        self.typeStr = self.datasourceTypeIdArr[firstIndex];
    }else if (2 == MenuTitleIndex){
        self.priceStr = self.datasourcePriceIdArr[firstIndex];
    }

    if ([MyController isBlankString:self.typeStr]) {
        self.info = [NSString stringWithFormat:@"{\"area\":\"%@\",\"price\":\"%@\"}",self.areaStr,self.priceStr];
    }else{
        self.info = [NSString stringWithFormat:@"{\"area\":\"%@\",\"type\":%d,\"price\":\"%@\"}",self.areaStr,[self.typeStr intValue],self.priceStr];
    }
    [_tableView.header beginRefreshing];
};


#pragma mark -- 代理方法返回点击时对应的内容
- (void)menuCellDidSelected:(NSString *)MenuTitle firstContent:(NSString *)firstContent secondContent:(NSString *)secondContent thirdContent:(NSString *)thirdContent{
    NSLog(@"菜单title:%@       一级菜单:%@         二级子菜单:%@    三级子菜单:%@",MenuTitle,firstContent,secondContent,thirdContent);
    
};

#if 0

#pragma mark -- net网络获取数据代理方法返回点击时菜单对应的index(导入子菜单数据)
- (void)netMenuClickMenuIndex:(NSInteger)menuIndex menuTitle:(NSString *)menuTitle{
    
    // 模拟网络加载数据延时0.5秒，相当于传一个menuIndex的参数返回数据之后 调用netLoadFirstArray方法，将网络请求返回数据导入一级数据到菜单
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (menuIndex == 0) {
            
            NSArray *firstArrTwo = [NSArray arrayWithObjects:@"A一级菜单1",@"A一级菜单2", nil];
            [self.menu netLoadFirstArray:firstArrTwo];
            
        }
        if (menuIndex == 1) {
            NSArray *firstArrTwo = [NSArray arrayWithObjects:@"B一级菜单1",@"B一级菜单2", nil];
            [self.menu netLoadFirstArray:firstArrTwo];
        }
        if (menuIndex == 2) {
            NSArray *firstArrTwo = [NSArray arrayWithObjects:@"C一级菜单1",@"C一级菜单2", nil];
            [self.menu netLoadFirstArray:firstArrTwo];
        }
    });
}


#pragma mark -- net网络获取数据代理方法返回点击时菜单和一级子菜单分别对应的index(导入子菜单数据)
- (void)netMenuClickMenuIndex:(NSInteger)menuIndex menuTitle:(NSString *)menuTitle FirstIndex:(NSInteger)FirstIndex firstContent:(NSString *)firstContent{
    
    // 模拟网络加载数据延时0.5秒，相当于传menuIndex、FirstIndex的两个参数返回数据之后，调用 netLoadSecondArray 方法，将网络请求返回数据导入二级数据到菜单
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (menuIndex == 0) {
            if (FirstIndex == 0) {
                NSArray *secondArrTwo = @[@"A二级菜单11",@"A二级菜单12",@"A二级菜单13",@"A二级菜单14",@"A二级菜单15",@"A二级菜单16",@"A二级菜单17",@"A二级菜单18",@"A二级菜单19",@"A二级菜单20",@"A二级菜单11",@"A二级菜单12",@"A二级菜单13",@"A二级菜单14",@"A二级菜单15",@"A二级菜单16",@"A二级菜单17",@"A二级菜单18",@"A二级菜单19",@"A二级菜单20"];
                [self.menu netLoadSecondArray:secondArrTwo];
            }
            if (FirstIndex == 1) {
                NSArray *secondArrTwo = @[@"A二级菜单21",@"A二级菜单22"];
                [self.menu netLoadSecondArray:secondArrTwo];
            }
        }
        if (menuIndex == 1) {
            if (FirstIndex == 0) {
                NSArray *secondArrTwo = @[@"B二级菜单11",@"B二级菜单12"];
                [self.menu netLoadSecondArray:secondArrTwo];
            }
            if (FirstIndex == 1) {
                NSArray *secondArrTwo = @[@"B二级菜单21",@"B二级菜单22"];
                [self.menu netLoadSecondArray:secondArrTwo];
            }
        }
        if (menuIndex == 2) {
            if (FirstIndex == 0) {
                NSArray *secondArrTwo = @[@"C二级菜单11",@"C二级菜单12"];
                [self.menu netLoadSecondArray:secondArrTwo];
                
            }
            if (FirstIndex == 1) {
                NSArray *secondArrTwo = @[@"C二级菜单21",@"C二级菜单22"];
                [self.menu netLoadSecondArray:secondArrTwo];
            }
        }
        
    });
}
#endif

#pragma mark - 礼品兑换条件请求
- (void)createQueryRequest{
    NSString* requestUrl = PRESENTQUERYURL;
    NSLog(@"-----%@",requestUrl);
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestUrl parameters:nil
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSString *dataStr = [responseObject objectForKey:@"data"];
              NSDictionary *dic  = [MyController dictionaryWithJsonString:dataStr];
              NSLog(@"礼品兑换条件----%@",responseObject[@"data"]);
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD hide];
                  self.datasourceAreaArr = [[NSMutableArray alloc] init];
                  self.datasourceAreaIdArr = [[NSMutableArray alloc] init];
                  
                  NSArray* temAreaArr = [[NSArray alloc] init];
                  temAreaArr = dic[@"area"];
                  [self.datasourceAreaArr addObject:@"全部地区"];
                  [self.datasourceAreaIdArr addObject:@""];
                  for (NSDictionary* dic in temAreaArr) {
                      [self.datasourceAreaArr addObject:dic[@"name"]];
                      [self.datasourceAreaIdArr addObject:dic[@"lid"]];
                  }
                  
                  self.datasourceTypeArr= [[NSMutableArray alloc] init];
                  self.datasourceTypeIdArr = [[NSMutableArray alloc] init];
                  
                  NSArray* temTypeArr = [[NSArray alloc] init];
                  temTypeArr = dic[@"type"];
                  [self.datasourceTypeArr addObject:@"全部分类"];
                  [self.datasourceTypeIdArr addObject:@""];
                  for (NSDictionary* dic in temTypeArr) {
                      [self.datasourceTypeArr addObject:dic[@"name"]];
                      [self.datasourceTypeIdArr addObject:dic[@"id"]];
                  }
                  
                  self.datasourcePriceArr = [[NSMutableArray alloc] init];
                  self.datasourcePriceIdArr = [[NSMutableArray alloc] init];
                  [self.datasourcePriceArr addObject:@"由高到低"];
                  [self.datasourcePriceArr addObject:@"由低到高"];
                  [self.datasourcePriceIdArr addObject:@"0"];
                  [self.datasourcePriceIdArr addObject:@"1"];
                  
                  [self makeMenUI];
                  
                  [HUD hide];
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"加载失败"];
              NSLog(@"-----%@",error);
              [_tableView.header endRefreshing];
              [_tableView.footer endRefreshing];
          }];
}

#pragma mark - 礼品兑换数据请求
- (void)createRequest{
    NSString* requestUrl = PRESENTLISTURL;
    NSLog(@"-----%@",requestUrl);
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestUrl parameters:@{
                                          @"userid":self.userid,
                                          @"pnum":[NSString stringWithFormat:@"%ld",self.pageIndex],
                                          @"num":@"10",
                                          @"info":self.info
                                          }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSData *jsonData = [[responseObject objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
              NSArray *sourceArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
              NSLog(@"礼品兑换----%@",responseObject[@"data"]);
              NSMutableArray *_array = [NSMutableArray arrayWithCapacity:0];
              if (![sourceArr isKindOfClass:[NSNull class]]) {
                  for (NSDictionary* dic in sourceArr) {
                      GiftExchangeModel* s0Model = [[GiftExchangeModel alloc] init];
                      s0Model.headImageStr = dic[@"thumb"];
                      s0Model.titleNameStr = dic[@"title"];
                      s0Model.addressStr = dic[@"jfqy"];
                      s0Model.idStr = dic[@"id"];
                      s0Model.timeStr = [NSString stringWithFormat:@"兑换截至：%@",dic[@"endtime"]];//@"兑换截至：2016-05-05";
                      s0Model.jifenStr = [NSString stringWithFormat:@"积分 %@",dic[@"point"]];//@"积分 40";
                      s0Model.shichangjiaStr = [NSString stringWithFormat:@"市场价：￥%@",dic[@"price"]];//@"市场价：￥20.00";
                      [_array addObject:s0Model];
                  }
                  //循环完成
                  if (self.pageIndex == 1) {
                      //删除原有数据 对数据源重新追加数据
                      [self.datasourceArr removeAllObjects];
                      [self.datasourceArr addObjectsFromArray:_array];
                      NSLog(@"数据源----%@",self.datasourceArr);
                      //刷新表格
                      [_tableView reloadData];
                      //下拉刷新停止
                      [_tableView.header endRefreshing];
                  }else {
                      //对现有数据源进行追加数据
                      [self.datasourceArr addObjectsFromArray:_array];
                      //刷新表格
                      [_tableView reloadData];
                      //上拉加载停止
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
              NSLog(@"-----%@",error);
              [_tableView.header endRefreshing];
              [_tableView.footer endRefreshing];
          }];
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
