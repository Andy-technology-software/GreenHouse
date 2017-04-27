//
//  nextNewOnTheDoorViewController.m
//  AndyCoder
//
//  Created by lingnet on 16/7/25.
//  Copyright © 2016年 Andy. All rights reserved.
//

#import "nextNewOnTheDoorViewController.h"

#import "JiuwuDetailViewController.h"

#import "JiuwuDetailModel.h"
@interface nextNewOnTheDoorViewController ()
@property(nonatomic,assign)NSInteger cellSelect;
@property(nonatomic,copy)NSString* userid;
@end

@implementation nextNewOnTheDoorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.userid = [MyController getUserid];
    
    self.imageDataSourceArr = [[NSMutableArray alloc] init];
    self.titleDataSourceArr = [[NSMutableArray alloc] init];
    self.idDataSourceArr = [[NSMutableArray alloc] init];
    self.gilfstyleDataSourceArr = [[NSMutableArray alloc] init];
    self.guigeDataSourceArr = [[NSMutableArray alloc] init];
    self.pointDataSourceArr = [[NSMutableArray alloc] init];
}

- (void)viewWillAppear:(BOOL)animated{
    [self createJiuwucheRequest];
}
- (void)makeData{
    for (int i = 0; i < 20; i++) {
        [self.imageDataSourceArr addObject:@"https://img.mdcdn.cn/ImageStore/106602/pic/3d9c46bd5bc00f17A20969/3d9c46bd5bc00f17A20969_530*530.jpg"];
        [self.titleDataSourceArr addObject:@"立式空调"];
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.cellSelect = indexPath.item;
    self.title = self.titleDataSourceArr[indexPath.item];
    self.idStr = self.idDataSourceArr[indexPath.item];
    [self createRequest];
    [HUD loading];
}
- (void)createRequest{
    NSString* requestUrl = HUOQUFENLEIRULE;
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestUrl parameters:@{
                                          @"id":self.idStr
                                          }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSArray* sourceArr = [MyController arraryWithJsonString:responseObject[@"data"]];
              if ([responseObject[@"result"] intValue]) {
                  [HUD hide];
                  if (sourceArr.count) {
                      [self.idDataSourceArr removeAllObjects];
                      [self.titleDataSourceArr removeAllObjects];
                      [self.imageDataSourceArr removeAllObjects];
                      [self.gilfstyleDataSourceArr removeAllObjects];
                      [self.guigeDataSourceArr removeAllObjects];
                      [self.pointDataSourceArr removeAllObjects];
                      for (NSDictionary* dic in sourceArr) {
                          [self.imageDataSourceArr addObject:dic[@"imgurl"]];
                          [self.titleDataSourceArr addObject:dic[@"gilfstyle"]];
                          [self.idDataSourceArr addObject:dic[@"id"]];
                          [self.gilfstyleDataSourceArr addObject:dic[@"id"]];
                          [self.guigeDataSourceArr addObject:dic[@"guige"]];
                          [self.pointDataSourceArr addObject:dic[@"point"]];
                      }
                      [self.collectionView reloadData];
                  }else{
                      JiuwuDetailViewController* vc = [[JiuwuDetailViewController alloc] init];
                      vc.jiuwuModel = [[JiuwuDetailModel alloc] init];
                      vc.jiuwuModel.topImageStr = self.imageDataSourceArr[self.cellSelect];
                      vc.jiuwuModel.titleStr = self.titleDataSourceArr[self.cellSelect];
                      vc.jiuwuModel.jianStr = @"";
                      vc.jiuwuModel.jifenStr = @"";
                      vc.jiuwuModel.guigeStr = self.guigeDataSourceArr[self.cellSelect];
                      vc.gilfstyle = self.gilfstyleDataSourceArr[self.cellSelect];
                      vc.guige = self.guigeDataSourceArr[self.cellSelect];
                      vc.point = self.pointDataSourceArr[self.cellSelect];
                      
                      [self.navigationController pushViewController:vc animated:YES];
                  }
              }else{
                  NSString *errStr = [responseObject objectForKey:@"error"];
                  NSDictionary *dic = [MyController dictionaryWithJsonString:errStr];
                  [HUD error:[dic objectForKey:@"errorInfo"]];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [HUD error:@"加载失败"];
          }];
}
- (void)createJiuwucheRequest{
    NSString* requestUrl = CARLIST;
    requestUrl = [requestUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/json",@"text/html",nil];
    [manager POST:requestUrl parameters:@{
                                          @"userid":self.userid,
                                          @"pnum":@"1",
                                          @"num":@"10"
                                          }
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              NSData *jsonData = [[responseObject objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
              NSArray *sourceArr = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
              if (sourceArr.count) {
                  [rightButton1 setImage:[UIImage imageNamed:@"shopcar_red"]forState:UIControlStateNormal];
              }else{
                  [rightButton1 setImage:[UIImage imageNamed:@"shopcar"]forState:UIControlStateNormal];
              }
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
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
