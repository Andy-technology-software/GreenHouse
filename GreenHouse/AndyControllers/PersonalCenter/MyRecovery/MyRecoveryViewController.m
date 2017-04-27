//
//  MyRecoveryViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/6/24.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "MyRecoveryViewController.h"

#import "MyRecoveryDetailViewController.h"
@interface MyRecoveryViewController ()

@end

@implementation MyRecoveryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的回收";
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MyPointsModel* model = self.datasourceArr[indexPath.row];
    MyRecoveryDetailViewController* vc = [[MyRecoveryDetailViewController alloc] init];
    vc.idStr = model.idStr;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)createRequest{
    self.userid = [MyController getUserid];
    NSLog(@"-----%@",self.userid);
    NSString* requestUrl = MYBACKSURL;
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestUrl parameters:@{
                                          @"userid":self.userid,
                                          @"pnum":[NSString stringWithFormat:@"%ld",(long)self.pageIndex],
                                          @"num":@"10"
                                          }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSData *jsonData = [[responseObject objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
              NSArray *sourceArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
              NSMutableArray *_array = [NSMutableArray arrayWithCapacity:0];
              if (![sourceArr isKindOfClass:[NSNull class]]) {
                  for (NSDictionary* dic in sourceArr) {
                      MyPointsModel* model = [[MyPointsModel alloc] init];
                      model.jifenStr = [NSString stringWithFormat:@"%2.f",[dic[@"totalPoint"] floatValue]];
                      model.titleStr = dic[@"createDate"];
                      model.isFromBack = YES;
                      model.timeStr = dic[@"state"];//@"2010 01-01 10:23";
                      model.idStr= dic[@"id"];
                      [_array addObject:model];
                  }
                  if (self.pageIndex == 1) {
                      [self.datasourceArr removeAllObjects];
                      [self.datasourceArr addObjectsFromArray:_array];
                      [_tableView reloadData];
                      [_tableView.header endRefreshing];
                  }else {
                      [self.datasourceArr addObjectsFromArray:_array];
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
              NSLog(@"失败===%@", error);
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
