//
//  IndexViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/4/11.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "IndexViewController.h"

#import "IndexS0Cell.h"

#import "IndexS1Cell.h"

#import "IndexS0Model.h"

#import "IndexS1Model.h"

#import "RecyclingMapViewController.h"

#import "ZCZBarViewController.h"

#import "CodeAndDeliveryViewController.h"

#import "GiftExchangeViewController.h"

#import "PersonalCenterViewController.h"

#import "MyICCardViewController.h"

#import "OnTheRecyclingViewController.h"

#import "MyDeliveryViewController.h"

#import "MyChangeViewController.h"

#import "GiftDetailViewController.h"

#import "AboutUsViewController.h"

#import "PicReviewViewController.h"

#import "NewOnTheRecyclingIndexViewController.h"
@interface IndexViewController ()<UITableViewDataSource,UITableViewDelegate,IndexS0CellDelegate,IndexS1CellDelegate>{
    UITableView* _tableView;
}
@property(nonatomic,retain)NSMutableArray* datasourceArr0;
@property(nonatomic,retain)NSMutableArray* datasourceArr1;
@property(nonatomic,copy)NSString* userid;

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.barTintColor = [MyController colorWithHexString:DEFAULTCOLOR];
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor],
                                                                    NSFontAttributeName : [UIFont boldSystemFontOfSize:16]};
    
    self.title = @"首页";
    
    self.view.backgroundColor = [MyController colorWithHexString:@"f6f6f6"];
    
    self.datasourceArr0 = [[NSMutableArray alloc] init];
    self.datasourceArr1 = [[NSMutableArray alloc] init];
    self.userid = [MyController getUserid];
    
    [self createTableView];
    
    [HUD loading];
}
- (void)viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;

    self.navigationItem.hidesBackButton = YES;
    
    [self createIndexPageRequest];
}

- (void)viewDidDisappear:(BOOL)animated{
    
}

- (void)clickS1Btn:(NSInteger)index{
    if (100 == index) {
        ZCZBarViewController*vc=[[ZCZBarViewController alloc]initWithIsQRCode:NO Block:^(NSString *result, BOOL isFinish) {
            if (isFinish) {
                CodeAndDeliveryViewController* vc = [[CodeAndDeliveryViewController alloc] init];
                vc.code = result;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }];
        [self presentViewController:vc animated:YES completion:nil];
    }else if (101 == index){
        NewOnTheRecyclingIndexViewController* vc = [[NewOnTheRecyclingIndexViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (102 == index){
        RecyclingMapViewController* vc = [[RecyclingMapViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (103 == index){
        GiftExchangeViewController* vc = [[GiftExchangeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (104 == index){
        MyICCardViewController* vc = [[MyICCardViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (105 == index){
        PersonalCenterViewController* vc = [[PersonalCenterViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)wodeduihuan{
    MyChangeViewController* vc = [[MyChangeViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)wodetoudi{
    MyDeliveryViewController* vc = [[MyDeliveryViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)indexSeleAD:(NSInteger)index{
    IndexS0Model* s0Model = [self.datasourceArr0 lastObject];
    if (0 == [s0Model.typeArr[index] intValue]) {
        AboutUsViewController* vc = [[AboutUsViewController alloc] init];
        vc.urlString = s0Model.srcurlArr[index];
        vc.title = @"详情";
        [self.navigationController pushViewController:vc animated:YES];
    }else if (1 == [s0Model.typeArr[index] intValue]){
        PicReviewViewController* vc = [[PicReviewViewController alloc] init];
        NSArray* temA = [s0Model.picArr[index] componentsSeparatedByString:@","];
        vc.pictureArr = temA;
        vc.dangqianSelect = 0;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (2 == [s0Model.typeArr[index] intValue]){
        GiftDetailViewController* vc = [[GiftDetailViewController alloc] init];
        vc.presentId = s0Model.gilfidArr[index];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, [MyController isIOS7], self.view.frame.size.width, self.view.frame.size.height - [MyController isIOS7]) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    UIImageView *tableBg = [[UIImageView alloc] initWithImage:nil];
    tableBg.backgroundColor = [UIColor whiteColor];
    [_tableView setBackgroundView:tableBg];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_tableView];
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self headRefresh];
    }];
}
- (void)headRefresh{
    [self createIndexPageRequest];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (0 == section) {
        return self.datasourceArr0.count;
    }
    return self.datasourceArr1.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        IndexS0Cell* celll = [[IndexS0Cell alloc] init];
        celll.IndexS0CellDelegate = self;
        celll.selectionStyle = UITableViewCellSelectionStyleNone;
        IndexS0Model* model = self.datasourceArr0[indexPath.row];
        [celll configCellWithModel:model];
        return celll;
    }
    IndexS1Cell* celll = [[IndexS1Cell alloc] init];
    celll.IndexS1CellDelegate = self;
    celll.selectionStyle = UITableViewCellSelectionStyleNone;
    IndexS1Model* model = self.datasourceArr1[indexPath.row];
    [celll configCellWithModel:model];
    return celll;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (0 == indexPath.section) {
        IndexS0Model *model = nil;
        if (indexPath.row < self.datasourceArr0.count) {
            model = [self.datasourceArr0 objectAtIndex:indexPath.row];
        }
        return [IndexS0Cell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
            IndexS0Cell *cell = (IndexS0Cell *)sourceCell;
            [cell configCellWithModel:model];
        }];
    }
    
    IndexS1Model *model = nil;
    if (indexPath.row < self.datasourceArr1.count) {
        model = [self.datasourceArr1 objectAtIndex:indexPath.row];
    }
    return [IndexS1Cell hyb_heightForIndexPath:indexPath config:^(UITableViewCell *sourceCell) {
        IndexS1Cell *cell = (IndexS1Cell *)sourceCell;
        [cell configCellWithModel:model];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (void)createIndexPageRequest{
    NSString* requestAddress = FIRSTPAGEURL;
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestAddress parameters:@{
                                              @"userid":self.userid
                                              }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              if ([[responseObject objectForKey:@"result"] intValue]) {
                  [HUD hide];
                  NSString *dataStr = [responseObject objectForKey:@"data"];
                  NSDictionary* temDic = [MyController dictionaryWithJsonString:dataStr];
                  [self.datasourceArr0 removeAllObjects];
                  [self.datasourceArr1 removeAllObjects];
                  
                  IndexS0Model* s0Model = [[IndexS0Model alloc] init];
                  s0Model.picArr = [[NSMutableArray alloc] init];
                  s0Model.srcurlArr = [[NSMutableArray alloc] init];
                  s0Model.typeArr = [[NSMutableArray alloc] init];
                  s0Model.gilfidArr = [[NSMutableArray alloc] init];
                  NSArray* temPicA = temDic[@"img"];
                  for (NSDictionary* dic in temPicA) {
                      [s0Model.picArr addObject:dic[@"fileurl"]];
                      [s0Model.srcurlArr addObject:dic[@"srcurl"]];
                      [s0Model.typeArr addObject:dic[@"type"]];
                      [s0Model.gilfidArr addObject:dic[@"gilfid"]];
                  }
                  
                  [self.datasourceArr0 addObject:s0Model];
                  
                  IndexS1Model* s1Model = [[IndexS1Model alloc] init];
                  
                  s1Model.huishouxiangCountStr = temDic[@"totalBox"];
                  
                  s1Model.yiwuCountStr = temDic[@"totalPoints"];;
                  
                  [self.datasourceArr1 addObject:s1Model];
                  
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
              [_tableView reloadData];
              [_tableView.header endRefreshing];
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"请检查网络"];
              //下拉刷新停止
              [_tableView.header endRefreshing];
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
